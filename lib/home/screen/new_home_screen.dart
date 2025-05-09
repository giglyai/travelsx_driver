import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/home/hire_driver_bloc/entity/accepted_hire_ride.dart';
import 'package:travelx_driver/home/revamp/bloc/main_home_cubit.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/google_map/google-map.widget.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/constants/imagePath/image_paths.dart';
import '../../shared/local_storage/user_repository.dart';
import '../../shared/utils/image_loader/image_loader.dart';
import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/size_config/size_config.dart';

class NewHomeScreen extends StatefulWidget {
  NewHomeScreen({Key? key, this.rideId, this.activeRide}) : super(key: key);

  String? rideId;
  ActingRide? activeRide;

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeCubit _homeCubit;
  late MainHomeCubit mainHomeCubit;
  bool isRiderAvailable = true;
  FocusNode focusNode = FocusNode();
  int selectAdvanceIndexCar = 0;
  final List<SelectRideType> getSelectRideType = SelectRideType.all.getAll;
  final List<SelectRideAvailable> getSelectedRideAvailability =
      SelectRideAvailable.nearMe.getAll;
  String? selectedRideType;
  String? selectedRideAvailability;
  String? selectedApiRideAvailability;
  int? selectedRideIndex;
  String? selectName;

  getUserCurrentLocation() async {
    final currentPosition = await Utils.getCurrentLocation();
    UserRepository.instance.setUserCurrentLat(currentPosition.latitude);
    UserRepository.instance.setUserCurrentLong(currentPosition.longitude);
    UserRepository.instance.init();
  }

