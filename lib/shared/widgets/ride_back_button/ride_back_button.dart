import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';

import '../../constants/imagePath/image_paths.dart';
import '../../utils/image_loader/image_loader.dart';
import '../size_config/size_config.dart';

class RideBackButton extends StatelessWidget {
  RideBackButton({Key? key, this.onTap, this.padding}) : super(key: key);

  VoidCallback? onTap;

  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.pop(context);
          },
      child: Padding(
        padding: padding ??
            EdgeInsets.only(
                left: 20 * SizeConfig.widthMultiplier!,
                top: 45 * SizeConfig.heightMultiplier!),
        child: Container(
          decoration: BoxDecoration(color: AppColors.kWhiteFFFF),
          width: 30 * SizeConfig.widthMultiplier!,
          height: 30 * SizeConfig.heightMultiplier!,
          child: ImageLoader.svgPictureAssetImage(
            imagePath: ImagePath.backButtonIcon,
          ),
        ),
      ),
    );
  }
}
