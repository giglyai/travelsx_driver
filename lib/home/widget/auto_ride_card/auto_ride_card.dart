import 'package:flutter/material.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/widgets/container_with_border/container_with_border.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';

class AutoRideCard extends StatelessWidget {
  bool? isDisabled;

  AutoRideCard(
      {super.key,
      this.onTap,
      this.isDisabled,
      this.isSelected = false,
      this.ride,
      this.totalPrice});

  VoidCallback? onTap;

  bool? isSelected;

  Ride? ride;
  String? totalPrice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          top: 10 * SizeConfig.heightMultiplier!,
          bottom: 10 * SizeConfig.heightMultiplier!,
        ),
        child: Container(
            padding: EdgeInsets.only(bottom: 10 * SizeConfig.heightMultiplier!),
            decoration: BoxDecoration(
              border: isSelected == true
                  ? Border.all(color: AppColors.kBlue3D6)
                  : Border.all(
                      color: AppColors.kBlackTextColor.withOpacity(0.19)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: AppColors.kBlackTextColor.withOpacity(0.19)),
              ],
              color: AppColors.kWhite,
              borderRadius:
                  BorderRadius.circular(8 * SizeConfig.widthMultiplier!),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 12 * SizeConfig.widthMultiplier!,
                top: 12 * SizeConfig.heightMultiplier!,
                right: 12 * SizeConfig.widthMultiplier!,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ContainerWithBorder(
                        wantPadding: true,
                        containerColor: AppColors.kBlack1E2E2E,
                        borderColor: AppColors.kBlack1E2E2E,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 15 * SizeConfig.widthMultiplier!,
                              right: 15 * SizeConfig.widthMultiplier!,
                              top: 2 * SizeConfig.heightMultiplier!,
                              bottom: 2 * SizeConfig.heightMultiplier!),
                          child: Text(
                            ride?.rideFeature ?? "",
                            style: AppTextStyle.text12kWhiteFFW500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${ride?.payment?.amount} ${ride?.payment?.currency.toString()}",
                        style: AppTextStyle.text20black0000W700,
                      ),
                      CustomSizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  CustomSizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "ID: ${ride?.rideId}",
                        style: AppTextStyle.text12black0000W400?.copyWith(
                            color: AppColors.kBlackTextColor.withOpacity(0.50)),
                      ),
                    ],
                  ),
                  CustomSizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 4 * SizeConfig.heightMultiplier!,
                        bottom: 4 * SizeConfig.heightMultiplier!),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.kGreyD5DDE0),
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(
                            10 * SizeConfig.widthMultiplier!)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 11 * SizeConfig.widthMultiplier!,
                          right: 5 * SizeConfig.widthMultiplier!),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${ride?.tripDetails?.distance.toString() ?? ""} ${ride?.tripDetails?.distanceUnit.toString() ?? ""}",
                            style: AppTextStyle.text12kRed907171W500,
                          ),
                          CustomSizedBox(
                            width: 3,
                          ),
                          SizedBox(
                              height: 10 * SizeConfig.heightMultiplier!,
                              child: VerticalDivider(
                                thickness: 1,
                                color:
                                    AppColors.kBlackTextColor.withOpacity(0.18),
                              )),
                          Text(
                            "${ride?.tripDetails?.duration.toString() ?? ""} ${ride?.tripDetails?.durationUnit.toString() ?? ""}",
                            style: AppTextStyle.text12kRed907171W500,
                          ),
                          if (ride?.tripDetails?.noOfTolls != null &&
                              (ride?.tripDetails!.noOfTolls! ?? 0) > 0)
                            SizedBox(
                                height: 10 * SizeConfig.heightMultiplier!,
                                child: VerticalDivider(
                                  thickness: 1,
                                  color: AppColors.kBlackTextColor
                                      .withOpacity(0.18),
                                )),
                          ride?.tripDetails?.noOfTolls != null &&
                                  (ride?.tripDetails!.noOfTolls! ?? 0) > 0
                              ? Container(
                                  padding: EdgeInsets.all(
                                      5 * SizeConfig.widthMultiplier!),
                                  decoration: BoxDecoration(
                                      color: AppColors.kWhiteFFFF,
                                      borderRadius: BorderRadius.circular(
                                          21 * SizeConfig.widthMultiplier!)),
                                  child: Row(
                                    children: [
                                      ImageLoader.svgPictureAssetImage(
                                          imagePath: ImagePath.tollIcon),
                                      CustomSizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${ride?.tripDetails?.noOfTolls.toString() ?? ""} tolls",
                                        style:
                                            AppTextStyle.text12kRed907171W500,
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                  CustomSizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 9 * SizeConfig.widthMultiplier!,
                            right: 9 * SizeConfig.widthMultiplier!,
                            top: 5 * SizeConfig.heightMultiplier!,
                            bottom: 5 * SizeConfig.heightMultiplier!),
                        decoration: BoxDecoration(
                          color: AppColors.kWhiteEAE4E4.withOpacity(0.48),
                          borderRadius: BorderRadius.circular(
                              16 * SizeConfig.widthMultiplier!),
                        ),
                        child: Row(
                          children: [
                            ImageLoader.svgPictureAssetImage(
                                imagePath: ImagePath.checkRadioIcon),
                            CustomSizedBox(
                              width: 7,
                            ),
                            Text(
                              ride?.rideType ?? "",
                              style: AppTextStyle.text12black0000W500,
                            )
                          ],
                        ),
                      ),
                      CustomSizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 9 * SizeConfig.widthMultiplier!,
                            right: 9 * SizeConfig.widthMultiplier!,
                            top: 5 * SizeConfig.heightMultiplier!,
                            bottom: 5 * SizeConfig.heightMultiplier!),
                        decoration: BoxDecoration(
                          color: AppColors.kWhiteEAE4E4.withOpacity(0.48),
                          borderRadius: BorderRadius.circular(
                              16 * SizeConfig.widthMultiplier!),
                        ),
                        child: Row(
                          children: [
                            ImageLoader.svgPictureAssetImage(
                                imagePath: ImagePath.checkRadioIcon),
                            CustomSizedBox(
                              width: 7,
                            ),
                            Text(
                              ride?.rideVehicle ?? "",
                              style: AppTextStyle.text12black0000W500,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomSizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Pickup time",
                        style: AppTextStyle.text14black0000W400,
                      ),
                      CustomSizedBox(
                        width: 10,
                      ),
                      Text(
                        ride?.tripSequence[0].pickupTime ?? '',
                        style: AppTextStyle.text16black0000W700,
                      ),
                    ],
                  ),
                  CustomSizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageLoader.svgPictureAssetImage(
                          width: 20 * SizeConfig.widthMultiplier!,
                          height: 20 * SizeConfig.widthMultiplier!,
                          imagePath: ImagePath.locationIconGreen),
                      CustomSizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "${ride?.tripSequence[0].address} (Pickup)",
                          style: AppTextStyle.text14black0000W400,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  CustomSizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageLoader.svgPictureAssetImage(
                          width: 20 * SizeConfig.widthMultiplier!,
                          height: 20 * SizeConfig.widthMultiplier!,
                          imagePath: ImagePath.locationIconGreen),
                      CustomSizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "${ride?.tripSequence[1].address} (Dropoff)",
                          style: AppTextStyle.text14black0000W400,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  CustomSizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      ImageLoader.svgPictureAssetImage(
                          imagePath: ImagePath.userIcon,
                          color: AppColors.kBlackTextColor),
                      CustomSizedBox(
                        width: 7,
                      ),
                      Text(
                        ride?.tripSequence[0].firstName?.toString() ?? "",
                        style: AppTextStyle.text14black0000W400,
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
