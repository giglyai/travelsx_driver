// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/widgets/size_config/size_config.dart';

class ContainerWithBorder extends StatelessWidget {
  ContainerWithBorder({
    super.key,
    this.child,
    this.borderColor,
    this.width,
    this.borderRadius,
    this.borderWidth,
    this.height,
    this.containerColor,
    this.wantPadding = false,
  });

  Widget? child;
  Color? borderColor;
  Color? containerColor;
  double? width;
  double? height;
  double? borderRadius;

  double? borderWidth;
  bool? wantPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: wantPadding == true
          ? EdgeInsets.zero
          : EdgeInsets.only(
              left: 10 * SizeConfig.widthMultiplier!,
              right: 10 * SizeConfig.widthMultiplier!,
              bottom: 10 * SizeConfig.heightMultiplier!,
              top: 10 * SizeConfig.heightMultiplier!,
            ),
      decoration: BoxDecoration(
        color: containerColor ?? AppColors.kWhite,
        borderRadius: BorderRadius.circular(
            borderRadius ?? 50 * SizeConfig.widthMultiplier!),
        border: Border.all(
            color: borderColor ?? AppColors.kBlue3D6, width: borderWidth ?? 0),
      ),
      child: child,
    );
  }
}
