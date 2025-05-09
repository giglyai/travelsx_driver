import 'package:flutter/material.dart';

import '../constants/app_colors/app_colors.dart';
import '../constants/app_styles/app_styles.dart';
import '../routes/navigator.dart';
import '../widgets/buttons/blue_button.dart';
import '../widgets/custom_sized_box/custom_sized_box.dart';
import '../widgets/outline_button/outline_button.dart';
import '../widgets/size_config/size_config.dart';


class ConfirmDeletion {
  void confirmDeletionPopUp({
    required String title,
    required BuildContext context,
    bool backButton = false,
    VoidCallback? onTap,
    bool? isLoading,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false, // Disable back button
            child: AlertDialog(
              titlePadding: EdgeInsets.only(
                  top: 10 * SizeConfig.heightMultiplier!,
                  bottom: 20 * SizeConfig.heightMultiplier!,
                  left: 15 * SizeConfig.widthMultiplier!,
                  right: 15 * SizeConfig.widthMultiplier!),
              backgroundColor: AppColors.kWhite,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10 * SizeConfig.widthMultiplier!)),
              title: SizedBox(
                width: 450 * SizeConfig.widthMultiplier!,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomSizedBox(height: 10),
                    Text(
                      "Confirm Deletion!",
                      style: AppTextStyle.text16black0000W600,
                      textAlign: TextAlign.center,
                    ),
                    CustomSizedBox(height: 5 * SizeConfig.heightMultiplier!),
                    Center(
                      child: Text(
                        title,
                        style: AppTextStyle.text14black0000W400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CustomSizedBox(height: 15),
                    BlueButton(
                      onTap: onTap,
                      height: 44,
                      wantMargin: false,
                      title: "Confirm",
                      isLoading: isLoading == true ? true : false,
                    ),
                    CustomSizedBox(height: 10),
                    CustomOutlineButton(
                      onTap: () {
                        AnywhereDoor.pop(context);
                      },
                      height: 44,
                      wantMargin: false,
                      title: "cancel",
                      titleColor: AppColors.kBlackTextColor,
                      borderColor: AppColors.kredDF0000,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
