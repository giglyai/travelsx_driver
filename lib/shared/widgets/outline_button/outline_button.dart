// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/imagePath/image_paths.dart';
import '../size_config/size_config.dart';

class CustomOutlineButton extends StatelessWidget {
  bool buttonIsEnabled;
  GestureTapCallback? onTap;
  bool isLoading;
  bool wantMargin;

  String? title;
  double? borderRadius;
  double? height;
  double? width;

  Color? borderColor;
  Color? titleColor;
  Color? buttonColor;
  double? borderWidth;
  final Color? loadingButtonColor;

  CustomOutlineButton({
    Key? key,
    this.buttonIsEnabled = true,
    this.onTap,
    this.isLoading = false,
    this.wantMargin = true,
    this.borderColor,
    this.title,
    this.titleColor,
    this.buttonColor,
    this.borderRadius,
    this.height,
    this.borderWidth,
    this.loadingButtonColor,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        border: Border.all(
          color: borderColor ?? AppColors.kBlue3D6,
          width: borderWidth ?? 0,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius ?? (4 * SizeConfig.widthMultiplier!),
        ),
        color:
            !buttonIsEnabled
                ? AppColors.whiteF3F5
                : (loadingButtonColor != null && isLoading == true
                    ? loadingButtonColor
                    : buttonColor ?? AppColors.kWhite),
      ),
      child: Stack(
        children: [
          Center(
            child:
                isLoading
                    ? Image.asset(
                      ImagePath.loaderImage,
                      width: 80 * SizeConfig.widthMultiplier!,
                    )
                    : Text(
                      title != null ? title ?? '' : "Cancel",
                      style: TextStyle(
                        color: titleColor ?? AppColors.kBlue3D6,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.textMultiplier! * 16.0,
                      ),
                    ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  4 * SizeConfig.widthMultiplier!,
                ),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
