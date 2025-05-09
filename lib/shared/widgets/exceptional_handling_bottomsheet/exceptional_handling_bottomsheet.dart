import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_styles/app_styles.dart';
import '../../routes/navigator.dart';
import '../buttons/blue_button.dart';
import '../custom_sized_box/custom_sized_box.dart';
import '../size_config/size_config.dart';

class CustomExceptionBottomSheet {
  customBottomSheet({
    required BuildContext context,
    String? title,
  }) {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: Colors.black.withOpacity(0.7),
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(20 * SizeConfig.widthMultiplier!),
                          topRight: Radius.circular(
                              20 * SizeConfig.widthMultiplier!))),
                  height: 225 * SizeConfig.heightMultiplier!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!,
                            top: 20 * SizeConfig.heightMultiplier!),
                        child: Text(title ?? 'Oops! Something went \nwrong',
                            style: AppTextStyle.text20black0000W600),
                      ),
                      CustomSizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20 * SizeConfig.widthMultiplier!,
                        ),
                        child: Text(
                            title?.isNotEmpty == true
                                ? "Try again.."
                                : 'Something is wrong. Please Try again',
                            style: AppTextStyle.text14black0000W400?.copyWith(
                                color: AppColors.kBlackTextColor
                                    .withOpacity(0.70))),
                      ),
                      CustomSizedBox(
                        height: 37,
                      ),
                      BlueButton(
                        onTap: () {
                          AnywhereDoor.pop(context);
                        },
                      ),
                      CustomSizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  refershBottomSheet({
    required BuildContext context,
    String? title,
  }) {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: Colors.black.withOpacity(0.7),
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(20 * SizeConfig.widthMultiplier!),
                          topRight: Radius.circular(
                              20 * SizeConfig.widthMultiplier!))),
                  height: 225 * SizeConfig.heightMultiplier!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!,
                            top: 20 * SizeConfig.heightMultiplier!),
                        child: Text(title ?? 'Oops! Something went \nwrong',
                            style: AppTextStyle.text20black0000W600),
                      ),
                      CustomSizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20 * SizeConfig.widthMultiplier!,
                        ),
                        child: Text(
                            title?.isNotEmpty == true
                                ? "Try again.."
                                : 'Refresh',
                            style: AppTextStyle.text14black0000W400?.copyWith(
                                color: AppColors.kBlackTextColor
                                    .withOpacity(0.70))),
                      ),
                      CustomSizedBox(
                        height: 37,
                      ),
                      BlueButton(
                        onTap: () {
                          AnywhereDoor.pop(context);
                        },
                      ),
                      CustomSizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
