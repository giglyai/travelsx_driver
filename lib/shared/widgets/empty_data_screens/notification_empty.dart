import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';

class NotificationEmpty extends StatelessWidget {
  NotificationEmpty({super.key, this.message});

  String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomSizedBox(
          height: 40,
        ),
        Icon(
          Icons.notifications,
          size: 87 * SizeConfig.widthMultiplier!,
          color: AppColors.kBlackTextColor.withOpacity(0.30),
        ),
        Text(message ?? 'No Notification!',
            style: AppTextStyle.text20kBlackTextColorW700.copyWith(
              color: AppColors.kBlackTextColor.withOpacity(0.70),
            )),
        CustomSizedBox(
          height: 17,
        ),
        Center(
          child: Text(
            "When you have notifications \nyou'll see them here",
            textAlign: TextAlign.center,
            style: AppTextStyle.text14kBlackTextColorW400.copyWith(
              color: AppColors.kBlackTextColor.withOpacity(0.50),
            ),
          ),
        ),
      ],
    );
  }
}
