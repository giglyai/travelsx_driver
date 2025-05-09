import 'package:flutter/material.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/constants/imagePath/image_paths.dart';
import '../../shared/utils/image_loader/image_loader.dart';
import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/size_config/size_config.dart';

class DocumentTitleCard extends StatelessWidget {
  DocumentTitleCard({Key? key, this.title, this.onTap, this.isVarified = false})
      : super(key: key);

  String? title;
  VoidCallback? onTap;

  bool? isVarified;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
            left: 21 * SizeConfig.widthMultiplier!,
            right: 11 * SizeConfig.widthMultiplier!),
        padding: EdgeInsets.only(
            top: 15 * SizeConfig.heightMultiplier!,
            bottom: 15 * SizeConfig.heightMultiplier!),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.kLightBlueE2EDE5.withOpacity(0.50),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 16 * SizeConfig.widthMultiplier!),
          child: Row(
            children: [
              Text(title ?? "",
                  style: TextStyle(
                    fontSize: 16 * SizeConfig.textMultiplier!,
                    color: AppColors.kBlackTextColor.withOpacity(0.70),
                    fontWeight: FontWeight.w500,
                  )),
              const Spacer(),
              isVarified == false
                  ? Padding(
                      padding: EdgeInsets.only(
                          right: 14 * SizeConfig.widthMultiplier!),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.kBlackTextColor.withOpacity(0.40),
                        size: 20 * SizeConfig.widthMultiplier!,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          right: 14 * SizeConfig.widthMultiplier!),
                      child: Row(
                        children: [
                          Text(
                            "Varified",
                            style: TextStyle(
                                color:
                                    AppColors.kBlackTextColor.withOpacity(0.62),
                                fontSize: 14 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w400),
                          ),
                          CustomSizedBox(
                            width: 14,
                          ),
                          ImageLoader.svgPictureAssetImage(
                              imagePath: ImagePath.greenCheck)
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