  @override
  void initState() {
    super.initState();
    Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    _homeCubit = context.read();
    mainHomeCubit = context.read();
    mainHomeCubit.getUserData();
    mainHomeCubit.getUpcomingOnTripRideData();
    mainHomeCubit.getRideHomeData();
    mainHomeCubit.getRidesMatrix();
    _homeCubit.postUserCurrentLocation();
    if (mounted) {
      Future.delayed(const Duration(microseconds: 400), () {
        mainHomeCubit.getAppVersion();
      });
    }

    getUserCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BlocBuilder<MainHomeCubit, MainHomeState>(
          builder: (context, state) {
            if (state.getUserProfileData?.data?.isActive == false) {
              return mainHomeCubit.showAccountBlockedBottomSheet();
            } else if (state
                        .getUserProfileData
                        ?.data
                        ?.missingDocs
                        ?.isNotEmpty ==
                    true &&
                state.isOnTripBottomSheetIsOpen == true) {
              return mainHomeCubit.showDocumentUploadBottomSheet();
            } else if (state.getUserProfileData?.data?.missingDocs?.isEmpty ==
                    true &&
                state.getUserProfileData?.data?.joiningFee?.status ==
                    "pending" &&
                state.isOnTripBottomSheetIsOpen == true) {
              return mainHomeCubit.showJoiningFeePendingBottomSheet();
            } else if (state.getUserProfileData?.data?.vehicleType?.isEmpty ==
                    true &&
                state.isOnTripBottomSheetIsOpen == true) {
              return mainHomeCubit.showAddOrSelectVehicleBottomSheet();
            } else if (state.getUserProfileData?.data?.missingDocs?.isEmpty ==
                    true &&
                state.getUserProfileData?.data?.accountStatus == "pending" &&
                state.isOnTripBottomSheetIsOpen == true) {
              return mainHomeCubit.showUploadDocumentStatusBottomSheet();
            }
            if (state.upComingRideData?.data?.upcomingRide?.isNotEmpty ==
                    true ||
                state.upComingRideData?.data?.newRide?.isNotEmpty == true &&
                    state.isOnTripBottomSheetIsOpen == true) {
              return Padding(
                padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                child: mainHomeCubit.showAcceptedRideBottomSheet(),
              );
            }

            return mainHomeCubit.showHomeScreenNoBookingBottomSheet();
            // return const SizedBox.shrink();
          },
        ),
        body: Stack(
          children: [
            const GoogleMapWidget(),
            Column(
              children: [
                Row(
                  children: [
                    BlocBuilder<MainHomeCubit, MainHomeState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.homeDrawer);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 30 * SizeConfig.heightMultiplier!,
                              left: 0.0 * SizeConfig.widthMultiplier!,
                            ),
                            child: ImageLoader.svgPictureAssetImage(
                              imagePath: ImagePath.drawersIcon,
                              wantsScale: true,
                              scale: 1.2,
                            ),
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 30 * SizeConfig.heightMultiplier!,
                      ),
                      child: BlocConsumer<HomeCubit, HomeState>(
                        buildWhen: (previous, current) {
                          return current is UpdateRiderAvailability ||
                              current is RiderToggleLoadingState;
                        },
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is UpdateRiderAvailability) {
                            isRiderAvailable = state.isRiderAvailable;
                          }

                          if (state is RiderToggleLoadingState) {
                            return Container(
                              width: 80 * SizeConfig.widthMultiplier!,
                              height: 30 * SizeConfig.heightMultiplier!,
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 15 * SizeConfig.heightMultiplier!,
                                  width: 15 * SizeConfig.widthMultiplier!,
                                  child: const CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }

                          if (state is UpdateRiderAvailability) {
                            return FlutterSwitch(
                              activeColor: AppColors.kGrey626262,
                              inactiveColor: AppColors.kGrey626262,
                              showOnOff: true,
                              toggleColor:
                                  isRiderAvailable
                                      ? AppColors.kGreenSolid
                                      : AppColors.kRedSolid,
                              width: 120 * SizeConfig.widthMultiplier!,
                              height: 40 * SizeConfig.heightMultiplier!,
                              inactiveText: "offline".tr,
                              activeText: "online".tr,
                              activeTextColor: AppColors.kWhite,
                              inactiveTextColor: AppColors.kWhite,
                              toggleSize: 25 * SizeConfig.imageSizeMultiplier!,
                              value: isRiderAvailable,
                              borderRadius: 16 * SizeConfig.widthMultiplier!,
                              padding: 10 * SizeConfig.widthMultiplier!,
                              onToggle: (val) async {
                                await _homeCubit.updateRiderAvailabilityStatus(
                                  availabilityStatus: val,
                                );
                              },
                            );
                          }

                          return FlutterSwitch(
                            activeColor: AppColors.kGrey626262,
                            inactiveColor: AppColors.kGrey626262,
                            showOnOff: true,
                            toggleColor:
                                isRiderAvailable
                                    ? AppColors.kGreenSolid
                                    : AppColors.kRedSolid,
                            width: 104 * SizeConfig.widthMultiplier!,
                            height: 40 * SizeConfig.heightMultiplier!,
                            inactiveText: "offline".tr,
                            activeText: "online".tr,
                            activeTextColor: AppColors.kWhite,
                            inactiveTextColor: AppColors.kWhite,
                            toggleSize: 25 * SizeConfig.imageSizeMultiplier!,
                            value: isRiderAvailable,
                            borderRadius: 16 * SizeConfig.widthMultiplier!,
                            onToggle: (val) async {
                              await _homeCubit.updateRiderAvailabilityStatus(
                                availabilityStatus: val,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    const SizedBox.shrink(),
                    const Spacer(),
                  ],
                ),
                const Spacer(),

                BlocBuilder<MainHomeCubit, MainHomeState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 135 * SizeConfig.heightMultiplier!,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 14 * SizeConfig.heightMultiplier!,
                            bottom: 16 * SizeConfig.heightMultiplier!,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 14 * SizeConfig.widthMultiplier!,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(
                              8 * SizeConfig.widthMultiplier!,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0 * SizeConfig.widthMultiplier!,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Business Overview',
                                  style: AppTextStyle.text16black0000W400,
                                ),
                                Text(
                                  'Total views of your business'.tr,
                                  style: AppTextStyle.text12black0000W300,
                                ),
                                CustomSizedBox(height: 10),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors
                                            .kWhite, //background color of dropdown button
                                    border: Border.all(
                                      color: AppColors.kBlackTextColor,
                                      width: 1 * SizeConfig.widthMultiplier!,
                                    ), //border of dropdown button
                                    borderRadius: BorderRadius.circular(
                                      40 * SizeConfig.widthMultiplier!,
                                    ),
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: selectName,
                                    hint: Padding(
                                      padding: EdgeInsets.only(
                                        left: 20 * SizeConfig.widthMultiplier!,
                                        right: 20 * SizeConfig.widthMultiplier!,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            EarningActivity
                                                .today
                                                .getEarningActivityString,
                                            style: TextStyle(
                                              color: AppColors.kBlackTextColor
                                                  .withOpacity(0.70),
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  16 *
                                                  SizeConfig.textMultiplier!,
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size:
                                                20 *
                                                SizeConfig.imageSizeMultiplier!,
                                          ),
                                        ],
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value:
                                            EarningActivity
                                                .today
                                                .getEarningActivityString,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                            right:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                EarningActivity
                                                    .today
                                                    .getEarningActivityString,
                                                style: TextStyle(
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.70),
                                                  fontSize:
                                                      16 *
                                                      SizeConfig
                                                          .textMultiplier!,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size:
                                                    20 *
                                                    SizeConfig
                                                        .imageSizeMultiplier!,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value:
                                            EarningActivity
                                                .yesterday
                                                .getEarningActivityString,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                            right:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                EarningActivity
                                                    .yesterday
                                                    .getEarningActivityString,
                                                style: TextStyle(
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.70),
                                                  fontSize:
                                                      16 *
                                                      SizeConfig
                                                          .textMultiplier!,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size:
                                                    20 *
                                                    SizeConfig
                                                        .imageSizeMultiplier!,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value:
                                            EarningActivity
                                                .lastweek
                                                .getEarningActivityString,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                            right:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                EarningActivity
                                                    .lastweek
                                                    .getEarningActivityString,
                                                style: TextStyle(
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.70),
                                                  fontSize:
                                                      16 *
                                                      SizeConfig
                                                          .textMultiplier!,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size:
                                                    20 *
                                                    SizeConfig
                                                        .imageSizeMultiplier!,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value:
                                            EarningActivity
                                                .thisWeek
                                                .getEarningActivityString,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                            right:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                EarningActivity
                                                    .thisWeek
                                                    .getEarningActivityString,
                                                style: TextStyle(
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.70),
                                                  fontSize:
                                                      16 *
                                                      SizeConfig
                                                          .textMultiplier!,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size:
                                                    20 *
                                                    SizeConfig
                                                        .imageSizeMultiplier!,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value:
                                            EarningActivity
                                                .lastmonth
                                                .getEarningActivityString,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                            right:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                EarningActivity
                                                    .lastmonth
                                                    .getEarningActivityString,
                                                style: TextStyle(
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.70),
                                                  fontSize:
                                                      16 *
                                                      SizeConfig
                                                          .textMultiplier!,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size:
                                                    20 *
                                                    SizeConfig
                                                        .imageSizeMultiplier!,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value:
                                            EarningActivity
                                                .thisMonth
                                                .getEarningActivityString,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                            right:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                EarningActivity
                                                    .thisMonth
                                                    .getEarningActivityString,
                                                style: TextStyle(
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.70),
                                                  fontSize:
                                                      16 *
                                                      SizeConfig
                                                          .textMultiplier!,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size:
                                                    20 *
                                                    SizeConfig
                                                        .imageSizeMultiplier!,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) async {
                                      //get value when changed
                                      setState(() {
                                        selectName = value;
                                      });

                                      if (selectName ==
                                              EarningActivity
                                                  .today
                                                  .getEarningActivityString ||
                                          selectName ==
                                              EarningActivity
                                                  .yesterday
                                                  .getEarningActivityString ||
                                          selectName ==
                                              EarningActivity
                                                  .thisWeek
                                                  .getEarningActivityString ||
                                          selectName ==
                                              EarningActivity
                                                  .thisMonth
                                                  .getEarningActivityString ||
                                          selectName ==
                                              EarningActivity
                                                  .lastweek
                                                  .getEarningActivityString ||
                                          selectName ==
                                              EarningActivity
                                                  .lastmonth
                                                  .getEarningActivityString) {
                                        mainHomeCubit.getRidesMatrix(
                                          date: selectName,
                                        );
                                      } else {
                                        mainHomeCubit.getRidesMatrix(
                                          date: selectName,
                                        );
                                      }
                                    },

                                    iconEnabledColor:
                                        AppColors.kWhite, //Icon color
                                    style: TextStyle(
                                      color: AppColors.kBlackTextColor
                                          .withOpacity(0.70),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16 * SizeConfig.textMultiplier!,
                                    ),

                                    dropdownColor:
                                        AppColors
                                            .kWhite, //dropdown background color
                                    underline: Container(), //remove underline
                                  ),
                                ),
                                CustomSizedBox(height: 15),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        orderDetailsCard(
                                          title: "All",
                                          count:
                                              state
                                                  .getAllTripsData
                                                  ?.data
                                                  ?.all
                                                  ?.length ??
                                              0,
                                          color: const Color(0xff362E20),
                                        ),
                                        orderDetailsCard(
                                          title: "Assigned",
                                          count:
                                              state
                                                  .getAllTripsData
                                                  ?.data
                                                  ?.assigned
                                                  ?.length ??
                                              0,
                                          color: const Color(0xff1366BF),
                                        ),
                                      ],
                                    ),
                                    CustomSizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        orderDetailsCard(
                                          title: "Completed",
                                          count:
                                              state
                                                  .getAllTripsData
                                                  ?.data
                                                  ?.completed
                                                  ?.length ??
                                              0,
                                          color: const Color(0xff0A855B),
                                        ),
                                        orderDetailsCard(
                                          title: "Cancelled",
                                          count:
                                              state
                                                  .getAllTripsData
                                                  ?.data
                                                  ?.cancelled
                                                  ?.length ??
                                              0,
                                          color: const Color(0xffC4423B),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Column(
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(
                //         left: 5 * SizeConfig.widthMultiplier!,
                //         right: 5 * SizeConfig.widthMultiplier!,
                //       ),
                //       child: Container(
                //         padding: EdgeInsets.only(
                //           left: 12 * SizeConfig.widthMultiplier!,
                //           right: 12 * SizeConfig.widthMultiplier!,
                //           top: 8 * SizeConfig.heightMultiplier!,
                //           bottom: 8 * SizeConfig.heightMultiplier!,
                //         ),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(
                //               8 * SizeConfig.widthMultiplier!),
                //           color: AppColors.kGreyE8E4E4,
                //           border: Border.all(
                //               color: Colors.transparent,
                //               width: 0.4 * SizeConfig.widthMultiplier!),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Expanded(
                //               child: Container(
                //                 padding: EdgeInsets.only(
                //                   left: 23 * SizeConfig.widthMultiplier!,
                //                   right: 23 * SizeConfig.widthMultiplier!,
                //                   top: 11 * SizeConfig.heightMultiplier!,
                //                   bottom: 11 * SizeConfig.heightMultiplier!,
                //                 ),
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(
                //                       5.0 * SizeConfig.widthMultiplier!),
                //                   color: AppColors.kWhite,
                //                   border: Border.all(
                //                       color: Colors.transparent,
                //                       width: 0.4 * SizeConfig.widthMultiplier!),
                //                 ),
                //                 child: DropdownButtonHideUnderline(
                //                   child: DropdownButton<String>(
                //                     value: selectedRideType,
                //                     style: AppTextStyle.text12black0000W400,
                //                     hint: Text(
                //                       "All",
                //                       style: AppTextStyle.text14kblack333333W600,
                //                     ),
                //                     items: getSelectRideType
                //                         .map((SelectRideType value) {
                //                       return DropdownMenuItem(
                //                         value: value.toName,
                //                         child: Row(
                //                           children: [
                //                             Text(
                //                               value.toName,
                //                               style: AppTextStyle
                //                                   .text14kblack333333W600,
                //                             ),
                //                           ],
                //                         ),
                //                       );
                //                     }).toList(),
                //                     isExpanded: true,
                //                     isDense: true,
                //                     onChanged: (getselectRideType) {
                //                       selectedRideType = getselectRideType;
                //
                //                       setState(() {});
                //                     },
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             CustomSizedBox(
                //               width: 20,
                //             ),
                //             Expanded(
                //               child: Container(
                //                 padding: EdgeInsets.only(
                //                   left: 23 * SizeConfig.widthMultiplier!,
                //                   right: 23 * SizeConfig.widthMultiplier!,
                //                   top: 11 * SizeConfig.heightMultiplier!,
                //                   bottom: 11 * SizeConfig.heightMultiplier!,
                //                 ),
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(
                //                       5.0 * SizeConfig.widthMultiplier!),
                //                   color: AppColors.kWhite,
                //                   border: Border.all(
                //                       color: Colors.transparent,
                //                       width: 0.4 * SizeConfig.widthMultiplier!),
                //                 ),
                //                 child: DropdownButtonHideUnderline(
                //                   child: DropdownButton<String>(
                //                     value: selectedRideAvailability,
                //                     style: AppTextStyle.text12black0000W400,
                //                     hint: Text(
                //                       "Near me",
                //                       style: AppTextStyle.text14kblack333333W600,
                //                     ),
                //                     items: getSelectedRideAvailability
                //                         .map((SelectRideAvailable value) {
                //                       return DropdownMenuItem(
                //                         value: value.toName,
                //                         onTap: () {
                //                           selectedApiRideAvailability =
                //                               value.toValue;
                //                           setState(() {});
                //                         },
                //                         child: Row(
                //                           children: [
                //                             Text(
                //                               value.toName,
                //                               style: AppTextStyle
                //                                   .text14kblack333333W600,
                //                             ),
                //                           ],
                //                         ),
                //                       );
                //                     }).toList(),
                //                     isExpanded: true,
                //                     isDense: true,
                //                     onChanged: (getSelectRideAvailable) {
                //                       selectedRideAvailability =
                //                           getSelectRideAvailable;
                //
                //                       setState(() {});
                //                     },
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     CustomSizedBox(
                //       height: 25,
                //     ),
                //     BlocBuilder<MainHomeCubit, MainHomeState>(
                //       builder: (context, state) {
                //         return BlueButton(
                //           title: "search".tr,
                //           wantMargin: false,
                //           height: 46 * SizeConfig.widthMultiplier!,
                //           borderRadius: 10 * SizeConfig.widthMultiplier!,
                //           buttonColor: AppColors.kGreen199675,
                //           onTap: () {
                //             if (state.getUserProfileData?.data?.joiningFee
                //                     ?.status ==
                //                 "pending") {
                //               mainHomeCubit.onDragabbleBottmSheetChanges(true);
                //             } else {
                //               Navigator.pushNamedAndRemoveUntil(
                //                   context,
                //                   RouteName.listRideScreen,
                //                   (Route<dynamic> val) => true,
                //                   arguments: ListRideScreen(
                //                     feature: "book_ride",
                //                     radiusManualRide:
                //                         selectedApiRideAvailability ?? "30",
                //                     rideType:
                //                         selectedRideType?.toLowerCase() ?? "all",
                //                   ));
                //             }
                //           },
                //         );
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  orderDetailsCard({String? title, int? count, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10 * SizeConfig.widthMultiplier!),
        border: Border.all(
          color: AppColors.kBlackTextColor.withOpacity(0.14),
          width: 1 * SizeConfig.widthMultiplier!,
        ),
      ),
      width: 153 * SizeConfig.widthMultiplier!,
      child: Padding(
        padding: EdgeInsets.only(
          top: 10.0 * SizeConfig.heightMultiplier!,
          left: 10 * SizeConfig.widthMultiplier!,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title ?? "", style: AppTextStyle.text14kWhiteFFFFW400),
            CustomSizedBox(height: 10 * SizeConfig.heightMultiplier!),
            Text(
              "${count ?? 0.toString()}",
              style: AppTextStyle.text20kWhiteW600,
            ),
            CustomSizedBox(height: 39),
          ],
        ),
      ),
    );
  }
}
