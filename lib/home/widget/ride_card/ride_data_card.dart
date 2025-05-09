// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart';
import 'package:travelx_driver/home/widget/container_with_border/container_with_border.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/usable_address_row/single_address_row.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/utils/image_loader/image_loader.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/size_config/size_config.dart';

class RideCardData extends StatelessWidget {
  bool? isDisabled;

  RideCardData(
      {Key? key,
      this.onTap,
      this.isDisabled,
      this.isSelected = false,
      this.ride,
      this.totalPrice})
      : super(key: key);

  VoidCallback? onTap;

  bool? isSelected;

  Ride? ride;
  String? totalPrice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 10 * SizeConfig.heightMultiplier!),
        margin: EdgeInsets.only(
          top: 15 * SizeConfig.heightMultiplier!,
          bottom: 10 * SizeConfig.heightMultiplier!,
        ),
        decoration: BoxDecoration(
          border: isSelected == true
              ? Border.all(color: AppColors.kBlackTextColor.withOpacity(0.19))
              : null,
          boxShadow: isSelected == true
              ? [
                  BoxShadow(
                      blurRadius: 5,
                      color: AppColors.kBlackTextColor.withOpacity(0.19)),
                ]
              : null,
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(15 * SizeConfig.widthMultiplier!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 8.0 * SizeConfig.widthMultiplier!,
                  top: 10 * SizeConfig.heightMultiplier!),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "ID : ${ride?.rideId ?? ""}",
                    style: AppTextStyle.text12black0000W400?.copyWith(
                        color: AppColors.kBlackTextColor.withOpacity(0.50)),
                  ),
                  CustomSizedBox(
                    width: 12,
                  ),
                  ContainerWithBorder(
                    wantPadding: true,
                    containerColor: AppColors.lGreyF2F3,
                    borderColor: AppColors.lGreyF2F3,
                    borderRadius: 16 * SizeConfig.widthMultiplier!,
                    height: 25 * SizeConfig.widthMultiplier!,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 8.0 * SizeConfig.widthMultiplier!,
                          right: 8 * SizeConfig.widthMultiplier!),
                      child: Row(
                        children: [
                          if (ride?.rideVehicle == "maxicab" ||
                              (ride?.rideVehicle == "maxicab coach"))
                            ImageLoader.assetImage(
                                width: 50 * SizeConfig.widthMultiplier!,
                                height: 40 * SizeConfig.heightMultiplier!,
                                imagePath: ImagePath.maxicabcar),
                          if (ride?.rideVehicle == "sedan" ||
                              (ride?.rideVehicle == "prime sedan"))
                            ImageLoader.assetImage(
                                width: 50 * SizeConfig.widthMultiplier!,
                                height: 40 * SizeConfig.heightMultiplier!,
                                imagePath: ImagePath.sedancar),
                          if (ride?.rideVehicle == "suv" ||
                              (ride?.rideVehicle == "prime suv"))
                            ImageLoader.assetImage(
                                width: 50 * SizeConfig.widthMultiplier!,
                                height: 40 * SizeConfig.heightMultiplier!,
                                imagePath: ImagePath.suvcar),
                          if (ride?.rideVehicle == "mini")
                            ImageLoader.assetImage(
                                width: 50 * SizeConfig.widthMultiplier!,
                                height: 40 * SizeConfig.heightMultiplier!,
                                imagePath: ImagePath.minicar),
                          Text(
                            ride?.rideVehicle ?? "",
                            style: AppTextStyle.text14Nblack0000W400,
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     if (ride?.rideVehicle == "maxicab" ||
                      //         (ride?.rideVehicle == "maxicab coach"))
                      //       ImageLoader.assetImage(
                      //           width: 30 * SizeConfig.widthMultiplier!,
                      //           height: 30 * SizeConfig.heightMultiplier!,
                      //           imagePath: ImagePath.maxiCabIcon)
                      //     else
                      //       ImageLoader.assetImage(
                      //           imagePath: ImagePath.uberCarIcon),
                      //     Text(
                      //       ride?.rideVehicle ?? "",
                      //       style: AppTextStyle.text14Nblack0000W400,
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            CustomSizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 8.0 * SizeConfig.widthMultiplier!,
                  right: 8 * SizeConfig.widthMultiplier!),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 5 * SizeConfig.widthMultiplier!,
                        right: 5 * SizeConfig.widthMultiplier!,
                        bottom: 5 * SizeConfig.heightMultiplier!,
                        top: 5 * SizeConfig.heightMultiplier!),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          14 * SizeConfig.widthMultiplier!,
                        ),
                        border: Border.all(
                          color: AppColors.kBlue3D6.withOpacity(0.33),
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ride?.createdBy?.name == 'Gigly'
                              ? ImageLoader.svgPictureAssetImage(
                                  imagePath: ImagePath.cartIcon,
                                  width: 25 * SizeConfig.widthMultiplier!,
                                  height: 25 * SizeConfig.heightMultiplier!,
                                )
                              : ImageLoader.svgPictureAssetImage(
                                  imagePath: ImagePath.giglyagency,
                                  width: 25 * SizeConfig.widthMultiplier!,
                                  height: 25 * SizeConfig.heightMultiplier!,
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5 * SizeConfig.widthMultiplier!,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ride?.createdBy?.name ?? "",
                                style: TextStyle(
                                  fontSize: 14 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.kBlackTextColor,
                                ),
                              ),
                              CustomSizedBox(height: 2),
                              Text(
                                ride?.createdBy?.subText ?? "",
                                style: TextStyle(
                                  fontSize: 12 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kBlackTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        totalPrice ?? "",
                        style: GoogleFonts.urbanist(
                          fontSize: 30 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w700,
                          color: AppColors.kBlackTextColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "(${ride?.price?.priceText ?? ''})",
                            style: GoogleFonts.roboto(
                              fontSize: 10 * SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.w600,
                              color:
                                  AppColors.kBlackTextColor.withOpacity(0.60),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            ride?.price?.currency ?? '',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 12 * SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.w600,
                              color:
                                  AppColors.kBlackTextColor.withOpacity(0.60),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomSizedBox(height: 7),
            SizedBox(
              width: 341 * SizeConfig.widthMultiplier!,
              child: Divider(
                thickness: 1,
                endIndent: 16 * SizeConfig.widthMultiplier!,
                indent: 8 * SizeConfig.widthMultiplier!,
              ),
            ),
            CustomSizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(
                left: 10 * SizeConfig.widthMultiplier!,
              ),
              child: Row(
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
                          ride?.rideType.toString().capitalize() ?? "",
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(
                        top: 5 * SizeConfig.heightMultiplier!,
                        bottom: 5 * SizeConfig.heightMultiplier!),
                    margin: EdgeInsets.only(
                        right: 40 * SizeConfig.widthMultiplier!),
                    decoration: BoxDecoration(
                        color: AppColors.kWhiteEAE4E4.withOpacity(0.48),
                        borderRadius: BorderRadius.circular(
                            16 * SizeConfig.widthMultiplier!)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 11 * SizeConfig.widthMultiplier!,
                          right: 5 * SizeConfig.widthMultiplier!),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${ride?.tripDetails?.distance.toString() ?? ""} ${ride?.tripDetails?.distanceUnit.toString() ?? ""}",
                            style: TextStyle(
                                color: AppColors.kBlackTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14 * SizeConfig.textMultiplier!),
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
                            style: TextStyle(
                                color: AppColors.kBlackTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14 * SizeConfig.textMultiplier!),
                          ),
                          SizedBox(
                              height: 10 * SizeConfig.heightMultiplier!,
                              child: VerticalDivider(
                                thickness: 1,
                                color:
                                    AppColors.kBlackTextColor.withOpacity(0.18),
                              )),
                          ride?.tripDetails?.noOfTolls != null
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
                                        style: TextStyle(
                                            fontSize:
                                                10 * SizeConfig.textMultiplier!,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomSizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(
                  left: 8 * SizeConfig.widthMultiplier!,
                  right: 8 * SizeConfig.widthMultiplier!),
              child: UsableSingleAddressRow(
                textStyle: AppTextStyle.text14black0000W700?.copyWith(
                    color: AppColors.kBlackTextColor.withOpacity(0.70)),
                maxline: 3,
                pickupImagePath: ImagePath.pickupRideCon,
                dropupImagePath: ImagePath.dropRideIcon,
                pickupAddress: "${ride?.tripSequence[0].address ?? ''} ",
                dropUpAddress: ride?.tripSequence[1].address ?? '',
              ),
            ),
            CustomSizedBox(height: 8),
            SizedBox(
              width: 341 * SizeConfig.widthMultiplier!,
              child: Divider(
                thickness: 1,
                endIndent: 16 * SizeConfig.widthMultiplier!,
                indent: 8 * SizeConfig.widthMultiplier!,
              ),
            ),
            CustomSizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(
                left: 10 * SizeConfig.widthMultiplier!,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageLoader.svgPictureAssetImage(
                      imagePath: ImagePath.rideVehicleIcon,
                      wantsScale: true,
                      scale: 1.2),
                  CustomSizedBox(
                    width: 5,
                  ),
                  Text(
                    "Pickup ",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12 * SizeConfig.textMultiplier!,
                      color: AppColors.kBlackTextColor,
                    ),
                  ),
                  Text(
                    ride?.tripSequence[0].pickupTime ?? '',
                    style: TextStyle(
                      fontSize: 12 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w700,
                      color: AppColors.kBlackTextColor.withOpacity(0.60),
                    ),
                  ),
                  CustomSizedBox(
                    width: 2,
                  ),
                  Text(
                    "Dropoff ",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12 * SizeConfig.textMultiplier!,
                      color: AppColors.kBlackTextColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 8.0 * SizeConfig.widthMultiplier!),
                    child: Text(
                      ride?.tripSequence[1].dropoffTime.toString() ?? "",
                      style: TextStyle(
                        fontSize: 12 * SizeConfig.textMultiplier!,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kBlackTextColor.withOpacity(0.60),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
