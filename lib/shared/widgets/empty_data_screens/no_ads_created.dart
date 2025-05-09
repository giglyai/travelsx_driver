import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';

import '../../constants/app_styles/app_styles.dart';
import '../../constants/imagePath/image_paths.dart';
import '../size_config/size_config.dart';

class NoAdsCreateDataAvailableWidget extends StatelessWidget {
  String? title;
  NoAdsCreateDataAvailableWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSizedBox(height: 15),
          ImageLoader.svgPictureAssetImage(
            imagePath: ImagePath.noAdsCreateIcon,
            width: 142 * SizeConfig.widthMultiplier!,
            height: 117 * SizeConfig.heightMultiplier!,
          ),
          CustomSizedBox(height: 15),
          Text(
            title ?? "No Ads Created".tr,
            style: AppTextStyle.text16black0000W700,
          ),
        ],
      ),
    );
    ;
  }
}
