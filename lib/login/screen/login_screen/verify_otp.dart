// ignore_for_file: library_private_types_in_public_api

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/flavors.dart';
import 'package:travelx_driver/home/screen/new_home_screen.dart';
import 'package:travelx_driver/login/bloc/login_cubit.dart';
import 'package:travelx_driver/login/bloc/login_state.dart';
import 'package:travelx_driver/shared/constants/imagePath/jpdriver/jp_image_paths.dart';
import 'package:travelx_driver/shared/constants/imagePath/prithavi/prithavi_image_paths.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';

import '../../../config/config.dart';
import '../../../home/widget/container_with_border/container_with_border.dart';
import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/app_styles/app_styles.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/local_storage/auth_repository.dart';
import '../../../shared/local_storage/user_repository.dart';
import '../../../shared/utils/image_loader/image_loader.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/google_map/google-map.widget.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../../../shared/widgets/text_form_field/pin_field.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({
    Key? key,
    required this.countryCode,
    required this.mobileController,
  }) : super(key: key);

  final String countryCode;
  final String mobileController;

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late TextEditingController textEditingController1;

  String _comingSms = 'Unknown';

  FocusNode focusNode = FocusNode();

  // Future<void> initSmsListener() async {
  //   String? comingSms;
  //   try {
  //     comingSms = await AltSmsAutofill().listenForSms;
  //   } on PlatformException {
  //     comingSms = 'Failed to get Sms.';
  //   }
  //
  //   setState(() {
  //     _comingSms = comingSms!;
  //     textEditingController1.text = _comingSms[35] +
  //         _comingSms[36] +
  //         _comingSms[37] +
  //         _comingSms[38] +
  //         _comingSms[39] +
  //         _comingSms[
  //             40]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
  //   });
  // }

  bool isPhone(String input) => RegExp(
    r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
  ).hasMatch(input);
  late ServiceLoginCubit _loginCubit;

  bool changePhoneOrResendOtp = false;
  String platform = '';

  getPlatForm() {
    if (Platform.isAndroid) {
      platform = 'android';
      setState(() {});
    } else if (Platform.isIOS) {
      platform = 'ios';
      setState(() {});
    }
  }

  @override
  void dispose() {
    print("unregisterListener");
    textEditingController1.dispose();
    // AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  final _googleMapWidgetStateKey = GlobalKey<GoogleMapWidgetState>();

  @override
  void initState() {
    _loginCubit = BlocProvider.of<ServiceLoginCubit>(context);
    textEditingController1 = TextEditingController();
    // initSmsListener();
    getPlatForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashScreenBack),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 34 * SizeConfig.heightMultiplier!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSizedBox(
                width: 50 * SizeConfig.widthMultiplier!,
                height: 50 * SizeConfig.heightMultiplier!,
              ),
              const Spacer(),
              if (F.appFlavor == Flavor.kurinjidriver)
                ImageLoader.assetImage(
                  imagePath: ImagePath.splashBmtIcon,
                  height: 110 * SizeConfig.heightMultiplier!,
                  width: 196 * SizeConfig.widthMultiplier!,
                )
              else
                ImageLoader.svgPictureAssetImage(
                  height: 110 * SizeConfig.heightMultiplier!,
                  width: 196 * SizeConfig.widthMultiplier!,
                ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20 * SizeConfig.widthMultiplier!,
                    ),
                    child: Text(
                      "Enter OTP",
                      style: AppTextStyle.text20kWhiteW600,
                    ),
                  ),
                  SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                  CustomPinTextField(
                    pinController: textEditingController1,
                    obscureText: false,
                    onCompleted: (v) async {
                      _loginCubit.verifyOtp(
                        platform: platform,
                        countryCode: "91",
                        phoneNumber: widget.mobileController,
                        otp: textEditingController1.text,
                        clientToken: AppConfig.getClientToken(),
                        playerId: UserRepository.getDeviceToken,
                        user: 'driver-ride',
                        appName: AppName.getAppName(),
                      );
                      textEditingController1.clear();
                    },
                    pinMaxLength: 6,
                  ),

                  ///this widget show error message if user type wrong pin
                  BlocBuilder<ServiceLoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is OtpFailure) {
                        return Center(
                          child: Text(
                            state.errorMessage ?? "",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.text15red534ADW400,
                          ),
                        );
                      }

                      return Container();
                    },
                  ),
                  SizedBox(height: 15 * SizeConfig.heightMultiplier!),
                  BlocConsumer<ServiceLoginCubit, LoginState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is OtpFailure) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteName.mobileLoginScreen,
                                  );
                                },
                                child: ContainerWithBorder(
                                  borderColor: AppColors.kBlue3D6,
                                  borderRadius: 6 * SizeConfig.widthMultiplier!,
                                  child: Text(
                                    "Change phone number",
                                    style: AppTextStyle.text12black0000W500,
                                  ),
                                ),
                              ),
                              CustomSizedBox(width: 10),
                              ContainerWithBorder(
                                borderColor: AppColors.kRedDF0000,
                                containerColor: AppColors.kRedDF0000,
                                borderRadius: 6 * SizeConfig.widthMultiplier!,
                                child: GestureDetector(
                                  onTap: () {
                                    _loginCubit.loginWithMobileNumber(
                                      countryCode: widget.countryCode,
                                      phoneNumber: widget.mobileController,
                                    );
                                  },
                                  child: Text(
                                    "Resend OTP ",
                                    style: AppTextStyle.text12kWhiteW500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Padding(
                        padding: EdgeInsets.only(
                          left: 20 * SizeConfig.widthMultiplier!,
                        ),
                        child: Row(
                          children: [
                            ContainerWithBorder(
                              borderColor: AppColors.kBlackTextColor
                                  .withOpacity(0.40),
                              borderRadius: 6 * SizeConfig.widthMultiplier!,
                              child: Text(
                                "Change phone number",
                                style: TextStyle(
                                  fontSize: 12 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.kBlackTextColor.withOpacity(
                                    0.40,
                                  ),
                                ),
                              ),
                            ),
                            CustomSizedBox(width: 10),
                            ContainerWithBorder(
                              borderColor: AppColors.kBlackTextColor
                                  .withOpacity(0.40),
                              borderRadius: 6 * SizeConfig.widthMultiplier!,
                              child: Text(
                                "Resend OTP ",
                                style: TextStyle(
                                  fontSize: 12 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.kBlackTextColor.withOpacity(
                                    0.40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  BlocConsumer<ServiceLoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is OtpSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => NewHomeScreen(),
                          ),
                        );

                        AuthRepository.instance.init();
                        UserRepository.instance.init();
                      }
                    },
                    builder: (context, state) {
                      return SizedBox.shrink();
                    },
                  ),

                  CustomSizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
