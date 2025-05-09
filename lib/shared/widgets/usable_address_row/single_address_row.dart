

import 'package:flutter/material.dart';

import '../../../home/widget/container_with_border/container_with_border.dart';
import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_styles/app_styles.dart';
import '../../constants/imagePath/image_paths.dart';
import '../../utils/image_loader/image_loader.dart';
import '../custom_sized_box/custom_sized_box.dart';
import '../size_config/size_config.dart';

class UsableSingleAddressRow extends StatelessWidget {
  UsableSingleAddressRow({
    super.key,
    this.dropUpAddress,
    this.pickupAddress,
    this.pickupImagePath,
    this.dropupImagePath,
    this.maxline,
    this.textStyle
  });

  String? pickupAddress;
  String? dropUpAddress;
  String? pickupImagePath;
  String? dropupImagePath;
  int? maxline;
  TextStyle? textStyle;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageLoader.svgPictureAssetImage(
                imagePath:pickupImagePath?? ImagePath.greenRadioIcon),
            CustomSizedBox(width: 3,),
            Expanded(
              child: Text(
                pickupAddress ?? "",
                style: textStyle ??AppTextStyle.text14black0000W400,
                overflow: TextOverflow.ellipsis,
                maxLines: maxline ??3,
              ),
            ),
            ContainerWithBorder(
              width: 50 * SizeConfig.widthMultiplier!,
              height: 21 * SizeConfig.widthMultiplier!,
              wantPadding: true,
              containerColor: AppColors.kWhite,
              borderColor: AppColors.kWhite,
              borderRadius: 6 * SizeConfig.widthMultiplier!,
              child: Center(
                child: Text(
                  "Pickup",
                  style: AppTextStyle.text12black0000W500,
                ),
              ),
            ),
          ],
        ),
        CustomSizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageLoader.svgPictureAssetImage(
                imagePath:dropupImagePath ?? ImagePath.greenRadioIcon),
            CustomSizedBox(
              width: 2,
            ),
            Expanded(
              child: Text(
                dropUpAddress ?? "",
                style:textStyle?? AppTextStyle.text14black0000W400,
                overflow: TextOverflow.ellipsis,
                maxLines: maxline ??3,
              ),
            ),
            ContainerWithBorder(
              width: 50 * SizeConfig.widthMultiplier!,
              height: 21 * SizeConfig.widthMultiplier!,
              wantPadding: true,
              containerColor: AppColors.kWhite,
              borderColor: AppColors.kWhite,
              borderRadius: 6 * SizeConfig.widthMultiplier!,
              child: Center(
                child: Text(
                  "Drop-off",
                  style: AppTextStyle.text12black0000W500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
