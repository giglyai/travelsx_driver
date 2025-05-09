import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors/app_colors.dart';
import '../size_config/size_config.dart';

class CircularIconButton extends StatelessWidget {
  final void Function()? onTap;
  final String svgIconPath;
  const CircularIconButton({super.key, this.onTap, required this.svgIconPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50 * SizeConfig.heightMultiplier!,
        width: 48 * SizeConfig.widthMultiplier!,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColors.kWhite),
        child: Center(child: SvgPicture.asset(svgIconPath)),
      ),
    );
  }
}
