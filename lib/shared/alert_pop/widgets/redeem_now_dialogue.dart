import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_styles/app_styles.dart';
import '../../routes/navigator.dart';
import '../../widgets/buttons/blue_button.dart';
import '../../widgets/custom_sized_box/custom_sized_box.dart';
import '../../widgets/size_config/size_config.dart';


class RedeemNowPopUp {
  static void showRedeemNowPopUp(
      {required String title, required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
                    "Your Subscription has been \nexpired!",
                    style: AppTextStyle.text16black0000W600,
                    textAlign: TextAlign.center,
                  ),
                  CustomSizedBox(height: 10 * SizeConfig.heightMultiplier!),
                  Center(
                    child: Text(
                      title,
                      style: AppTextStyle.text12black0000W400,
                    ),
                  ),
                  CustomSizedBox(height: 14),
                  Text(
                    "Renew your package!",
                    style: AppTextStyle.text14black0000W600!,
                  ),
                  CustomSizedBox(height: 22),
                  BlueButton(
                    borderRadius: 40 * SizeConfig.widthMultiplier!,
                    height: 40 * SizeConfig.heightMultiplier!,
                    width: 268 * SizeConfig.widthMultiplier!,
                    wantMargin: false,
                    title: "Renew Now",
                    onTap: () async {},
                  ),
                ],
              ),
            ),
          );
        });
  }
}
