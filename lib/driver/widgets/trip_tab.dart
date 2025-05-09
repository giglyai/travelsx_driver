import 'package:flutter/material.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/constants/imagePath/image_paths.dart';
import '../../shared/utils/image_loader/image_loader.dart';
import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/size_config/size_config.dart';


class PickupTab extends StatelessWidget {
  bool isSelected;
  String title;

  VoidCallback onTap;

  PickupTab(
      {Key? key,
      required this.isSelected,
      required this.onTap,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40 * SizeConfig.heightMultiplier!,
        width: 155 * SizeConfig.widthMultiplier!,
        decoration: BoxDecoration(
            border: Border.all(
              color: isSelected == true
                  ? AppColors.darkGreenF2727
                  : Colors.transparent,
            ),
            borderRadius:
                BorderRadius.circular(101 * SizeConfig.widthMultiplier!)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected == true
                ? ImageLoader.svgPictureAssetImage(
                    imagePath: ImagePath.selectedCircleBox,
                    color: AppColors.kBlue1A73E8)
                : ImageLoader.svgPictureAssetImage(
                    imagePath: ImagePath.unSelectedTabCircleBox,
                  ),
            CustomSizedBox(
              width: 4,
            ),
            Text(title,
                style: TextStyle(
                  fontSize: 16 * SizeConfig.textMultiplier!,
                  fontWeight:
                      isSelected == true ? FontWeight.w600 : FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }
}
