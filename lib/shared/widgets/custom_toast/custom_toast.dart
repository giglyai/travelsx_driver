import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors/app_colors.dart';
import '../size_config/size_config.dart';

class CustomToastUtils {
  static showToast(
      {String? title,
      required BuildContext context,
      Color? toastColor,
      String? imagePath}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.up,
      backgroundColor: AppColors.kWhite,
      content: Row(
        children: [
          Center(
            child: Container(
              color: toastColor,
              width: 10 * SizeConfig.widthMultiplier!,
              height: 50 * SizeConfig.heightMultiplier!,
              margin: EdgeInsets.zero,
            ),
          ),
          SizedBox(
            width: 16 * SizeConfig.widthMultiplier!,
          ),
          SvgPicture.asset(imagePath ?? ""),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20 * SizeConfig.widthMultiplier!),
              child: Text(
                title ?? '',
                style: TextStyle(
                    color: AppColors.kBlackTextColor,
                    fontSize: 14 * SizeConfig.textMultiplier!,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5 * SizeConfig.widthMultiplier!),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 130,
          right: 20 * SizeConfig.widthMultiplier!,
          left: 20 * SizeConfig.heightMultiplier!),
    ));
  }
}
