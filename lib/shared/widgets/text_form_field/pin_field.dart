import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_styles/app_styles.dart';
import '../size_config/size_config.dart';

class CustomPinTextField extends StatefulWidget {
  final int? pinMaxLength;
  CustomPinTextField(
      {Key? key,
      this.pinController,
      this.obscureText,
      this.wantActiveColor,
      this.pinMaxLength,
      this.wantToHideObscure,
      this.errorController,
      this.hideBorders,
      this.onCompleted,
      this.wantPadding = true,
      this.fieldHeight,
      this.fieldWidth,
      this.fontSize})
      : super(key: key);

  ///this will store pin value of pin text field
  final TextEditingController? pinController;

  /// this will hide unHide pin value
  final bool? obscureText;

  ///this will change the color of pin textField active field
  final bool? wantActiveColor;

  ///this variable control error value and animate the pin field
  final StreamController<ErrorAnimationType>? errorController;

  final bool? wantToHideObscure;

  final bool? hideBorders;

  void Function(String)? onCompleted;

  bool? wantPadding;
  double? fieldHeight;
  double? fieldWidth;
  double? fontSize;

  @override
  State<CustomPinTextField> createState() => _CustomPinTextFieldState();
}

class _CustomPinTextFieldState extends State<CustomPinTextField> {
  late List<List<dynamic>> keys;
  late String pin;

  ///this is for pin filed length
  ///Default is 6
  int? pinLength;

  String otpText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.wantPadding == false
          ? EdgeInsets.zero
          : EdgeInsets.only(
              left: 20 * SizeConfig.widthMultiplier!,
              right: 41 * SizeConfig.widthMultiplier!),
      child: PinCodeTextField(
        errorAnimationController: widget.errorController,
        enableActiveFill: true,
        textStyle: AppTextStyle.text30blue3350DBW700?.copyWith(
            fontSize: widget.fontSize ?? 20 * SizeConfig.textMultiplier!),
        animationType: AnimationType.none,
        obscuringWidget: widget.wantToHideObscure == true ? Container() : null,
        animationDuration: Duration.zero,
        autoDisposeControllers: false,
        showCursor: false,
        keyboardType:
            const TextInputType.numberWithOptions(signed: false, decimal: true),
        pinTheme: PinTheme(
            selectedColor: AppColors.kBlackTextColor,
            selectedFillColor: AppColors.kWhiteF8F8F8,
            inactiveColor: widget.hideBorders == true
                ? Colors.transparent
                : AppColors.kGrey7B7B,
            errorBorderColor: AppColors.kRed4E18,
            shape: PinCodeFieldShape.box,
            fieldHeight:
                widget.fieldHeight ?? 44 * SizeConfig.heightMultiplier!,
            fieldWidth: widget.fieldWidth ?? 41 * SizeConfig.widthMultiplier!,
            activeFillColor: AppColors.kWhiteF8F8F8,
            inactiveFillColor: AppColors.kWhiteF8F8F8,
            borderRadius:
                BorderRadius.circular(8 * SizeConfig.widthMultiplier!),
            activeColor: widget.hideBorders == true
                ? Colors.transparent
                : AppColors.kBlackTextColor,
            borderWidth: 1),
        controller: widget.pinController,
        obscureText: widget.obscureText == true,
        onChanged: (String value) {
          setState(() {
            otpText = value;
          });
        },
        onCompleted: widget.onCompleted,
        appContext: (context),
        length: widget.pinMaxLength ?? 6,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
      ),
    );
  }
}
