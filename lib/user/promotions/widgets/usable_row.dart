// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/widgets/size_config/size_config.dart';

class UsableRow extends StatelessWidget {
  UsableRow(
      {Key? key, this.title, this.subTitle, this.textColor, this.fontWeight})
      : super(key: key);

  String? title;
  String? subTitle;

  Color? textColor;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20 * SizeConfig.heightMultiplier!),
      child: Row(
        children: [
          Text(
            title ?? "",
            style: TextStyle(
                color: textColor ?? AppColors.kBlackTextColor.withOpacity(0.60),
                fontSize: 16 * SizeConfig.textMultiplier!,
                fontWeight: fontWeight ?? FontWeight.w500),
          ),
          const Spacer(),
          Text(
            subTitle ?? "",
            style: TextStyle(
                color: AppColors.kBlackTextColor,
                fontSize: 16 * SizeConfig.textMultiplier!,
                fontWeight: fontWeight ?? FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
