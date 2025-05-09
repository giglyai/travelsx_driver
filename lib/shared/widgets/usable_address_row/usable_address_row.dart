import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_styles/app_styles.dart';
import '../../constants/imagePath/image_paths.dart';
import '../../utils/image_loader/image_loader.dart';
import '../container_with_border/container_with_border.dart';
import '../custom_sized_box/custom_sized_box.dart';
import '../size_config/size_config.dart';

class UsableAddressRow extends StatelessWidget {
  UsableAddressRow(
      {super.key,
      this.dropUpAddress,
      this.dropupPlace,
      this.pickupAddress,
      this.pickupPlace,
      this.padding});

  String? pickupAddress;
  String? dropUpAddress;
  String? pickupPlace;
  String? dropupPlace;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? EdgeInsets.only(left: 10 * SizeConfig.widthMultiplier!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22 * SizeConfig.widthMultiplier!,
                height: 22 * SizeConfig.heightMultiplier!,
                padding: EdgeInsets.all(5 * SizeConfig.widthMultiplier!),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.kBlueF4F3FF),
                child: ImageLoader.svgPictureAssetImage(
                    imagePath: ImagePath.locationFilledIcon),
              ),
              CustomSizedBox(
                width: 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 275 * SizeConfig.widthMultiplier!,
                    child: Text(
                      pickupPlace ?? "",
                      style: AppTextStyle.text16black0000W600,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: 250 * SizeConfig.widthMultiplier!,
                    child: Text(
                      pickupAddress ?? "",
                      style: AppTextStyle.text14black0000W400,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: 30 * SizeConfig.heightMultiplier!),
                child: ContainerWithBorder(
                  width: 50 * SizeConfig.widthMultiplier!,
                  height: 21 * SizeConfig.widthMultiplier!,
                  wantPadding: true,
                  containerColor: AppColors.lGreyF2F3,
                  borderColor: AppColors.lGreyEAEE,
                  borderRadius: 6 * SizeConfig.widthMultiplier!,
                  child: Center(
                    child: Text(
                      "Pickup",
                      style: AppTextStyle.text12black0000W500,
                    ),
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
              Container(
                width: 22 * SizeConfig.widthMultiplier!,
                height: 22 * SizeConfig.heightMultiplier!,
                padding: EdgeInsets.all(5 * SizeConfig.widthMultiplier!),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.kBlueF4F3FF),
                child: ImageLoader.svgPictureAssetImage(
                    imagePath: ImagePath.dropFilledIcon),
              ),
              CustomSizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 275 * SizeConfig.widthMultiplier!,
                    child: Text(
                      dropupPlace ?? "",
                      style: AppTextStyle.text16black0000W600,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: 250 * SizeConfig.widthMultiplier!,
                    child: Text(
                      dropUpAddress ?? "",
                      style: AppTextStyle.text14black0000W400,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: 30 * SizeConfig.heightMultiplier!),
                child: ContainerWithBorder(
                  width: 50 * SizeConfig.widthMultiplier!,
                  height: 21 * SizeConfig.widthMultiplier!,
                  wantPadding: true,
                  containerColor: AppColors.lGreyF2F3,
                  borderColor: AppColors.lGreyEAEE,
                  borderRadius: 6 * SizeConfig.widthMultiplier!,
                  child: Center(
                    child: Text(
                      "Drop-off",
                      style: AppTextStyle.text12black0000W500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UsableSingleAddressRow extends StatelessWidget {
  UsableSingleAddressRow(
      {super.key, this.dropUpAddress, this.pickupAddress, this.padding});

  String? pickupAddress;
  String? dropUpAddress;

  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? EdgeInsets.only(left: 10 * SizeConfig.widthMultiplier!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22 * SizeConfig.widthMultiplier!,
                height: 22 * SizeConfig.heightMultiplier!,
                padding: EdgeInsets.all(5 * SizeConfig.widthMultiplier!),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.kBlueF4F3FF),
                child: ImageLoader.svgPictureAssetImage(
                    imagePath: ImagePath.locationFilledIcon),
              ),
              CustomSizedBox(
                width: 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250 * SizeConfig.widthMultiplier!,
                    child: Text(
                      pickupAddress ?? "",
                      style: AppTextStyle.text14black0000W400,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: 30 * SizeConfig.heightMultiplier!),
                child: ContainerWithBorder(
                  width: 50 * SizeConfig.widthMultiplier!,
                  height: 21 * SizeConfig.widthMultiplier!,
                  wantPadding: true,
                  containerColor: AppColors.lGreyF2F3,
                  borderColor: AppColors.lGreyEAEE,
                  borderRadius: 6 * SizeConfig.widthMultiplier!,
                  child: Center(
                    child: Text(
                      "Pickup",
                      style: AppTextStyle.text12black0000W500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22 * SizeConfig.widthMultiplier!,
                height: 22 * SizeConfig.heightMultiplier!,
                padding: EdgeInsets.all(5 * SizeConfig.widthMultiplier!),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.kBlueF4F3FF),
                child: ImageLoader.svgPictureAssetImage(
                    imagePath: ImagePath.dropFilledIcon),
              ),
              CustomSizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250 * SizeConfig.widthMultiplier!,
                    child: Text(
                      dropUpAddress ?? "",
                      style: AppTextStyle.text14black0000W400,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: 30 * SizeConfig.heightMultiplier!),
                child: ContainerWithBorder(
                  width: 50 * SizeConfig.widthMultiplier!,
                  height: 21 * SizeConfig.widthMultiplier!,
                  wantPadding: true,
                  containerColor: AppColors.lGreyF2F3,
                  borderColor: AppColors.lGreyEAEE,
                  borderRadius: 6 * SizeConfig.widthMultiplier!,
                  child: Center(
                    child: Text(
                      "Drop-off",
                      style: AppTextStyle.text12black0000W500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
