import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_styles/app_styles.dart';
import '../../widgets/buttons/blue_button.dart';
import '../../widgets/custom_sized_box/custom_sized_box.dart';
import '../../widgets/size_config/size_config.dart';


class SelectVehicleDialogue {
  static void selectVehicleDialogue(
      {required String title,
      required BuildContext context,
      bool backButton = false}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(
                top: 15 * SizeConfig.heightMultiplier!,
                bottom: 20 * SizeConfig.heightMultiplier!,
                left: 14 * SizeConfig.widthMultiplier!,
                right: 14 * SizeConfig.widthMultiplier!),
            backgroundColor: AppColors.kWhite,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8 * SizeConfig.widthMultiplier!)),
            title: SizedBox(
              width: 550 * SizeConfig.widthMultiplier!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 2 * SizeConfig.widthMultiplier!,
                    ),
                    child: Text(
                      "Advance Search",
                      style: AppTextStyle.text14kRed57W500,
                    ),
                  ),
                  CustomSizedBox(height: 14),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 2 * SizeConfig.widthMultiplier!,
                    ),
                    child: Text(
                      "Select type of vehicle",
                      style: AppTextStyle.text12black0000W500,
                    ),
                  ),
                  CustomSizedBox(height: 11),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          repeatedContainerRow(title: "SUV"),
                          CustomSizedBox(width: 6),
                          repeatedContainerRow(title: "Sedan"),
                          CustomSizedBox(width: 6),
                          repeatedContainerRow(title: "Mini"),
                          CustomSizedBox(width: 6),
                          repeatedContainerRow(title: "Prime SUV"),
                        ],
                      ),
                      CustomSizedBox(height: 8),
                      Row(
                        children: [
                          repeatedContainerRow(title: "Prime Sedan"),
                          CustomSizedBox(width: 6),
                          repeatedContainerRow(title: "Maxicab Coach"),
                        ],
                      )
                    ],
                  ),
                  CustomSizedBox(height: 16),
                  BlueButton(
                    borderRadius: 5 * SizeConfig.widthMultiplier!,
                    height: 36 * SizeConfig.heightMultiplier!,
                    width: 311 * SizeConfig.widthMultiplier!,
                    wantMargin: false,
                    title: "Search",
                    onTap: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const SubscriptionScreen()),
                      // );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  static repeatedContainerRow({required String title ,bool isSelectedContainer = true }) {
    return GestureDetector(
      onTap: (){
        isSelectedContainer=!isSelectedContainer;
      },
      child: Container(
        padding: EdgeInsets.all(10 * SizeConfig.widthMultiplier!),
        decoration: BoxDecoration(
          border: Border.all(color: isSelectedContainer==true? AppColors.kBlue3D6: Colors.transparent ),
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(6 * SizeConfig.widthMultiplier!)),
        child: Text(
          title ?? "",
          style: AppTextStyle.text12black0000W400,
        ),
      ),
    );
  }
}
