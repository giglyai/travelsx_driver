import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/home/hire_driver_bloc/cubit/hire_driver_cubit.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart'
    as manual_ride;
import 'package:travelx_driver/home/models/ride_response_model.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/local_storage/log_in_status.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/container_with_border/container_with_border.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/constants/app_styles/app_styles.dart';
import '../../shared/widgets/buttons/blue_button.dart';
import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/size_config/size_config.dart';
import 'available_trip_shimmer.dart';

class ListRideScreen extends StatefulWidget {
  ListRideScreen(
      {super.key,
      required this.radiusManualRide,
      required this.rideType,
      required this.feature});

  String radiusManualRide;

  String rideType;
  String feature;

  @override
  State<ListRideScreen> createState() => _ListRideScreenState();
}

class _ListRideScreenState extends State<ListRideScreen> {
  int? selectIndex;
  late HomeCubit _homeCubit;
  List<manual_ride.Ride> manualRide = [];

  LogInStatus userHasLoggedIn = LogInStatus();

  int selectedRideIndex = 0;

  String rideType = "travel";

  bool isTravelRide = false;
  bool? isSelected;
  int? isSelectedDriverIndex;
  int? isSelectedRideIndex;
  String? customerType;

  goToRideStatusRoute(RideStatus rideStatus) {
    switch (rideStatus) {
      case RideStatus.accepted:
        userHasLoggedIn.storeGotDriverData(
          ride: manualRide[selectedRideIndex],
        );

        Navigator.pushReplacementNamed(
          context,
          arguments: manualRide[selectedRideIndex],
          RouteName.rideDirectionsScreen,
        );

        break;
      case RideStatus.declined:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Navigator.of(context).canPop()) {
            AnywhereDoor.pop(context);
          }
        });

        break;
      case RideStatus.unresponsive:
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   if (Navigator.of(context).canPop()) {
        //     AnywhereDoor.pop(context);
        //   }
        // });
        break;
      case RideStatus.arrivedAtPickup:
        // TODO: Handle this case.
        break;
      case RideStatus.pickedUp:
        // TODO: Handle this case.
        break;
      case RideStatus.arrivedAtDropOff:
        // TODO: Handle this case.
        break;
      case RideStatus.delivered:
        // TODO: Handle this case.
        break;
      case RideStatus.ontrip:
        // TODO: Handle this case.
        break;
      case RideStatus.none:
        // TODO: Handle this case.
        break;
      case RideStatus.cancel:
        // TODO: Handle this case.
        break;
      case RideStatus.started:
        // TODO: Handle this case.
        break;
    }
  }

  late HireDriverCubit _hireDriverCubit;

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _hireDriverCubit = BlocProvider.of<HireDriverCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _hireDriverCubit.fetchManualRides(
          searchRadius: widget.radiusManualRide,
          rideType: widget.rideType,
          feature: widget.feature);
    });

    super.initState();
  }

  int? controllerTab = 0;
  bool enableDropdown = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RideBackButton(),
                Padding(
                  padding:
                      EdgeInsets.only(top: 40 * SizeConfig.heightMultiplier!),
                  child: Text(
                    "Rides",
                    style: AppTextStyle.text20black0000W600,
                  ),
                ),
                Container(
                  width: 50,
                ),
              ],
            ),
            CustomSizedBox(
              height: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HireDriverCubit, HireState>(
                    builder: (context, state) {
                  if (state.actingDriverRideApiStatus.isLoading == true) {
                    return const AvailableTripShimmer();
                  }

                  if (state.actingDriverRideApiStatus.empty) {
                    return Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 300 * SizeConfig.heightMultiplier!,
                        ),
                        child: Text(
                          state.manualRideMessage ?? "",
                          style: AppTextStyle.text16black0000W500,
                        ),
                      ),
                    );
                  }

                  return Wrap(
                    children:
                        List.generate(state.actingDriverRides.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelectedRideIndex = index;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 10 * SizeConfig.heightMultiplier!,
                            left: 20 * SizeConfig.widthMultiplier!,
                            right: 20 * SizeConfig.widthMultiplier!,
                            bottom: 14 * SizeConfig.heightMultiplier!,
                          ),
                          child: Container(
                              padding: EdgeInsets.only(
                                  bottom: 10 * SizeConfig.heightMultiplier!),
                              decoration: BoxDecoration(
                                border: isSelectedRideIndex == index
                                    ? Border.all(color: AppColors.kBlue3D6)
                                    : Border.all(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.19)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      color: AppColors.kBlackTextColor
                                          .withOpacity(0.19)),
                                ],
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(
                                    8 * SizeConfig.widthMultiplier!),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 12 * SizeConfig.widthMultiplier!,
                                  top: 12 * SizeConfig.heightMultiplier!,
                                  bottom: 12 * SizeConfig.heightMultiplier!,
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
                                          containerColor:
                                              AppColors.kBlack1E2E2E,
                                          borderColor: AppColors.kBlack1E2E2E,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15 *
                                                    SizeConfig.widthMultiplier!,
                                                right: 15 *
                                                    SizeConfig.widthMultiplier!,
                                                top: 2 *
                                                    SizeConfig
                                                        .heightMultiplier!,
                                                bottom: 2 *
                                                    SizeConfig
                                                        .heightMultiplier!),
                                            child: Text(
                                              state.actingDriverRides[index]
                                                      .rideFeature ??
                                                  "",
                                              style: AppTextStyle
                                                  .text12kWhiteFFW500,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${state.actingDriverRides[index].payment?.amount?.toString()} ${state.actingDriverRides[index].payment?.currency.toString()}",
                                          style:
                                              AppTextStyle.text20black0000W700,
                                        ),
                                        CustomSizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    CustomSizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ID: ${state.actingDriverRides[index].rideId}",
                                          style: AppTextStyle
                                              .text12black0000W400
                                              ?.copyWith(
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.50)),
                                        ),
                                      ],
                                    ),
                                    CustomSizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 4 * SizeConfig.heightMultiplier!,
                                          bottom:
                                              4 * SizeConfig.heightMultiplier!),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.kGreyD5DDE0),
                                          color: AppColors.kWhite,
                                          borderRadius: BorderRadius.circular(
                                              10 *
                                                  SizeConfig.widthMultiplier!)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 11 *
                                                SizeConfig.widthMultiplier!,
                                            right: 5 *
                                                SizeConfig.widthMultiplier!),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${state.actingDriverRides[index].tripDetails?.distance.toString() ?? ""} ${state.actingDriverRides[index].tripDetails?.distanceUnit.toString() ?? ""}",
                                              style: AppTextStyle
                                                  .text12kRed907171W500,
                                            ),
                                            CustomSizedBox(
                                              width: 3,
                                            ),
                                            SizedBox(
                                                height: 10 *
                                                    SizeConfig
                                                        .heightMultiplier!,
                                                child: VerticalDivider(
                                                  thickness: 1,
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.18),
                                                )),
                                            Text(
                                              "${state.actingDriverRides[index].tripDetails?.duration.toString() ?? ""} ${state.actingDriverRides[index].tripDetails?.durationUnit.toString() ?? ""}",
                                              style: AppTextStyle
                                                  .text12kRed907171W500,
                                            ),
                                            if (state
                                                        .actingDriverRides[
                                                            index]
                                                        .tripDetails
                                                        ?.noOfTolls !=
                                                    null &&
                                                state
                                                        .actingDriverRides[
                                                            index]
                                                        .tripDetails!
                                                        .noOfTolls! >
                                                    0)
                                              SizedBox(
                                                  height: 10 *
                                                      SizeConfig
                                                          .heightMultiplier!,
                                                  child: VerticalDivider(
                                                    thickness: 1,
                                                    color: AppColors
                                                        .kBlackTextColor
                                                        .withOpacity(0.18),
                                                  )),
                                            state
                                                            .actingDriverRides[
                                                                index]
                                                            .tripDetails
                                                            ?.noOfTolls !=
                                                        null &&
                                                    state
                                                            .actingDriverRides[
                                                                index]
                                                            .tripDetails!
                                                            .noOfTolls! >
                                                        0
                                                ? Container(
                                                    padding: EdgeInsets.all(5 *
                                                        SizeConfig
                                                            .widthMultiplier!),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .kWhiteFFFF,
                                                        borderRadius: BorderRadius
                                                            .circular(21 *
                                                                SizeConfig
                                                                    .widthMultiplier!)),
                                                    child: Row(
                                                      children: [
                                                        ImageLoader
                                                            .svgPictureAssetImage(
                                                                imagePath:
                                                                    ImagePath
                                                                        .tollIcon),
                                                        CustomSizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "${state.actingDriverRides[index].tripDetails?.noOfTolls.toString() ?? ""} tolls",
                                                          style: AppTextStyle
                                                              .text12kRed907171W500,
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
                                              left: 9 *
                                                  SizeConfig.widthMultiplier!,
                                              right: 9 *
                                                  SizeConfig.widthMultiplier!,
                                              top: 5 *
                                                  SizeConfig.heightMultiplier!,
                                              bottom: 5 *
                                                  SizeConfig.heightMultiplier!),
                                          decoration: BoxDecoration(
                                            color: AppColors.kWhiteEAE4E4
                                                .withOpacity(0.48),
                                            borderRadius: BorderRadius.circular(
                                                16 *
                                                    SizeConfig
                                                        .widthMultiplier!),
                                          ),
                                          child: Row(
                                            children: [
                                              ImageLoader.svgPictureAssetImage(
                                                  imagePath:
                                                      ImagePath.checkRadioIcon),
                                              CustomSizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                state.actingDriverRides[index]
                                                        .rideType ??
                                                    "",
                                                style: AppTextStyle
                                                    .text12black0000W500,
                                              )
                                            ],
                                          ),
                                        ),
                                        CustomSizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 9 *
                                                  SizeConfig.widthMultiplier!,
                                              right: 9 *
                                                  SizeConfig.widthMultiplier!,
                                              top: 5 *
                                                  SizeConfig.heightMultiplier!,
                                              bottom: 5 *
                                                  SizeConfig.heightMultiplier!),
                                          decoration: BoxDecoration(
                                            color: AppColors.kWhiteEAE4E4
                                                .withOpacity(0.48),
                                            borderRadius: BorderRadius.circular(
                                                16 *
                                                    SizeConfig
                                                        .widthMultiplier!),
                                          ),
                                          child: Row(
                                            children: [
                                              ImageLoader.svgPictureAssetImage(
                                                  imagePath:
                                                      ImagePath.checkRadioIcon),
                                              CustomSizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                state.actingDriverRides[index]
                                                        .rideVehicle ??
                                                    "",
                                                style: AppTextStyle
                                                    .text12black0000W500,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomSizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Pickup time",
                                          style:
                                              AppTextStyle.text14black0000W400,
                                        ),
                                        CustomSizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          state.actingDriverRides[index]
                                                  .tripSequence[0].pickupTime ??
                                              '',
                                          style:
                                              AppTextStyle.text16black0000W700,
                                        ),
                                      ],
                                    ),
                                    CustomSizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ImageLoader.svgPictureAssetImage(
                                            width: 20 *
                                                SizeConfig.widthMultiplier!,
                                            height: 20 *
                                                SizeConfig.widthMultiplier!,
                                            imagePath:
                                                ImagePath.locationIconGreen),
                                        CustomSizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${state.actingDriverRides[index].tripSequence[0].address} (Pickup)",
                                            style: AppTextStyle
                                                .text14black0000W400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomSizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ImageLoader.svgPictureAssetImage(
                                            width: 20 *
                                                SizeConfig.widthMultiplier!,
                                            height: 20 *
                                                SizeConfig.widthMultiplier!,
                                            imagePath:
                                                ImagePath.locationIconGreen),
                                        CustomSizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${state.actingDriverRides[index].tripSequence[1].address} (Dropoff)",
                                            style: AppTextStyle
                                                .text14black0000W400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomSizedBox(
                                      height: 10,
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
                                          state.actingDriverRides[index]
                                                  .tripSequence[0].firstName ??
                                              "",
                                          style:
                                              AppTextStyle.text14black0000W400,
                                        )
                                      ],
                                    ),
                                    CustomSizedBox(
                                      height: 13,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right:
                                              8 * SizeConfig.widthMultiplier!),
                                      child: BlueButton(
                                          buttonIsEnabled:
                                              isSelectedRideIndex == index,
                                          wantMargin: false,
                                          height:
                                              40 * SizeConfig.heightMultiplier!,
                                          title: "Accept",
                                          isLoading:
                                              isSelectedRideIndex == index
                                                  ? state.driverMutateRideStatus
                                                      .isLoading
                                                  : false,
                                          onTap: () async {
                                            isSelectedRideIndex = index;
                                            setState(() {});

                                            if ((state
                                                        .actingDriverRides[
                                                            isSelectedRideIndex ??
                                                                0]
                                                        .rideCommn
                                                        ?.reqAmount ??
                                                    0) ==
                                                0) {
                                              bool? getValue = await _hireDriverCubit
                                                  .mutateAcceptRides(
                                                      rideID:
                                                          state.actingDriverRides[index].rideId ??
                                                              '',
                                                      rideStatus:
                                                          RideStatus.accepted,
                                                      userDeviceToken: state
                                                              .actingDriverRides[
                                                                  index]
                                                              .user
                                                              ?.deviceToken ??
                                                          '',
                                                      userAmount: state
                                                              .actingDriverRides[
                                                                  index]
                                                              .payment
                                                              ?.amount ??
                                                          '',
                                                      userCurrency: state
                                                              .actingDriverRides[index]
                                                              .payment
                                                              ?.currency ??
                                                          '',
                                                      userMode: state.actingDriverRides[index].payment?.mode ?? '',
                                                      userPaymentStatus: state.actingDriverRides[index].payment?.status ?? '',
                                                      mutationReason: '',
                                                      rideCommn: RideCommn(
                                                        totalCommn: state
                                                            .actingDriverRides[
                                                                isSelectedRideIndex ??
                                                                    0]
                                                            .rideCommn
                                                            ?.totalCommn,
                                                        reqAmount: state
                                                            .actingDriverRides[
                                                                isSelectedRideIndex ??
                                                                    0]
                                                            .rideCommn
                                                            ?.reqAmount,
                                                        currency: state
                                                            .actingDriverRides[
                                                                isSelectedRideIndex ??
                                                                    0]
                                                            .rideCommn
                                                            ?.currency,
                                                        desc: state
                                                                .actingDriverRides[
                                                                    isSelectedRideIndex ??
                                                                        0]
                                                                .rideCommn
                                                                ?.desc ??
                                                            "",
                                                      ));

                                              if (getValue == true) {
                                                AnywhereDoor
                                                    .pushReplacementNamed(
                                                        context,
                                                        routeName: RouteName
                                                            .homeScreen);
                                              }
                                            } else {
                                              _hireDriverCubit
                                                  .showAddMoneyBottomSheet(
                                                totalAmount: state
                                                        .actingDriverRides[
                                                            isSelectedRideIndex ??
                                                                0]
                                                        .rideCommn
                                                        ?.reqAmount ??
                                                    0,
                                                desc: state
                                                        .actingDriverRides[
                                                            isSelectedRideIndex ??
                                                                0]
                                                        .rideCommn
                                                        ?.desc ??
                                                    "",
                                                radiusManualRide:
                                                    widget.radiusManualRide,
                                                rideType: widget.rideType,
                                                feature: widget.feature,
                                                walletAmount: state
                                                        .actingDriverRides[
                                                            isSelectedRideIndex ??
                                                                0]
                                                        .rideCommn
                                                        ?.walletBalance ??
                                                    0,
                                              );
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }),
                  );
                }),

                // BlocConsumer<HomeCubit, HomeState>(
                //     listener: (context, state) {
                //   if (state is MutateRideSuccess) {
                //     goToRideStatusRoute(state.rideStatus);
                //   }
                //
                //   if (state is AcceptedByOtherDriver) {
                //     WidgetsBinding.instance.addPostFrameCallback((_) {
                //       rideAcceptedByOtherDriver(context: context);
                //     });
                //   }
                // }, builder: (context, state) {
                //   if (state is GotManualRideSuccess) {
                //     manualRide = state.manualSearchRides;
                //   }
                //
                //   if (state is ManualRidesLoadingData) {
                //     return const AvailableTripShimmer();
                //   }
                //
                //   if (state is GotManualRideSuccess) {
                //     return Container(
                //       margin: EdgeInsets.only(
                //         left: 9 * SizeConfig.widthMultiplier!,
                //         right: 8 * SizeConfig.widthMultiplier!,
                //         top: 16 * SizeConfig.heightMultiplier!,
                //       ),
                //       decoration: BoxDecoration(
                //         color: AppColors.kWhiteFAFAFB,
                //         borderRadius: BorderRadius.circular(
                //             6 * SizeConfig.widthMultiplier!),
                //       ),
                //       child: Wrap(
                //         children: List.generate(
                //             manualRide.length,
                //             (index) => MannualRideCard(
                //                   selectedIndex: index,
                //                   isSelected: selectedRideIndex == index,
                //                   onTapCard: () {
                //                     setState(() {
                //                       selectedRideIndex = index;
                //                     });
                //                   },
                //                   manualRide: manualRide[index],
                //                   onTap: () async {
                //                     setState(() {
                //                       selectedRideIndex = index;
                //                     });
                //
                //                     await _homeCubit.mutateRides(
                //                         tripId: manualRide[index].rideTripId ??
                //                             '',
                //                         rateID:
                //                             manualRide[index].price?.id ?? '',
                //                         rideID:
                //                             manualRide[index].rideId ?? '',
                //                         rideStatus: RideStatus.accepted,
                //                         userDeviceToken:
                //                             manualRide[selectedRideIndex]
                //                                     .user
                //                                     ?.deviceToken ??
                //                                 '',
                //                         userAmount:
                //                             manualRide[selectedRideIndex]
                //                                     .payment
                //                                     ?.amount ??
                //                                 '',
                //                         userCurrency:
                //                             manualRide[selectedRideIndex]
                //                                     .payment
                //                                     ?.currency ??
                //                                 '',
                //                         userMode:
                //                             manualRide[selectedRideIndex]
                //                                     .payment
                //                                     ?.mode ??
                //                                 '',
                //                         userPaymentStatus:
                //                             manualRide[selectedRideIndex]
                //                                     .payment
                //                                     ?.status ??
                //                                 '',
                //                         mutationReason: '');
                //                   },
                //                 )),
                //       ),
                //     );
                //   }
                //   return Align(
                //     alignment: Alignment.center,
                //     child: Padding(
                //       padding: EdgeInsets.only(
                //         top: 300 * SizeConfig.heightMultiplier!,
                //       ),
                //       child: Text(
                //         "No Ride Available at this moment",
                //         style: AppTextStyle.text16black0000W500,
                //       ),
                //     ),
                //   );
                // }),
                CustomSizedBox(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> rideAcceptedByOtherDriver({
    required BuildContext context,
    String? message,
  }) {
    return showDialog(
        context: context,
        barrierColor: AppColors.kBlackTextColor.withOpacity(0.45),
        barrierDismissible: true,
        builder: (context) {
          return Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 210 * SizeConfig.heightMultiplier!,
                    left: 20 * SizeConfig.widthMultiplier!,
                    right: 20 * SizeConfig.widthMultiplier!),
                child: Container(
                  height: 150 * SizeConfig.heightMultiplier!,
                  width: 320 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                      color: AppColors.kRedD32F2F,
                      borderRadius: BorderRadius.circular(
                          5 * SizeConfig.widthMultiplier!)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 14 * SizeConfig.heightMultiplier!,
                          left: 10 * SizeConfig.widthMultiplier!,
                        ),
                        child: Row(
                          children: [
                            ImageLoader.svgPictureAssetImage(
                                height: 24 * SizeConfig.heightMultiplier!,
                                width: 24 * SizeConfig.widthMultiplier!,
                                imagePath: ImagePath.errorOutlineIcon),
                            CustomSizedBox(
                              width: 7,
                            ),
                            Text(
                              "Ride Accepted by other driver",
                              style: AppTextStyle.text16kWhiteW600,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      CustomSizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 40 * SizeConfig.widthMultiplier!,
                        ),
                        child: Text(
                          "Ride has been Accepted by the other \ndriver.",
                          style: AppTextStyle.text14kWhiteW600.copyWith(
                              color: AppColors.kWhite.withOpacity(0.80)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  usableVanRow({String? title}) {
    return Row(
      children: [
        ImageLoader.svgPictureAssetImage(
            width: 16 * SizeConfig.widthMultiplier!,
            height: 16 * SizeConfig.heightMultiplier!,
            imagePath: ImagePath.carIcon),
        CustomSizedBox(
          width: 8,
        ),
        Text(
          title ?? "",
          style: AppTextStyle.text13black0000W400,
        ),
      ],
    );
  }
}
