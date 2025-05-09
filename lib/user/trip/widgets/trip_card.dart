import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/home/revamp/entity/ride_matrix.dart';
import 'package:travelx_driver/shared/utils/enums/common_enums.dart';
import 'package:travelx_driver/shared/widgets/buttons/button_with_icon.dart';
import 'package:travelx_driver/shared/widgets/container_with_border/container_with_border.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/usable_address_row/single_address_row.dart';
import 'package:travelx_driver/user/trip/equatable/trip_equatable.dart';

import '../../../../shared/constants/app_colors/app_colors.dart';
import '../../../../shared/constants/app_styles/app_styles.dart';
import '../../../../shared/constants/imagePath/image_paths.dart';
import '../../../../shared/utils/utilities.dart';
import '../../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../../shared/widgets/size_config/size_config.dart';

class TripRideCard extends StatefulWidget {
  TripRideCard({
    Key? key,
    this.assignTabOnTap,
    required this.selectedIndex,
    this.isSelected = false,
    this.manualRide,
    this.cancelOnTap,
    this.onTapCard,
    this.tripStatus = TripStatus.all,
  }) : super(key: key);

  TripAllData? manualRide;
  VoidCallback? assignTabOnTap;
  VoidCallback? cancelOnTap;
  int selectedIndex;
  bool? isSelected;
  VoidCallback? onTapCard;
  TripStatus tripStatus;

  @override
  State<TripRideCard> createState() => _TripRideCardState();
}

