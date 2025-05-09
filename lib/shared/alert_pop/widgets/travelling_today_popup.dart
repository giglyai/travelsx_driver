import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_styles/app_styles.dart';
import '../../utils/image_loader/image_loader.dart';
import '../../widgets/buttons/blue_button.dart';
import '../../widgets/custom_sized_box/custom_sized_box.dart';
import '../../widgets/size_config/size_config.dart';

final List<String> travellingBy = [
  "Walking",
  "2 Wheeler",
  "Auto",
  "Taxi",
  "Bus",
  "Metro",
];

class CustomBottomSheet {
  static int? selectedIndex;
  static String? travellingReason;

  static void showTravellingTodayPopUp({
    required String title,
    required BuildContext context,
    required Function(String? travellingReason) onSubmit,
    VoidCallback? onTap,
    required bool isLoading,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState1) {
              return AlertDialog(
                titlePadding: EdgeInsets.only(
                    top: 15 * SizeConfig.heightMultiplier!,
                    bottom: 20 * SizeConfig.heightMultiplier!,
                    left: 15 * SizeConfig.widthMultiplier!,
                    right: 15 * SizeConfig.widthMultiplier!),
                backgroundColor: AppColors.kWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10 * SizeConfig.widthMultiplier!)),
                title: SizedBox(
                  width: 450 * SizeConfig.widthMultiplier!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 230 * SizeConfig.widthMultiplier!,
                            child: Text(
                              title,
                              style: AppTextStyle.text16black0000W500,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              selectedIndex = null;

                              setState1(() {
                                travellingReason = "";
                              });
                              AnywhereDoor.pop(context);
                            },
                            child: ImageLoader.svgPictureAssetImage(
                                imagePath: ImagePath.cutIcon,
                                width: 20 * SizeConfig.heightMultiplier!),
                          )
                        ],
                      ),
                      CustomSizedBox(
                        height: 20,
                      ),
                      ...List.generate(
                          travellingBy.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  setState1(() {
                                    travellingReason = travellingBy[index];

                                    onSubmit.call(travellingReason);
                                    selectedIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          15 * SizeConfig.heightMultiplier!),
                                  child: repeatedRowContainer(
                                      title: travellingBy[index],
                                      isSelected: selectedIndex == index),
                                ),
                              )),
                      CustomSizedBox(height: 22),
                      BlueButton(
                        height: 60 * SizeConfig.heightMultiplier!,
                        wantMargin: false,
                        buttonIsEnabled: travellingReason?.isNotEmpty == true,
                        title: "Continue",
                        isLoading: isLoading == true ? true : false,
                        onTap: onTap,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  static repeatedRowContainer({
    String? title,
    String? imagePath,
    required isSelected,
  }) {
    return Row(
      children: [
        ImageLoader.svgPictureAssetImage(
            imagePath: isSelected == true
                ? ImagePath.selectedCircleBox
                : ImagePath.circleIcon,
            width: 25 * SizeConfig.widthMultiplier!,
            height: 25 * SizeConfig.heightMultiplier!,
            color: AppColors.kBlue3D6),
        CustomSizedBox(
          width: 14,
        ),
        Text(title ?? "", style: AppTextStyle.text16black0000W500),
      ],
    );
  }
}
