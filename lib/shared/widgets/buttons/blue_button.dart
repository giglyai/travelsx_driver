// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/imagePath/image_paths.dart';
import '../size_config/size_config.dart';

class BlueButton extends StatelessWidget {
  GestureTapCallback? onTap;
  bool wantMargin;
  String? title;
  double? borderRadius;
  double? height;
  final double? fontSize;
  final double? width;
  Color? buttonColor;
  Color? textColor;
  final Color? loadingButtonColor;
  bool isLoading;

  bool buttonIsEnabled;
  Color? borderColor;
  BlueButton({
    Key? key,
    this.buttonIsEnabled = true,
    this.isLoading = false,
    this.loadingButtonColor,
    this.onTap,
    this.wantMargin = true,
    this.title,
    this.borderRadius,
    this.height,
    this.fontSize,
    this.width,
    this.buttonColor,
    this.textColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ((buttonIsEnabled == false) || isLoading == true) ? null : onTap,
      child: Container(
        margin:
            wantMargin
                ? EdgeInsets.only(
                  left: 21 * SizeConfig.widthMultiplier!,
                  right: 24 * SizeConfig.widthMultiplier!,
                )
                : EdgeInsets.zero,
        width: width ?? 330 * SizeConfig.widthMultiplier!,
        height: height ?? 56 * SizeConfig.heightMultiplier!,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? AppColors.transparent),

          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 10,
              color: const Color(0xff000000).withOpacity(0.2),
            ),
          ],
          borderRadius: BorderRadius.circular(
            borderRadius ?? (8 * SizeConfig.widthMultiplier!),
          ),
          color:
              buttonIsEnabled == false
                  ? AppColors.kGrey8C8C8C
                  : (loadingButtonColor != null && isLoading == true
                      ? loadingButtonColor
                      : buttonColor ?? AppColors.kBlue3D6),
        ),
        child: Center(
          child:
              isLoading
                  ? Image.asset(
                    ImagePath.loaderImage,
                    width: 80 * SizeConfig.widthMultiplier!,
                  )
                  : Text(
                    title != null ? title ?? '' : "continue".tr,
                    style: TextStyle(
                      color: textColor ?? AppColors.kWhite,
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.textMultiplier! * (fontSize ?? 15.0),
                    ),
                  ),
        ),
      ),
    );
  }
}
