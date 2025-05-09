// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart';
import 'package:travelx_driver/home/widget/container_with_border/container_with_border.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/local_storage/user_repository.dart';
import '../../../shared/utils/image_loader/image_loader.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/size_config/size_config.dart';

class RideCardContainer extends StatefulWidget {
  bool? isDisabled;
  RideCardContainer(
      {Key? key,
      this.onTap,
      this.isDisabled,
      this.isSelected = false,
      this.ride,
      this.deliverBy})
      : super(key: key);

  VoidCallback? onTap;

  bool? isSelected;

  Ride? ride;
  String? deliverBy;

  @override
  State<RideCardContainer> createState() => _RideCardContainerState();
}

class _RideCardContainerState extends State<RideCardContainer>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: widget.isSelected == true
              ? [
                  BoxShadow(blurRadius: 20, color: AppColors.kBlueF1F1F1),
                ]
              : null,
          borderRadius: BorderRadius.circular(8 * SizeConfig.widthMultiplier!),
          border: widget.isSelected == true
              ? Border.all(
                  color: AppColors.kBlue3D6,
                )
              : null,
          color: AppColors.kBlueF1F1F1,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10 * SizeConfig.widthMultiplier!),
                      child: Row(
                        children: [
                          // Container(
                          //   padding: EdgeInsets.all(5 * SizeConfig.widthMultiplier!),
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       border: Border.all(color: AppColors.kGreen20F2)),
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(
                          //         10 * SizeConfig.widthMultiplier!),
                          //     child: SvgPicture.network(
                          //       widget.trip?.tripSequence?[0].tenantUrl?.first ?? "",
                          //       width: 25 * SizeConfig.widthMultiplier!,
                          //       height: 25 * SizeConfig.heightMultiplier!,
                          //     ),
                          //   ),
                          // ),
                          CustomSizedBox(
                            width: 10,
                          ),
                          reUsableColumn(
                              title: "TIPS",
                              subtitle:
                                  widget.ride?.price?.currency.toString() ?? "",
                              currencyTitle:
                                  widget.ride?.price?.currency.toString()),
                          CustomSizedBox(
                            width: 8,
                          ),
                          reUsableColumn(
                            title: "PROMO",
                            subtitle:
                                widget.ride?.price?.currency.toString() ?? "",
                            currencyTitle:
                                widget.ride?.price?.currency.toString() ?? "",
                          ),

                          CustomSizedBox(
                            width: 6,
                          ),

                          reUsableColumn(
                            title: "PER KM",
                            subtitle:
                                widget.ride?.price?.currency.toString() ?? "",
                            currencyTitle:
                                widget.ride?.price?.currency.toString() ?? "",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (UserRepository.getProfile == "ride")
                  Text("${widget.ride?.price?.totalPrice?.toString()}",
                      style: TextStyle(
                          color: AppColors.kBlackTextColor,
                          fontSize: 40 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w700)),
                CustomSizedBox(
                  width: 7,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 9 * SizeConfig.widthMultiplier!),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.ride?.price?.currency.toString() ?? "",
                    style: TextStyle(
                        color: AppColors.kBlackTextColor.withOpacity(0.60),
                        fontSize: 14 * SizeConfig.textMultiplier!,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 10 * SizeConfig.widthMultiplier!,
                  bottom: 4 * SizeConfig.heightMultiplier!),
              child: Row(
                children: [
                  Text(
                    widget.deliverBy ?? "",
                    style: TextStyle(
                        color: AppColors.kBlackTextColor.withOpacity(0.60),
                        fontSize: 12 * SizeConfig.textMultiplier!,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  widget.ride?.tripsNearDropoff != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              right: 18.0 * SizeConfig.widthMultiplier!),
                          child: ContainerWithBorder(
                            wantPadding: true,
                            borderColor: AppColors.kWhite,
                            containerColor: AppColors.kWhite,
                            borderRadius: 14 * SizeConfig.widthMultiplier!,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  3 * SizeConfig.widthMultiplier!),
                              child: Center(
                                child: Text(
                                  widget.ride?.tripsNearDropoff ?? "",
                                  style: TextStyle(
                                      color: AppColors.kBlackTextColor
                                          .withOpacity(0.60),
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          10 * SizeConfig.textMultiplier!),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  textStyle() {
    return TextStyle(
        color: AppColors.kBlackTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 14 * SizeConfig.textMultiplier!);
  }

  reUsableColumn({String? title, String? subtitle, String? currencyTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 19 * SizeConfig.widthMultiplier!,
              height: 28 * SizeConfig.heightMultiplier!,
              decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius:
                      BorderRadius.circular(4 * SizeConfig.widthMultiplier!)),
              child: ImageLoader.svgPictureAssetImage(
                  imagePath: ImagePath.boltIcon),
            ),
            CustomSizedBox(
              width: 7,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  style: TextStyle(
                      color: AppColors.kBlackTextColor.withOpacity(0.80),
                      fontSize: 12 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Text(
                      subtitle ?? "",
                      style: TextStyle(
                          color: AppColors.kBlackTextColor.withOpacity(0.70),
                          fontSize: 14 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w900),
                    ),
                    CustomSizedBox(
                      width: 4,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 5 * SizeConfig.heightMultiplier!),
                      child: Text(
                        currencyTitle ?? "",
                        style: TextStyle(
                            fontFeatures: [FontFeature.superscripts()],
                            color: AppColors.kBlackTextColor.withOpacity(0.60),
                            fontSize: 7 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
