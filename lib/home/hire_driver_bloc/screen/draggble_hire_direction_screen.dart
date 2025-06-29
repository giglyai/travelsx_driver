import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelx_driver/home/models/distance_matrix_model.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/container_with_border/container_with_border.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/widgets/buttons/blue_button.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../entity/upcoming_ontrip_ride_res.dart';

class HireDraggableRideCardScreen extends StatelessWidget {
  final TripSequence? rideSequence;
  final DistanceMatrix? distanceMatrix;
  final Function() onArrival;
  final Function()? onConfirmation;
  final int? currentSequence;
  final bool? isArrived;
  final bool? isArrivedAtDropUp;
  final bool isLoading;
  final RideStatus status;
  final VoidCallback refreshTap;

  HireDraggableRideCardScreen({
    Key? key,
    required this.rideSequence,
    required this.onArrival,
    this.currentSequence,
    this.distanceMatrix,
    this.onConfirmation,
    this.isArrived,
    this.isArrivedAtDropUp,
    this.isLoading = false,
    required this.status,
    required this.refreshTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double maxChildSize = 0.48;
    double minChildSize = 0.45;
    double initialChildSize = 0.45;
    double? remainingDistance =
        double.tryParse(distanceMatrix?.distance?.split(' ').first ?? '');
    return SizedBox(
      height: height,
      child: DraggableScrollableActuator(
        child: DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            maxChildSize: maxChildSize,
            minChildSize: minChildSize,
            builder: (BuildContext context, myScrollController) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    controller: myScrollController,
                    child: Container(
                      height: 300 * SizeConfig.heightMultiplier!,
                      color: AppColors.kWhite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 15 * SizeConfig.heightMultiplier!,
                          ),
                          Center(
                            child: SizedBox(
                              height: 20 * SizeConfig.heightMultiplier!,
                              width: 62 * SizeConfig.widthMultiplier!,
                              child: Divider(
                                color: AppColors.kBlackTextColor,
                                thickness: 3,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15 * SizeConfig.heightMultiplier!,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: distanceMatrix?.duration ==
                                        'Arriving Soon'
                                    ? ContainerWithBorder(
                                        child: Text(
                                          'Arriving Soon',
                                          style: textStyle(),
                                        ),
                                      )
                                    : ContainerWithBorder(
                                        width:
                                            250 * SizeConfig.widthMultiplier!,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              distanceMatrix?.duration ?? '--',
                                              style: textStyle(),
                                            ),
                                            SizedBox(
                                                width: 15 *
                                                    SizeConfig
                                                        .widthMultiplier!),
                                            rideSequence?.type ==
                                                    LocationRideType.pickup
                                                        .getLocationRideTypeString
                                                ? SvgPicture.asset(
                                                    ImagePath.cartIcon)
                                                : SvgPicture.asset(
                                                    ImagePath.cartIcon),
                                            SizedBox(
                                                width: 15 *
                                                    SizeConfig
                                                        .widthMultiplier!),
                                            Text(
                                                distanceMatrix?.distance ??
                                                    '--',
                                                style: textStyle()),
                                          ],
                                        ),
                                      ),
                              ),
                              CustomSizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: refreshTap,
                                child: ImageLoader.svgPictureAssetImage(
                                    imagePath: ImagePath.refereshIcon),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15 * SizeConfig.heightMultiplier!,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "(${rideSequence?.type == LocationRideType.pickup.getLocationRideTypeString ? "Pickup)" : "Dropoff)"}",
                                style: TextStyle(
                                    color: AppColors.kBlackTextColor,
                                    fontSize: 14 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10 * SizeConfig.heightMultiplier!,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20 * SizeConfig.widthMultiplier!,
                                right: 5 * SizeConfig.widthMultiplier!),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (rideSequence?.firstName?.isNotEmpty == true)
                                  ImageLoader.svgPictureAssetImage(
                                      imagePath: ImagePath.userIcon),
                                CustomSizedBox(
                                  width: 5,
                                ),
                                if (rideSequence?.firstName?.isNotEmpty == true)
                                  Text(
                                    rideSequence?.firstName?.capitalize() ?? "",
                                    style: AppTextStyle.text14black0000W700
                                        ?.copyWith(
                                            color: AppColors.kBlackTextColor
                                                .withOpacity(0.70)),
                                  ),
                              ],
                            ),
                          ),
                          CustomSizedBox(
                            height: 10,
                          ),
                          Center(
                            child: SizedBox(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        25 * SizeConfig.widthMultiplier!),
                                child: Text(
                                  rideSequence?.address ?? '',
                                  style: AppTextStyle.text14black0000W500,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15 * SizeConfig.heightMultiplier!,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  try {
                                    final LatLng destination = LatLng(
                                        rideSequence?.position.latitude ?? 0,
                                        rideSequence?.position.longitude ?? 0);

                                    // final LatLng destination =
                                    //     LatLng(28.569588, 77.323109);
                                    Utils.openDirections(
                                        destination: destination);
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                },
                                child: Container(
                                  width: 188 * SizeConfig.widthMultiplier!,
                                  height: 36 * SizeConfig.heightMultiplier!,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                          color: AppColors.kBlue3D6,
                                          width: 1.5 *
                                              SizeConfig.widthMultiplier!)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            ImagePath.directionIcon),
                                        SizedBox(
                                          width:
                                              9 * SizeConfig.widthMultiplier!,
                                        ),
                                        Text(
                                          "Directions",
                                          style: TextStyle(
                                              color: AppColors.kBlue3D6,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 7 * SizeConfig.widthMultiplier!,
                              ),
                              if (rideSequence?.phoneNumber != null)
                                GestureDetector(
                                    onTap: () {
                                      try {
                                        Utils.launchPhoneDialer(
                                            rideSequence?.phoneNumber ?? '');
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                    },
                                    child: SvgPicture.asset(
                                        ImagePath.callIconBlue)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (distanceMatrix?.duration == 'Arriving Soon')
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20 * SizeConfig.widthMultiplier!,
                              vertical: 10 * SizeConfig.heightMultiplier!),
                          child: BlueButton(
                            isLoading: isLoading,
                            wantMargin: false,
                            title: status.toValue,
                            onTap: onArrival,
                          )

                          // ? CustomSwipableButton(
                          //     title: 'Swipe after arrival',
                          //     onConfirmation: onArrival)
                          // : CustomSwipableButton(
                          //     title:
                          //         'Swipe After ${rideSequence?.type == LocationRideType.pickup.getLocationRideTypeString ? 'pickup' : 'Drop-off'}',
                          //     onConfirmation: onConfirmation,
                          //   )
                          ),
                    )
                ],
              );
            }),
      ),
    );
  }

  divider() {
    return SizedBox(
      child: Divider(
        color: AppColors.kBlackTextColor.withOpacity(0.61),
        indent: 20 * SizeConfig.widthMultiplier!,
        endIndent: 20 * SizeConfig.widthMultiplier!,
      ),
    );
  }

  textStyle() {
    return TextStyle(
        color: AppColors.kBlackTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 16 * SizeConfig.textMultiplier!);
  }
}
