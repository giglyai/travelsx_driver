import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/config/config.dart';
import 'package:travelx_driver/login/bloc/login_cubit.dart';
import 'package:travelx_driver/login/bloc/login_state.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/widgets/container_with_border/container_with_border.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';

import '../../../../../shared/widgets/text_form_field/pin_field.dart';

class VerifyOtpBottomSheetHelper {
  static void show(
    BuildContext context,
    String countryCode,
    String mobileNumber,
    String email,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Ensures the bottom sheet resizes properly
      backgroundColor: AppColors.kWhite,
      builder: (context) {
        return VerifyOtpBottomSheet(
          countryCode: countryCode,
          mobileController: mobileNumber,
          email: email,
        );
      },
    );
  }
}

class VerifyOtpBottomSheet extends StatefulWidget {
  const VerifyOtpBottomSheet({
    Key? key,
    required this.countryCode,
    required this.mobileController,
    required this.email,
  }) : super(key: key);

  final String countryCode;
  final String mobileController;
  final String email;

  @override
  _VerifyOtpBottomSheetState createState() => _VerifyOtpBottomSheetState();
}

class _VerifyOtpBottomSheetState extends State<VerifyOtpBottomSheet> {
  late TextEditingController textEditingController1;
  FocusNode focusNode = FocusNode();
  late ServiceLoginCubit _loginCubit;
  String platForm = '';

  void getPlatform() {
    if (Platform.isAndroid) {
      platForm = 'android';
    } else if (Platform.isIOS) {
      platForm = 'ios';
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of<ServiceLoginCubit>(context);
    textEditingController1 = TextEditingController();
    getPlatform();
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ), // Adjusts for keyboard height
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: RideBackButton(padding: EdgeInsets.zero),
              ),
              CustomSizedBox(height: 10),
              Text("Enter OTP", style: AppTextStyle.text20black0000W600),
              CustomSizedBox(height: 20),
              CustomPinTextField(
                wantPadding: false,
                pinController: textEditingController1,
                obscureText: false,
                onCompleted: (v) async {
                  _loginCubit.bottomSheetVerifyOtp(
                    platForm: platForm,
                    countryCode: widget.countryCode,
                    phoneNumber: widget.mobileController,
                    otp: textEditingController1.text,
                    clientToken: AppConfig.getClientToken(),
                    appName: AppNames.appName,
                    email: widget.email,
                  );
                  textEditingController1.clear();
                },
                pinMaxLength: 6,
              ),
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
              CustomSizedBox(height: 15),
              BlocConsumer<ServiceLoginCubit, LoginState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          AnywhereDoor.pop(context);
                        },
                        child: ContainerWithBorder(
                          borderColor: AppColors.kBlue3D6,
                          borderRadius: 6,
                          child: Text(
                            "Change phone number",
                            style: AppTextStyle.text12Bblack0000W500,
                          ),
                        ),
                      ),
                      CustomSizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          _loginCubit.loginWithMobileNumber(
                            countryCode: widget.countryCode,
                            phoneNumber: widget.mobileController,
                            email: widget.email,
                          );
                        },
                        child: ContainerWithBorder(
                          borderColor: AppColors.kRedDF0000,
                          containerColor: AppColors.kRedDF0000,
                          borderRadius: 6,
                          child: Text(
                            "Resend OTP",
                            style: AppTextStyle.text12kWhiteW500,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              CustomSizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
