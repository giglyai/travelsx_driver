import 'package:flutter/material.dart';

import '../../../../user/subscription/screen/subscription_screen.dart';
import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_styles/app_styles.dart';
import '../../routes/navigator.dart';
import '../../widgets/buttons/blue_button.dart';
import '../../widgets/custom_sized_box/custom_sized_box.dart';
import '../../widgets/size_config/size_config.dart';


class SubscribeNowPopUp {
  static void showSubscribeNowPopUp(
      {required String title,
      required BuildContext context,
      bool backButton = false}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false, // Disable back button
            child: AlertDialog(
              titlePadding: EdgeInsets.only(
                  top: 15 * SizeConfig.heightMultiplier!,
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
                    if (backButton == true)
                      GestureDetector(
                        onTap: () {
                          AnywhereDoor.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.close,
                              size: 24 * SizeConfig.widthMultiplier!,
                            )
                          ],
                        ),
                      ),
                    Text(
                      "Subscribe Gigly to enjoy our \npremium features!",
                      style: AppTextStyle.text16black0000W700,
                      textAlign: TextAlign.center,
                    ),
                    CustomSizedBox(height: 10 * SizeConfig.heightMultiplier!),
                    Center(
                      child: Text(
                        title,
                        style: AppTextStyle.text12black0000W400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CustomSizedBox(height: 22),
                    BlueButton(
                      borderRadius: 40 * SizeConfig.widthMultiplier!,
                      height: 40 * SizeConfig.heightMultiplier!,
                      width: 268 * SizeConfig.widthMultiplier!,
                      wantMargin: false,
                      title: "Subscribe Now",
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SubscriptionScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
