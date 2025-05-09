import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/imagePath/image_paths.dart';
import '../size_config/size_config.dart';

class DriverHomeWidgets {
  Widget buildAvailableRiderColumn(BuildContext context) {
    return Column(
      children: [
        buildLottieAnimation(),
        Center(
          child: Text(
            "Wait Wer’e  finding Rides for you...",
            style: TextStyle(
                color: AppColors.kBlackTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 14 * SizeConfig.textMultiplier!),
          ),
        ),
      ],
    );
  }

  Widget buildLottieAnimation() {
    return Center(
      child: Lottie.asset(
        ImagePath.tripRideLoaderAnim,
        height: 185 * SizeConfig.heightMultiplier!,
      ),
    );
  }

  Widget buildUnavailableRiderColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        divider(),
        SizedBox(
          height: 19 * SizeConfig.heightMultiplier!,
        ),
        Text(
          "Go online to find trips for you ",
          style: TextStyle(
            color: AppColors.kBlackTextColor.withOpacity(0.5),
            fontWeight: FontWeight.w500,
            fontSize: 16 * SizeConfig.textMultiplier!,
          ),
        ),
        SizedBox(
          height: 19 * SizeConfig.heightMultiplier!,
        ),
        divider(),
        SizedBox(
          height: 50 * SizeConfig.heightMultiplier!,
        ),
      ],
    );
  }

  divider() {
    return Divider(
      endIndent: 26 * SizeConfig.widthMultiplier!,
      indent: 26 * SizeConfig.widthMultiplier!,
      thickness: 0.4 * SizeConfig.widthMultiplier!,
      color: AppColors.kBlackTextColor.withOpacity(0.61),
    );
  }

  Widget buildUseAbleRow(
      {required String title,
      required String subTitle,
      required BuildContext context}) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title ?? "",
            style: TextStyle(
                color: AppColors.kBlackTextColor.withOpacity(0.50),
                fontWeight: FontWeight.w400,
                fontSize: 14 * SizeConfig.textMultiplier!),
          ),
          Center(
            child: Text(
              subTitle ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.kBlackTextColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13 * SizeConfig.textMultiplier!),
            ),
          ),
        ],
      ),
    );
  }
}
