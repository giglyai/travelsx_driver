import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';

class EmptyEarnings extends StatelessWidget {
  EmptyEarnings({super.key, this.message});

  String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomSizedBox(
          height: 25,
        ),
        Text('\INR0',
            style: AppTextStyle.text30kBlackTextColorW700
                .copyWith(color: AppColors.kBlackTextColor.withOpacity(0.40))),
        CustomSizedBox(
          height: 10,
        ),
        Text(message ?? "No Data Available",
            style: AppTextStyle.text16kBlackTextColorW500),
      ],
    );
  }
}
