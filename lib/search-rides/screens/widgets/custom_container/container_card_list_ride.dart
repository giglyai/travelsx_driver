import 'package:flutter/material.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart'
    as manual_ride;
import 'package:travelx_driver/shared/widgets/container_with_border/container_with_border.dart';
import 'package:travelx_driver/shared/widgets/usable_address_row/single_address_row.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/constants/app_colors/app_colors.dart';
import '../../../../shared/constants/app_styles/app_styles.dart';
import '../../../../shared/constants/imagePath/image_paths.dart';
import '../../../../shared/utils/image_loader/image_loader.dart';
import '../../../../shared/widgets/buttons/blue_button.dart';
import '../../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../../shared/widgets/size_config/size_config.dart';
import '../../../../shared/utils/utilities.dart';

// class ListContainerCard extends StatelessWidget {
//   manual_ride.Ride? manualRide;
//   VoidCallback? onTap;
//   int selectedIndex;
//   ListContainerCard(
//       {super.key, this.manualRide, this.onTap, required this.selectedIndex});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(
//         left: 5 * SizeConfig.widthMultiplier!,
//         right:5 * SizeConfig.widthMultiplier!,
//         top: 12 * SizeConfig.heightMultiplier!,
//         bottom: 11 * SizeConfig.heightMultiplier!,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.kWhiteFFFF,
//         boxShadow: [
//           BoxShadow(
//               color: AppColors.kBlackTextColor.withOpacity(0.14),
//               blurRadius: 15,
//               offset: const Offset(0.0, 0.0)),
//         ],
//         borderRadius: BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 left: 8.0 * SizeConfig.widthMultiplier!,
//                 top: 10 * SizeConfig.heightMultiplier!),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   "ID : ${manualRide?.rideId ?? ""}",
//                   style: AppTextStyle.text12black0000W400?.copyWith(
//                       color: AppColors.kBlackTextColor.withOpacity(0.50)),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Container(
//                   padding: EdgeInsets.only(
//                       left: 5 * SizeConfig.widthMultiplier!,
//                       right: 5 * SizeConfig.widthMultiplier!,
//                       top: 8 * SizeConfig.heightMultiplier!,
//                       bottom: 8 * SizeConfig.heightMultiplier!),
//                   margin: EdgeInsets.only(
//                     left: 10 * SizeConfig.widthMultiplier!,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius:
//                         BorderRadius.circular(10 * SizeConfig.widthMultiplier!),
//                     color: AppColors.bPinkFFEAEA,
//                   ),
//                   child: Center(
//                     child: Text(
//                       manualRide?.tripSequence[0].pickupTime ?? "",
//                       style: AppTextStyle.text12kBlackTextColorW700,
//                     ),
//                   )),
//               Container(
//                   margin: EdgeInsets.only(
//                     left: 8 * SizeConfig.widthMultiplier!,
//                   ),
//                   padding: EdgeInsets.only(
//                       top: 10 * SizeConfig.heightMultiplier!,
//                       bottom: 10 * SizeConfig.heightMultiplier!),
//                   decoration: BoxDecoration(
//                     color: AppColors.kWhiteFAFAFB,
//                     borderRadius:
//                         BorderRadius.circular(10 * SizeConfig.widthMultiplier!),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: 2* SizeConfig.widthMultiplier!,
//                       right: 2 * SizeConfig.widthMultiplier!,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         ImageLoader.assetImage(
//                             height: 14 * SizeConfig.heightMultiplier!,
//                             width: 25 * SizeConfig.heightMultiplier!,
//                             imagePath: ImagePath.uberCarIcon),
//                         CustomSizedBox(
//                           width: 1,
//                         ),
//                         SizedBox(
//                           width: 70 * SizeConfig.widthMultiplier!,
//                           child: Text(
//                             manualRide?.rideVehicle ?? "",
//                             style: AppTextStyle.text12kBlackTextColorW500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//               // "Trip $selectedIndex",
//
//               const Spacer(),
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: 6 * SizeConfig.heightMultiplier!,
//                   right: 16 * SizeConfig.widthMultiplier!,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       "${manualRide?.price?.totalPrice ?? ""} ${manualRide?.price?.currency ?? ""}",
//                       style: AppTextStyle.text24kBlackTextColorW700,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           "Includes all",
//                           style: AppTextStyle.text12kBlackTextColorW300,
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           CustomSizedBox(
//             height: 4,
//           ),
//           manualRide?.rideAval == false
//               ? Padding(
//                   padding:
//                       EdgeInsets.only(left: 8.0 * SizeConfig.widthMultiplier!),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         manualRide?.rideAvalTime ?? "",
//                         style: AppTextStyle.text12black0000W400?.copyWith(
//                             color: AppColors.kBlackTextColor.withOpacity(0.53)),
//                       ),
//                     ],
//                   ),
//                 )
//               : SizedBox.shrink(),
//           if (manualRide?.rideAval == false)
//             CustomSizedBox(
//               height: 10,
//             ),
//           Padding(
//             padding: EdgeInsets.only(
//                 left: 8.0 * SizeConfig.widthMultiplier!,
//                 right: 8 * SizeConfig.widthMultiplier!),
//             child: Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                       left: 9 * SizeConfig.widthMultiplier!,
//                       right: 9 * SizeConfig.widthMultiplier!,
//                       top: 5 * SizeConfig.heightMultiplier!,
//                       bottom: 5 * SizeConfig.heightMultiplier!),
//                   decoration: BoxDecoration(
//                     color: AppColors.bPinkFFEAEA,
//                     borderRadius:
//                         BorderRadius.circular(16 * SizeConfig.widthMultiplier!),
//                   ),
//                   child: Row(
//                     children: [
//                       ImageLoader.svgPictureAssetImage(
//                           imagePath: ImagePath.checkRadioIcon),
//                       CustomSizedBox(
//                         width: 7,
//                       ),
//                       Text(
//                         manualRide?.rideType.toString().capitalize() ?? "",
//                       ),
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//                 Container(
//                   margin:
//                       EdgeInsets.only(right: 10 * SizeConfig.widthMultiplier!),
//                   padding: EdgeInsets.only(
//                       top: 10 * SizeConfig.heightMultiplier!,
//                       bottom: 10 * SizeConfig.heightMultiplier!),
//                   decoration: BoxDecoration(
//                     color: AppColors.kWhiteFAFAFB,
//                     borderRadius:
//                         BorderRadius.circular(10 * SizeConfig.widthMultiplier!),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         left: 20 * SizeConfig.widthMultiplier!,
//                         right: 20 * SizeConfig.widthMultiplier!),
//                     child: Row(
//                       children: [
//                         Text(
//                           "${manualRide?.tripDetails?.distance ?? ""} ${manualRide?.tripDetails?.distanceUnit ?? ""}",
//                           style: AppTextStyle.text12kBlackTextColorW600,
//                         ),
//                         CustomSizedBox(
//                           width: 8,
//                         ),
//                         ImageLoader.svgPictureAssetImage(
//                             imagePath: ImagePath.manualDotIcon,
//                             color: AppColors.kBlackTextColor),
//                         CustomSizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "${manualRide?.tripDetails?.duration ?? ""} ${manualRide?.tripDetails?.durationUnit ?? ""}",
//                           style: AppTextStyle.text12kBlackTextColorW600,
//                         ),
//                         CustomSizedBox(
//                           width: 8,
//                         ),
//                         ImageLoader.svgPictureAssetImage(
//                             imagePath: ImagePath.manualDotIcon,
//                             color: AppColors.kBlackTextColor),
//                         CustomSizedBox(
//                           width: 10,
//                         ),
//                         ImageLoader.svgPictureAssetImage(
//                             imagePath: ImagePath.tollIcon,
//                             color: AppColors.kBlackTextColor),
//                         CustomSizedBox(
//                           width: 8,
//                         ),
//                         Text(
//                           "${manualRide?.tripDetails?.noOfTolls.toString() ?? ""} tolls",
//                           style: AppTextStyle.text12kBlackTextColorW600,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(),
//               ],
//             ),
//           ),
//           CustomSizedBox(
//             height: 15,
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 19 * SizeConfig.widthMultiplier!),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 ImageLoader.svgPictureAssetImage(
//                   imagePath: ImagePath.ridePickupIcon,
//                 ),
//                 CustomSizedBox(
//                   width: 9,
//                 ),
//                 Expanded(
//                   child: Text(
//                     "${manualRide?.tripSequence[0].address ?? ''} ",
//                     style: AppTextStyle.text14kBlackTextColorW600,
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(
//                     right: 10 * SizeConfig.widthMultiplier!,
//                   ),
//                   width: 59 * SizeConfig.widthMultiplier!,
//                   height: 21 * SizeConfig.heightMultiplier!,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                           10 * SizeConfig.widthMultiplier!),
//                       color: AppColors.kWhite,
//                       border: Border.all(
//                           color: AppColors.kBlue1A73E8.withOpacity(0.40))),
//                   child: Center(
//                       child: Text(
//                     "Pickup",
//                     style: AppTextStyle.text12kBlackTextColorW500.copyWith(
//                       color: AppColors.kBlackTextColor.withOpacity(0.50),
//                     ),
//                   )),
//                 )
//               ],
//             ),
//           ),
//           CustomSizedBox(
//             height: 21,
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 19 * SizeConfig.widthMultiplier!),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ImageLoader.svgPictureAssetImage(
//                     imagePath: ImagePath.ridePickupIcon),
//                 CustomSizedBox(
//                   width: 9,
//                 ),
//                 Expanded(
//                   child: Text(
//                     manualRide?.tripSequence[1].address ?? '',
//                     style: AppTextStyle.text14kBlackTextColorW600,
//                   ),
//                 ),
//                 Container(
//                     margin: EdgeInsets.only(
//                       right: 10 * SizeConfig.widthMultiplier!,
//                     ),
//                     width: 59 * SizeConfig.widthMultiplier!,
//                     height: 21 * SizeConfig.heightMultiplier!,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                             10 * SizeConfig.widthMultiplier!),
//                         color: AppColors.kWhite,
//                         border: Border.all(
//                             color: AppColors.kBlue1A73E8.withOpacity(0.40))),
//                     child: Center(
//                       child: Text(
//                         "Drop-off",
//                         style: AppTextStyle.text12kBlackTextColorW500.copyWith(
//                             color: AppColors.kBlackTextColor.withOpacity(0.50)),
//                       ),
//                     )),
//               ],
//             ),
//           ),
//           CustomSizedBox(
//             height: 21,
//           ),
//           BlueButton(
//               buttonIsEnabled: manualRide?.rideAval == true,
//               borderRadius: 10 * SizeConfig.widthMultiplier!,
//               height: 40 * SizeConfig.heightMultiplier!,
//               title: "Accept",
//               onTap: onTap),
//           CustomSizedBox(
//             height: 14,
//           ),
//         ],
//       ),
//     );
//   }
// }

class MannualRideCard extends StatelessWidget {
  MannualRideCard(
      {Key? key,
      this.onTap,
      required this.selectedIndex,
      this.isSelected = false,
      this.onTapCard,
      this.manualRide})
      : super(key: key);

  manual_ride.Ride? manualRide;
  VoidCallback? onTap;
  int selectedIndex;
  bool? isSelected;

  VoidCallback? onTapCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        padding: EdgeInsets.only(bottom: 10 * SizeConfig.heightMultiplier!),
        margin: EdgeInsets.only(bottom: 10 * SizeConfig.heightMultiplier!),
        decoration: BoxDecoration(
          border: isSelected == true
              ? Border.all(color: AppColors.kBlue3D6)
              : Border.all(color: AppColors.kBlackTextColor.withOpacity(0.19)),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: AppColors.kBlackTextColor.withOpacity(0.19)),
          ],
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
                    "ID : ${manualRide?.rideId ?? ""}",
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
                          if (manualRide?.rideVehicle == "maxicab" ||
                              (manualRide?.rideVehicle == "maxicab coach"))
                            ImageLoader.assetImage(
                                width: 30 * SizeConfig.widthMultiplier!,
                                height: 30 * SizeConfig.heightMultiplier!,
                                imagePath: ImagePath.maxiCabIcon)
                          else
                            ImageLoader.assetImage(
                                imagePath: ImagePath.uberCarIcon),
                          Text(
                            manualRide?.rideVehicle ?? "",
                            style: AppTextStyle.text14Nblack0000W400,
                          ),
                        ],
                      ),
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
                          child: manualRide?.createdBy?.name == 'Gigly'
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
                                manualRide?.createdBy?.name ?? "",
                                style: TextStyle(
                                  fontSize: 14 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.kBlackTextColor,
                                ),
                              ),
                              CustomSizedBox(height: 2),
                              Text(
                                manualRide?.createdBy?.subText ?? "",
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
                        manualRide?.price?.totalPrice ?? '',
                        style: GoogleFonts.urbanist(
                          fontSize: 30 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w700,
                          color: AppColors.kBlackTextColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "(${manualRide?.price?.priceText ?? ''})",
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
                            manualRide?.price?.currency ?? '',
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
            manualRide?.rideAval == false
                ? Padding(
                    padding: EdgeInsets.only(
                        left: 8.0 * SizeConfig.widthMultiplier!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          manualRide?.rideAvalTime ?? "",
                          style: AppTextStyle.text12black0000W400?.copyWith(
                              color:
                                  AppColors.kBlackTextColor.withOpacity(0.53)),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            if (manualRide?.rideAval == false)
              CustomSizedBox(
                height: 10,
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
                          manualRide?.rideType.toString().capitalize() ?? "",
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
                            "${manualRide?.tripDetails?.distance.toString() ?? ""} ${manualRide?.tripDetails?.distanceUnit.toString() ?? ""}",
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
                            "${manualRide?.tripDetails?.duration.toString() ?? ""} ${manualRide?.tripDetails?.durationUnit.toString() ?? ""}",
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
                          manualRide?.tripDetails?.noOfTolls != null
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
                                        "${manualRide?.tripDetails?.noOfTolls.toString() ?? ""} tolls",
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
                pickupAddress: "${manualRide?.tripSequence[0].address ?? ''} ",
                dropUpAddress: manualRide?.tripSequence[1].address ?? '',
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
                      fontSize: 11 * SizeConfig.textMultiplier!,
                      color: AppColors.kBlackTextColor,
                    ),
                  ),
                  Text(
                    manualRide?.tripSequence[0].pickupTime ?? '',
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
                      fontSize: 11 * SizeConfig.textMultiplier!,
                      color: AppColors.kBlackTextColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 2.0 * SizeConfig.widthMultiplier!),
                    child: Text(
                      manualRide?.tripSequence[1].dropoffTime.toString() ?? "",
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
            CustomSizedBox(
              height: 20,
            ),
            BlueButton(
                buttonIsEnabled: manualRide?.rideAval == true,
                borderRadius: 10 * SizeConfig.widthMultiplier!,
                height: 40 * SizeConfig.heightMultiplier!,
                title: "Accept",
                onTap: onTap),
            CustomSizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
