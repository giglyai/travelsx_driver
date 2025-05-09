import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelx_driver/home/models/distance_matrix_model.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/widgets/buttons/blue_button.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../container_with_border/container_with_border.dart';

class DraggableRideCardScreen extends StatelessWidget {
  final TripSequence? rideSequence;
  final DistanceMatrix? distanceMatrix;
  final Function() onArrival;
  final Function() onConfirmation;
  final int currentSequence;
  final bool? isArrived;
  final bool? isArrivedAtDropUp;
  final bool isLoading;
  final bool buttonConfirmationEnabled;

  const DraggableRideCardScreen({
    Key? key,
    required this.rideSequence,
    required this.onArrival,
    required this.currentSequence,
    this.distanceMatrix,
    required this.onConfirmation,
    this.isArrived,
    this.isArrivedAtDropUp,
    this.isLoading = false,
    this.buttonConfirmationEnabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double maxChildSize = 0.52;
    double minChildSize = 0.38;
    double initialChildSize = 0.38;
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
                      height: 386 * SizeConfig.heightMultiplier!,
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
                          Center(
                            child: distanceMatrix?.duration == 'Arriving Soon'
                                ? ContainerWithBorder(
                                    child: Text(
                                      'Arriving Soon',
                                      style: textStyle(),
                                    ),
                                  )
                                : ContainerWithBorder(
                                    width: 250 * SizeConfig.widthMultiplier!,
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
                                                SizeConfig.widthMultiplier!),
                                        rideSequence?.type ==
                                                LocationRideType.pickup
                                                    .getLocationRideTypeString
                                            ? SvgPicture.asset(
                                                ImagePath.cartIcon)
                                            : SvgPicture.asset(
                                                ImagePath.cartIcon),
                                        SizedBox(
                                            width: 15 *
                                                SizeConfig.widthMultiplier!),
                                        Text(distanceMatrix?.distance ?? '--',
                                            style: textStyle()),
                                      ],
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
                                    style: TextStyle(
                                        color: AppColors.kBlackTextColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            12 * SizeConfig.textMultiplier!),
                                  ),
                              ],
                            ),
                          ),
                          CustomSizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20 * SizeConfig.widthMultiplier!,
                                right: 5 * SizeConfig.widthMultiplier!),
                            child: SizedBox(
                              child: Text(
                                rideSequence?.address ?? '',
                                style: TextStyle(
                                    color: AppColors.kBlackTextColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12 * SizeConfig.textMultiplier!),
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
                          SizedBox(
                            height: 15 * SizeConfig.heightMultiplier!,
                          ),
                          divider(),
                          SizedBox(
                            height: 10 * SizeConfig.heightMultiplier!,
                          ),
                          SizedBox(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 30 * SizeConfig.widthMultiplier!,
                                bottom: 10 * SizeConfig.heightMultiplier!,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImagePath.locationIconGreen),
                                  SizedBox(
                                      width: 15 * SizeConfig.widthMultiplier!),
                                  Expanded(
                                    child: Text(
                                      rideSequence?.address ?? '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppColors.kBlackTextColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              14 * SizeConfig.textMultiplier!),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          divider(),
                          SizedBox(
                            height: 17 * SizeConfig.heightMultiplier!,
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
                          child: !(isArrived ?? false)
                              ? BlueButton(
                                  isLoading: isLoading,
                                  wantMargin: false,
                                  title: isArrivedAtDropUp == true
                                      ? "REACHED"
                                      : "ARRIVED",
                                  onTap: onArrival,
                                )
                              : BlueButton(
                                  isLoading: isLoading,
                                  buttonIsEnabled:
                                      rideSequence?.type == "pickup"
                                          ? true
                                          : buttonConfirmationEnabled,
                                  wantMargin: false,
                                  title: rideSequence?.type ==
                                          LocationRideType
                                              .pickup.getLocationRideTypeString
                                      ? 'PICKEDUP'
                                      : 'COMPLETED',
                                  onTap: onConfirmation,
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
                  else
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: height * 0.1,
                        width: double.maxFinite,
                        color: AppColors.kWhite,
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