class _TripRideCardState extends State<TripRideCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapCard,
      child: Container(
        padding: EdgeInsets.only(bottom: 10 * SizeConfig.heightMultiplier!),
        margin: EdgeInsets.symmetric(
            vertical: 5 * SizeConfig.heightMultiplier!,
            horizontal: 14 * SizeConfig.widthMultiplier!),
        decoration: BoxDecoration(
          border: widget.isSelected == true
              ? Border.all(
                  color: AppColors.kblueDF0000,
                  width: 1,
                )
              : Border.all(color: AppColors.kTransparent),
          boxShadow: [
            BoxShadow(
              color: AppColors.kBlackTextColor.withOpacity(0.15),
              blurRadius: 3, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
            )
          ],
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.0 * SizeConfig.heightMultiplier!,
                      left: 5 * SizeConfig.widthMultiplier!),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.manualRide?.pickupTime ?? "",
                        style: AppTextStyle.text14kBlack272727W600,
                      ),
                      CustomSizedBox(
                        height: 5,
                      ),
                      Text(
                        "ID : ${widget.manualRide?.rideId ?? ""}",
                        style: AppTextStyle.text12black0000W600?.copyWith(
                            color: AppColors.kBlackTextColor.withOpacity(0.50)),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding:
                      EdgeInsets.only(right: 5 * SizeConfig.widthMultiplier!),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.manualRide?.estimatedFee ?? "",
                            style: AppTextStyle.text28Black0000W700,
                          ),
                          Text(
                            " ${widget.manualRide?.currency ?? ""}",
                            style: AppTextStyle.text20black0000W400?.copyWith(
                                color:
                                    AppColors.kBlackTextColor.withOpacity(0.6)),
                          ),
                        ],
                      ),
                      Text(
                        '(Includes All)',
                        style: AppTextStyle.text10black0000W400?.copyWith(
                            height: 0.1,
                            color: AppColors.kBlackTextColor.withOpacity(0.60)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CustomSizedBox(
              height: 11,
            ),
            Row(
              children: [
                CustomSizedBox(
                  width: 5,
                ),
                ContainerWithBorder(
                  containerColor: Colors.transparent,
                  wantPadding: true,
                  borderColor: const Color(
                    0xff13E800,
                  ),
                  borderWidth: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10 * SizeConfig.widthMultiplier!,
                        top: 4 * SizeConfig.heightMultiplier!,
                        bottom: 4 * SizeConfig.heightMultiplier!,
                        right: 10 * SizeConfig.widthMultiplier!),
                    child: Row(
                      children: [
                        ImageLoader.svgPictureAssetImage(
                            imagePath: ImagePath.checkRadioIcon),
                        CustomSizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.manualRide?.rideType.toString().capitalize() ??
                              "",
                          style: AppTextStyle.text14Nblack0000W400,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomSizedBox(
                  width: 4,
                ),
                ContainerWithBorder(
                  containerColor: Colors.transparent,
                  wantPadding: true,
                  borderColor: Color(
                    0xff13E800,
                  ),
                  borderWidth: 1,
                  borderRadius: 16 * SizeConfig.widthMultiplier!,
                  height: 28 * SizeConfig.widthMultiplier!,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 5 * SizeConfig.widthMultiplier!,
                        right: 8 * SizeConfig.widthMultiplier!),
                    child: Row(
                      children: [
                        if (widget.manualRide?.vehicleType == "maxicab" ||
                            (widget.manualRide?.vehicleType == "maxicab coach"))
                          ImageLoader.assetImage(
                              width: 25 * SizeConfig.widthMultiplier!,
                              height: 20 * SizeConfig.heightMultiplier!,
                              imagePath: ImagePath.maxicabcar),
                        if (widget.manualRide?.vehicleType == "sedan" ||
                            (widget.manualRide?.vehicleType == "prime sedan"))
                          ImageLoader.assetImage(
                              width: 25 * SizeConfig.widthMultiplier!,
                              height: 20 * SizeConfig.heightMultiplier!,
                              imagePath: ImagePath.sedancar),
                        if (widget.manualRide?.vehicleType == "suv" ||
                            (widget.manualRide?.vehicleType == "prime suv"))
                          ImageLoader.assetImage(
                              width: 25 * SizeConfig.widthMultiplier!,
                              height: 20 * SizeConfig.heightMultiplier!,
                              imagePath: ImagePath.suvcar),
                        if (widget.manualRide?.vehicleType == "mini")
                          ImageLoader.assetImage(
                              width: 25 * SizeConfig.widthMultiplier!,
                              height: 20 * SizeConfig.heightMultiplier!,
                              imagePath: ImagePath.minicar),
                        Text(
                          widget.manualRide?.vehicleType ?? "",
                          style: AppTextStyle.text14Nblack0000W400,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (widget.manualRide?.cancelRide == false)
              CustomSizedBox(
                height: 5,
              ),
            CustomSizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(
                left: 8 * SizeConfig.widthMultiplier!,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 5 * SizeConfig.heightMultiplier!,
                        bottom: 5 * SizeConfig.heightMultiplier!),
                    margin: EdgeInsets.only(
                        right: 40 * SizeConfig.widthMultiplier!),
                    decoration: BoxDecoration(
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
                            "${widget.manualRide?.estDistance.toString() ?? ""}",
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
                            "${widget.manualRide?.estTime.toString() ?? ""}",
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
                          widget.manualRide?.estTolls != null
                              ? Container(
                                  padding: EdgeInsets.all(
                                      5 * SizeConfig.widthMultiplier!),
                                  decoration: BoxDecoration(
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
                                        "${widget.manualRide?.estTolls.toString() ?? ""}",
                                        style: TextStyle(
                                          color: AppColors.kBlackTextColor,
                                          fontWeight: FontWeight.w700,
                                        ),
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
            CustomSizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(
                  left: 8 * SizeConfig.widthMultiplier!,
                  right: 8 * SizeConfig.widthMultiplier!),
              child: UsableSingleAddressRow(
                textStyle: AppTextStyle.text14black0000W700?.copyWith(
                  color: AppColors.kBlackTextColor.withOpacity(0.70),
                ),
                maxline: 3,
                pickupImagePath: ImagePath.dropRideIcon,
                dropupImagePath: ImagePath.dropRideIcon,
                pickupAddress: "${widget.manualRide?.pickupAddress ?? ''} ",
                dropUpAddress: widget.manualRide?.dropoffAddress ?? '',
              ),
            ),
            CustomSizedBox(
              height: 15,
            ),
            // if (widget.tripStatus == TripStatus.booked)
            //   BlocBuilder<TripEquatableCubit, TripEquatableState>(
            //     builder: (context, state) {
            //       return Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           BLueButtonWithIcon(
            //               wantMargin: false,
            //               borderColor: AppColors.kTransparent,
            //               width: 160 * SizeConfig.widthMultiplier!,
            //               borderRadius: 8 * SizeConfig.widthMultiplier!,
            //               height: 40 * SizeConfig.heightMultiplier!,
            //               isLoading: state.getTravelDriversApiStatus.isLoading,
            //               buttonIsEnabled:
            //                   widget.manualRide?.assignRide == "yes",
            //               title: "Assign Ride",
            //               onTap: widget.assignTabOnTap),
            //           CustomSizedBox(
            //             width: 8,
            //           ),
            //           BLueButtonWithIcon(
            //               buttonColor: AppColors.red534A.withOpacity(0.9),
            //               width: 160 * SizeConfig.widthMultiplier!,
            //               borderColor: Colors.transparent,
            //               wantMargin: false,
            //               textColor: AppColors.kWhite,
            //               buttonIsEnabled:
            //                   widget.manualRide?.cancelRide == "yes",
            //               borderRadius: 8 * SizeConfig.widthMultiplier!,
            //               height: 40 * SizeConfig.heightMultiplier!,
            //               title: "Cancel Ride",
            //               onTap: widget.cancelOnTap)
            //         ],
            //       );
            //     },
            //   ),
            if (widget.tripStatus == TripStatus.assigned)
              BlocBuilder<TripEquatableCubit, TripEquatableState>(
                builder: (context, state) {
                  return Center(
                    child: BLueButtonWithIcon(
                        buttonColor: Color(0xffEDAE10),
                        borderColor: Colors.transparent,
                        wantMargin: false,
                        textColor: AppColors.kWhite,
                        buttonIsEnabled: widget.manualRide?.cancelRide == "yes",
                        borderRadius: 8 * SizeConfig.widthMultiplier!,
                        height: 40 * SizeConfig.heightMultiplier!,
                        title: "Cancel Ride",
                        onTap: widget.cancelOnTap),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
