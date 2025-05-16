// ignore_for_file: library_private_types_in_public_api

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/config/config.dart';
import 'package:travelx_driver/flavors.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';

import '../../../../shared/constants/app_colors/app_colors.dart';
import '../../../../shared/constants/app_styles/app_styles.dart';
import '../../../../shared/constants/imagePath/image_paths.dart';
import '../../../../shared/widgets/container_with_border/container_with_border.dart';
import '../../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../../shared/widgets/size_config/size_config.dart';
import '../../../../shared/widgets/text_form_field/pin_field.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';

class VerifyOtpScreen extends StatefulWidget {
  /// Constructor for [VerifyOtpScreen].
  const VerifyOtpScreen({
    super.key,
    required this.countryCode,
    required this.mobileController,
    required this.email,
  });

  /// The country code for the user's phone number (e.g., "+91").
  final String countryCode;

  /// The user's mobile number.
  final String mobileController;

  final String email;

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  /// Controller for the OTP text field.
  late TextEditingController textEditingController1;

  /// FocusNode to manage focus for the OTP text field.
  FocusNode focusNode = FocusNode();

  /// Cubit for handling login actions and state management.
  late ServiceLoginCubit _loginCubit;

  /// Tracks whether to show options for changing phone or resending OTP.
  bool changePhoneOrResendOtp = false;

  /// Stores the current platform ("android" or "ios").
  String platForm = '';

  /// Determines the current platform and sets the [platForm] variable.
  void getPlatForm() {
    if (Platform.isAndroid) {
      platForm = 'android';
    } else if (Platform.isIOS) {
      platForm = 'ios';
    }
    setState(() {});
  }

  @override
  void dispose() {
    /// Dispose of the text controller and other resources.
    print("unregisterListener");
    textEditingController1.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// Initialize the login cubit and text controller.
    _loginCubit = BlocProvider.of<ServiceLoginCubit>(context);
    textEditingController1 = TextEditingController();

    /// Get the current platform.
    getPlatForm();
  }

  @override
  Widget build(BuildContext context) {
    /// Get the screen size for layout calculations.
    final Size size = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            /// Background image for the screen.
            image: DecorationImage(
              image: AssetImage(ImagePath.splashBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 34 * SizeConfig.heightMultiplier!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// iOS-specific back button.
                if (Platform.isIOS)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RideBackButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),

                CustomSizedBox(
                  width: 50 * SizeConfig.widthMultiplier!,
                  height: 50 * SizeConfig.heightMultiplier!,
                ),

                const Spacer(),

                if (F.appFlavor == Flavor.kurinjidriver)
                  ImageLoader.assetImage(
                    imagePath: ImagePath.splashKurinjiIcon,
                    height: 200 * SizeConfig.heightMultiplier!,
                    width: 196 * SizeConfig.widthMultiplier!,
                  )
                else if (F.appFlavor == Flavor.travelsxdriver)
                  ImageLoader.assetImage(
                    imagePath: ImagePath.splashTravelsxIcon,
                    height: 200 * SizeConfig.heightMultiplier!,
                    width: 196 * SizeConfig.widthMultiplier!,
                  )
                else
                  ImageLoader.svgPictureAssetImage(
                    imagePath: ImagePath.giglyDriverSplashLogoFinal,
                    height: 110 * SizeConfig.heightMultiplier!,
                    width: 196 * SizeConfig.widthMultiplier!,
                  ),
                const Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// OTP input header.
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20 * SizeConfig.widthMultiplier!,
                      ),
                      child: Text(
                        "Enter OTP",
                        style: AppTextStyle.text20kBlackTextColorW600,
                      ),
                    ),

                    SizedBox(height: 20 * SizeConfig.heightMultiplier!),

                    /// Custom OTP input field.
                    CustomPinTextField(
                      pinController: textEditingController1,
                      obscureText: false,
                      onCompleted: (v) async {
                        /// Call the cubit to verify OTP.
                        _loginCubit.verifyOtp(
                          email: widget.email,
                          platForm: platForm,
                          countryCode: widget.countryCode,
                          phoneNumber: widget.mobileController,
                          otp: textEditingController1.text,
                          clientToken: AppConfig.getClientToken(),
                          appName: AppNames.appName,
                        );

                        /// Clear the OTP field after submission.
                        textEditingController1.clear();
                      },
                      pinMaxLength: 6,
                    ),

                    /// Show error message if OTP verification fails.
                    BlocBuilder<ServiceLoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is OtpFailure) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 20 * SizeConfig.widthMultiplier!,
                            ),
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

                    /// Options for resending OTP or changing the phone number.
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
                                      RouteName.mobileNumberLoginScreen,
                                    );
                                  },
                                  child: ContainerWithBorder(
                                    borderColor: AppColors.kBlue3D6,
                                    borderRadius:
                                        6 * SizeConfig.widthMultiplier!,
                                    child: Text(
                                      (widget.email?.isNotEmpty ?? false)
                                          ? "Change email"
                                          : "Change phone number",
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
                                        email: widget.email,
                                      );
                                    },
                                    child: Text(
                                      "Resend OTP",
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
                              /// Disabled button for changing the phone number or email
                              ContainerWithBorder(
                                borderColor: AppColors.kBlackTextColor
                                    .withOpacity(0.40),
                                borderRadius: 6 * SizeConfig.widthMultiplier!,
                                child: Text(
                                  (widget.email?.isNotEmpty ?? false)
                                      ? "Change email"
                                      : "Change phone number",
                                  style: TextStyle(
                                    fontSize: 12 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.40),
                                  ),
                                ),
                              ),

                              CustomSizedBox(width: 10),

                              /// Disabled button for resending OTP.
                              ContainerWithBorder(
                                borderColor: AppColors.kBlackTextColor
                                    .withOpacity(0.40),
                                borderRadius: 6 * SizeConfig.widthMultiplier!,
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    fontSize: 12 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.40),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    CustomSizedBox(height: 10 * SizeConfig.heightMultiplier!),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
