import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/flavors.dart';
import 'package:travelx_driver/login/screen/login_screen/verify_otp.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/app_styles/app_styles.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/utils/image_loader/image_loader.dart';
import '../../../shared/widgets/buttons/blue_button.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../../bloc/login_cubit.dart';
import '../../bloc/login_state.dart';

class MobileNumberLoginScreen extends StatefulWidget {
  const MobileNumberLoginScreen({Key? key}) : super(key: key);

  @override
  _MobileNumberLoginScreenState createState() =>
      _MobileNumberLoginScreenState();
}

class _MobileNumberLoginScreenState extends State<MobileNumberLoginScreen> {
  TextEditingController phoneNumber = TextEditingController();
  GlobalKey<FormState> phoneNumberKey = GlobalKey<FormState>();
  // final FocusNode _phoneNumberFocusNode = FocusNode();
  DraggableScrollableController controller = DraggableScrollableController();

  bool isEmail(String input) => EmailValidator.validate(input);

  late ServiceLoginCubit _loginCubit;

  String? countryCode = "91";
  String? contactNumber;

  FocusNode focusNode = FocusNode();

  bool isLoginButtonEnabled = false;

  @override
  void dispose() {
    phoneNumber.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loginCubit = BlocProvider.of<ServiceLoginCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWheatF5DEB3,
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage(ImagePath.splashScreenBack),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 40 * SizeConfig.heightMultiplier!),
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
                  imagePath: ImagePath.splashKurinjiIcon,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20 * SizeConfig.widthMultiplier!,
                    ),
                    child: Text(
                      "Enter your phone number for Login",
                      style: AppTextStyle.text20kWhiteW600,
                    ),
                  ),
                  CustomSizedBox(height: 20),
                  //username and password screen
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20 * SizeConfig.widthMultiplier!,
                      right: 20 * SizeConfig.widthMultiplier!,
                    ),
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        if (hasFocus) {
                        } else {
                          phoneNumberKey.currentState!.validate();
                        }
                      },
                      child: Form(
                        key: phoneNumberKey,
                        child: Theme(
                          data: ThemeData(hintColor: const Color(0x33adadad)),
                          child: TextField(
                            autofillHints: const <String>[
                              AutofillHints.username,
                            ],
                            onSubmitted: (value) {
                              phoneNumberKey.currentState?.validate();
                            },
                            onChanged: (v) {
                              setState(() {});
                              if (v.length > 9) {
                                isLoginButtonEnabled = true;
                              } else {
                                isLoginButtonEnabled = false;
                              }
                            },
                            keyboardType: TextInputType.phone,
                            focusNode: focusNode,
                            textInputAction: TextInputAction.next,
                            controller: phoneNumber,
                            style: TextStyle(
                              color: AppColors.kBlackTextColor.withOpacity(
                                0.87,
                              ),
                              fontWeight: FontWeight.w600,
                              fontSize: 20 * SizeConfig.textMultiplier!,
                            ),
                            decoration: InputDecoration(
                              prefix: SizedBox(
                                width: 20 * SizeConfig.widthMultiplier!,
                              ),
                              hintStyle: AppTextStyle.text14kBlackTextColorW500,
                              hintText: "Enter your mobile number",
                              fillColor: AppColors.kWhiteFFFF,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5 * SizeConfig.widthMultiplier!,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.kWhiteFFFF,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5 * SizeConfig.widthMultiplier!,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.kWhiteFFFF,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  4 * SizeConfig.widthMultiplier!,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                  top: 10 * SizeConfig.heightMultiplier!,
                                  left: 15 * SizeConfig.widthMultiplier!,
                                ),
                                child: Text(
                                  "+91",
                                  style: TextStyle(
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.87),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20 * SizeConfig.textMultiplier!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomSizedBox(height: 30),

                  //logIn button
                  BlocConsumer<ServiceLoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is PhoneNumberSuccess) {
                        // CustomToastUtils.showToast(
                        //     title: state.message ?? '',
                        //     context: context,
                        //     imagePath: ImagePath.successIcon,
                        //     toastColor: AppColors.kGreenSuccess);
                        Navigator.pushNamed(
                          context,
                          RouteName.otpScreen,
                          arguments: VerifyOtpScreen(
                            countryCode: "$countryCode",
                            mobileController: phoneNumber.text,
                          ),
                        );
                      }

                      if (state is PhoneNumberFailure) {
                        // CustomToastUtils.showToast(
                        //     title: state.errorMessage ?? '',
                        //     context: context,
                        //     imagePath: ImagePath.errorIcon,
                        //     toastColor: AppColors.kRedFF355);
                      }
                    },
                    builder: (context, state) {
                      return BlueButton(
                        borderRadius: 4 * SizeConfig.widthMultiplier!,
                        title: "Continue",
                        isLoading: state is PhoneNumberLoading,
                        wantMargin: true,
                        buttonIsEnabled: isLoginButtonEnabled,
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (phoneNumberKey.currentState!.validate()) {
                            _loginCubit.loginWithMobileNumber(
                              countryCode: "$countryCode",
                              phoneNumber: phoneNumber.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
