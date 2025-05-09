import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';
import '../size_config/size_config.dart';

class CustomToolTip extends StatelessWidget {
  final Gradient? gradient;
  final Color? legendColor;
  final String label;
  final String value;
  final Color? bgColor;
  CustomToolTip(
      {super.key,
      this.gradient,
      this.legendColor,
      this.bgColor = AppColors.kGrey7B7B,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 92 * SizeConfig.widthMultiplier!,
      constraints: BoxConstraints(
          minWidth: 92 * SizeConfig.widthMultiplier!,
          maxWidth: 150 * SizeConfig.widthMultiplier!),
      padding: EdgeInsets.symmetric(
          horizontal: 12 * SizeConfig.widthMultiplier!,
          vertical: 8 * SizeConfig.heightMultiplier!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5 * SizeConfig.widthMultiplier!),
        color: bgColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4 * SizeConfig.heightMultiplier!),
            width: 8 * SizeConfig.widthMultiplier!,
            height: 8 * SizeConfig.heightMultiplier!,
            decoration: legendColor != null
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: legendColor)
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(5), gradient: gradient),
          ),
          SizedBox(
            width: 5 * SizeConfig.widthMultiplier!,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                ),
                Text(
                  value,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
