// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/home/revamp/bloc/main_home_cubit.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/enums/common_enums.dart';
import 'package:travelx_driver/user/trip/equatable/trip_equatable.dart';
import 'package:travelx_driver/user/trip/models/trip_filter_model.dart'
    as filter;
import 'package:travelx_driver/user/trip/widgets/trip_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../../home/bloc/home_cubit.dart';
import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/app_styles/app_styles.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/utils/image_loader/image_loader.dart';
import '../../../shared/utils/utilities.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../bloc/trip_cubit.dart';
import '../models/trip_single_model.dart';

class UserTripScreen extends StatefulWidget {
  const UserTripScreen({Key? key}) : super(key: key);

  @override
  State<UserTripScreen> createState() => _UserTripScreenState();
}

class _UserTripScreenState extends State<UserTripScreen>
    with SingleTickerProviderStateMixin {
  late TripCubit _tripCubit;
  late HomeCubit _homeCubit;
  String? totalTrip;
  bool hideBreakDown = true;
  bool activityArrow = true;
  int? selectedIndex;
  String? selectName;
  late TabController _tabController;
  TripSingleModel? tripSingleModel;
  filter.TripFilterModel? tripFilterModel;
  List<Activity>? activities;
  List<filter.Activity>? filterActivities;
  int? selectedSingleTripModel;
  int? selectedMultipleTripModel;
  int? controllerTab = 0;
  late TripEquatableCubit tripEquatableCubit;

  final List<TripStatus> allStatus = TripStatus.all.getAll;

  int? statusIndex;
  Color containerColor = Colors.grey.withOpacity(0.3);
  Color baseColor = Colors.grey.withOpacity(0.25);
  Color highlightColor = Colors.white.withOpacity(0.6);
  @override
  void initState() {
    _tripCubit = BlocProvider.of<TripCubit>(context);
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _tripCubit.getSingleTripData(dateFilter: "Today", tripStatus: 'completed');
    _tabController = TabController(length: 3, vsync: this);

    tripEquatableCubit = context.read();
    tripEquatableCubit.getSingleTripData(status: TripStatus.all);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20 * SizeConfig.widthMultiplier!,
                  vertical: 34 * SizeConfig.widthMultiplier!),
              child: Row(
                children: [
                  RideBackButton(
                    padding: EdgeInsets.zero,
                    onTap: () {
                      AnywhereDoor.pop(context);
                      MainHomeCubit().getRidesMatrix();
                    },
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: Text(
                        "trip".tr,
                        style: TextStyle(
                            color: AppColors.kBlackTextColor,
                            fontSize: 20 * SizeConfig.widthMultiplier!,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            BlocBuilder<TripEquatableCubit, TripEquatableState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 6.0 * SizeConfig.widthMultiplier!,
                          right: 6 * SizeConfig.widthMultiplier!),
                      child: SizedBox(
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors
                                  .kWhite, //background color of dropdown button
                              border: Border.all(
                                  color: AppColors.kblueDF0000,
                                  width: 2 *
                                      SizeConfig
                                          .widthMultiplier!), //border of dropdown button
                              borderRadius: BorderRadius.circular(
                                  12 * SizeConfig.widthMultiplier!),
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectName,
                              hint: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 6.0),
                                    child: Text(
                                      EarningActivity
                                          .today.getEarningActivityString,
                                      style: TextStyle(
                                          color: AppColors.kblueDF0000,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              16 * SizeConfig.textMultiplier!),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.kblueDF0000,
                                    size: 20 * SizeConfig.imageSizeMultiplier!,
                                  ),
                                ],
                              ),

                              items: [
                                DropdownMenuItem(
                                  value: EarningActivity
                                      .today.getEarningActivityString,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          EarningActivity
                                              .today.getEarningActivityString,
                                          style: TextStyle(
                                              color: AppColors.kblueDF0000,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.kblueDF0000,
                                        size: 20 *
                                            SizeConfig.imageSizeMultiplier!,
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: EarningActivity
                                      .yesterday.getEarningActivityString,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          EarningActivity.yesterday
                                              .getEarningActivityString,
                                          style: TextStyle(
                                              color: AppColors.kblueDF0000,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.kblueDF0000,
                                        size: 20 *
                                            SizeConfig.imageSizeMultiplier!,
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: EarningActivity
                                      .lastweek.getEarningActivityString,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          EarningActivity.lastweek
                                              .getEarningActivityString,
                                          style: TextStyle(
                                              color: AppColors.kblueDF0000,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.kblueDF0000,
                                        size: 20 *
                                            SizeConfig.imageSizeMultiplier!,
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: EarningActivity
                                      .thisWeek.getEarningActivityString,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          EarningActivity.thisWeek
                                              .getEarningActivityString,
                                          style: TextStyle(
                                              color: AppColors.kblueDF0000,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.kblueDF0000,
                                        size: 20 *
                                            SizeConfig.imageSizeMultiplier!,
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: EarningActivity
                                      .lastmonth.getEarningActivityString,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          EarningActivity.lastmonth
                                              .getEarningActivityString,
                                          style: TextStyle(
                                              color: AppColors.kblueDF0000,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.kblueDF0000,
                                        size: 20 *
                                            SizeConfig.imageSizeMultiplier!,
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: EarningActivity
                                      .thisMonth.getEarningActivityString,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          EarningActivity.thisMonth
                                              .getEarningActivityString,
                                          style: TextStyle(
                                              color: AppColors.kblueDF0000,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.kblueDF0000,
                                        size: 20 *
                                            SizeConfig.imageSizeMultiplier!,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                //get value when changed
                                setState(() {
                                  selectName = value;
                                });

                                tripEquatableCubit.getSingleTripData(
                                    dateFilter: selectName,
                                    status: state.selectedFilter);
                              },

                              iconEnabledColor: AppColors.kWhite, //Icon color
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16 * SizeConfig.textMultiplier!),

                              dropdownColor:
                                  AppColors.kWhite, //dropdown background color
                              underline: Container(), //remove underline
                            )),
                      ),
                    ),
                    CustomSizedBox(
                      height: 20,
                    ),
                    if (state.getAllTripDataApiStatus.success)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!,
                            right: 20 * SizeConfig.widthMultiplier!),
                        child: Row(
                          children: [
                            ...List.generate(
                              allStatus.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(
                                  right: 10 * SizeConfig.widthMultiplier!,
                                ),
                                child: rowContainerCard(
                                  total: state.getTotalValue?[index],
                                  title: allStatus[index].toName,
                                  isSelected:
                                      state.selectedFilter == allStatus[index],
                                  onTap: () {
                                    statusIndex = index;
                                    setState(() {});
                                    tripEquatableCubit
                                        .changeOrderFilter(allStatus[index]);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 20 * SizeConfig.widthMultiplier!,
                              right: 20 * SizeConfig.widthMultiplier!),
                          child: Row(
                            children: [
                              ...List.generate(allStatus.length, (index) {
                                return Shimmer.fromColors(
                                  highlightColor: highlightColor,
                                  baseColor: baseColor,
                                  child: Container(
                                    width: SizeConfig.widthMultiplier! * 100,
                                    height: SizeConfig.heightMultiplier! * 30,
                                    decoration: BoxDecoration(
                                        color: containerColor,
                                        borderRadius: BorderRadius.circular(
                                            10 * SizeConfig.widthMultiplier!)),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    CustomSizedBox(
                      height: 20,
                    ),
                    if (state.tripAllData?.isNotEmpty == true)
                      Wrap(
                        children: List.generate(state.tripAllData?.length ?? 0,
                            (index) {
                          final getData = state.tripAllData?[index];
                          return TripRideCard(
                            selectedIndex: selectedIndex ?? 0,
                            manualRide: getData,
                            isSelected: selectedIndex == index,
                            tripStatus: state.selectedFilter,
                            onTapCard: () {
                              selectedIndex = index;
                              setState(() {});
                            },
                            cancelOnTap: () {
                              selectedIndex = index;
                              setState(() {});
                              tripEquatableCubit.cancelRideConfirmationPop(
                                  context: context,
                                  rideId: state.tripAllData?[selectedIndex ?? 0]
                                          .rideId ??
                                      "",
                                  status: state.selectedFilter);
                            },
                            assignTabOnTap: () {
                              selectedIndex = index;
                              setState(() {});
                            },
                          );
                        }),
                      )
                    else
                      Column(
                        children: [
                          CustomSizedBox(
                            height: 20,
                          ),
                          ImageLoader.svgPictureAssetImage(
                              imagePath: ImagePath.noDriver),
                          CustomSizedBox(
                            height: 20,
                          ),
                          Text(
                            "no_data_available".tr,
                            style: AppTextStyle.text14black0000W300,
                          )
                        ],
                      )
                  ],
                );
              },
            ),

            // Container(
            //   margin: EdgeInsets.symmetric(
            //       horizontal: 5 * SizeConfig.widthMultiplier!),
            //   decoration: BoxDecoration(
            //       color: Color(0xffFFFBE782).withOpacity(.100),
            //       border: Border.all(color: Color(0xffFEC400)),
            //       borderRadius: BorderRadius.only(
            //         topRight: Radius.circular(10 * SizeConfig.widthMultiplier!),
            //         topLeft: Radius.circular(10 * SizeConfig.widthMultiplier!),
            //         bottomLeft:
            //             Radius.circular(10 * SizeConfig.widthMultiplier!),
            //         bottomRight:
            //             Radius.circular(10 * SizeConfig.widthMultiplier!),
            //       )),
            //   child: TabBar(
            //     controller: _tabController,
            //     labelColor: AppColors.kBlackTextColor,
            //     indicatorColor: AppColors.kYellowFFCB00,
            //     isScrollable: false,
            //     onTap: (controller) async {
            //       setState(() {
            //         controllerTab = controller;
            //       });
            //
            //       if (controller == 0) {
            //         await _tripCubit.getSingleTripData(tripStatus: 'completed');
            //       } else if (controller == 1) {
            //         await _tripCubit.getSingleTripData(tripStatus: 'cancelled');
            //       } else if (controller == 2) {
            //         await _tripCubit.getSingleTripData(tripStatus: 'assigned');
            //       }
            //     },
            //     tabs: [
            //       Tab(
            //         child: Text(
            //           "complete".tr,
            //           style: TextStyle(
            //             color: controllerTab == 0
            //                 ? AppColors.kBlack070202
            //                 : AppColors.kGrey433C3C.withOpacity(0.6),
            //             fontWeight: FontWeight.w500,
            //             fontSize: 14 * SizeConfig.textMultiplier!,
            //           ),
            //         ),
            //       ),
            //       Tab(
            //         child: Text(
            //           "cancelled".tr,
            //           style: TextStyle(
            //             color: controllerTab == 1
            //                 ? AppColors.kBlack070202
            //                 : AppColors.kGrey433C3C.withOpacity(0.6),
            //             fontWeight: FontWeight.w500,
            //             fontSize: 14 * SizeConfig.textMultiplier!,
            //           ),
            //         ),
            //       ),
            //       Tab(
            //         child: Text(
            //           "assigned".tr,
            //           style: TextStyle(
            //             color: controllerTab == 2
            //                 ? AppColors.kBlack070202
            //                 : AppColors.kGrey433C3C.withOpacity(0.6),
            //             fontWeight: FontWeight.w500,
            //             fontSize: 14 * SizeConfig.textMultiplier!,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // CustomSizedBox(
            //   height: 20,
            // ),
            // if (controllerTab == 0)
            //   Padding(
            //     padding: EdgeInsets.only(
            //         left: 6.0 * SizeConfig.widthMultiplier!,
            //         right: 6 * SizeConfig.widthMultiplier!),
            //     child: SizedBox(
            //       child: DecoratedBox(
            //           decoration: BoxDecoration(
            //             color: AppColors
            //                 .kWhite, //background color of dropdown button
            //             border: Border.all(
            //                 color: AppColors.kblueDF0000,
            //                 width: 2 *
            //                     SizeConfig
            //                         .widthMultiplier!), //border of dropdown button
            //             borderRadius: BorderRadius.circular(
            //                 12 * SizeConfig.widthMultiplier!),
            //           ),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             value: selectName,
            //             hint: Padding(
            //               padding: EdgeInsets.only(left: 20.0),
            //               child: Row(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     EarningActivity.today.getEarningActivityString,
            //                     style: TextStyle(
            //                         color: AppColors.kblueDF0000,
            //                         fontWeight: FontWeight.w700,
            //                         fontSize: 16 * SizeConfig.textMultiplier!),
            //                   ),
            //                   Icon(
            //                     Icons.arrow_forward_ios_rounded,
            //                     color: AppColors.kblueDF0000,
            //                     size: 20 * SizeConfig.imageSizeMultiplier!,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //
            //             items: [
            //               DropdownMenuItem(
            //                 value:
            //                     EarningActivity.today.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .today.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .yesterday.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .yesterday.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .lastweek.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .lastweek.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .thisWeek.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .thisWeek.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .lastmonth.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .lastmonth.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .thisMonth.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .thisMonth.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //             onChanged: (value) {
            //               //get value when changed
            //               setState(() {
            //                 selectName = value;
            //               });
            //
            //               if (selectName ==
            //                       EarningActivity
            //                           .today.getEarningActivityString ||
            //                   selectName ==
            //                       EarningActivity
            //                           .yesterday.getEarningActivityString) {
            //                 _tripCubit.getSingleTripData(
            //                     dateFilter: selectName,
            //                     tripStatus: 'completed');
            //               } else {
            //                 _tripCubit.getFilterData(
            //                     dateFilter: selectName,
            //                     tripStatus: 'completed');
            //               }
            //             },
            //
            //             iconEnabledColor: AppColors.kWhite, //Icon color
            //             style: TextStyle(
            //                 color: AppColors.kBlackTextColor.withOpacity(0.70),
            //                 fontWeight: FontWeight.w700,
            //                 fontSize: 16 * SizeConfig.textMultiplier!),
            //
            //             dropdownColor:
            //                 AppColors.kWhite, //dropdown background color
            //             underline: Container(), //remove underline
            //           )),
            //     ),
            //   ),
            // if (controllerTab == 0)
            //   BlocConsumer<TripCubit, TripState>(
            //     listener: (context, state) {},
            //     builder: (context, state) {
            //       if (state is GotTripSuccessState) {
            //         int? totalTrips =
            //             state.tripSingleModel.data?.metrics?.totalTrips;
            //
            //         totalTrip = totalTrips.toString();
            //
            //         return Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.only(left: 8.0, top: 10),
            //               child: Row(
            //                 children: [
            //                   Text(
            //                     "completed_trips".tr,
            //                     style: TextStyle(
            //                         color: AppColors.kblueDF0000,
            //                         fontWeight: FontWeight.w500,
            //                         fontSize: 16 * SizeConfig.textMultiplier!),
            //                   ),
            //                   SizedBox(
            //                     width: 15 * SizeConfig.heightMultiplier!,
            //                   ),
            //                   Text(
            //                     "${state.tripSingleModel.data?.metrics?.totalTrips}",
            //                     style: TextStyle(
            //                         color: AppColors.kblueDF0000,
            //                         fontWeight: FontWeight.w500,
            //                         fontSize: 16 * SizeConfig.textMultiplier!),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             SizedBox(
            //               height: 7 * SizeConfig.heightMultiplier!,
            //             ),
            //             SizedBox(
            //               height: 20 * SizeConfig.heightMultiplier!,
            //             ),
            //             Divider(
            //               indent: 31 * SizeConfig.widthMultiplier!,
            //               endIndent: 29 * SizeConfig.widthMultiplier!,
            //               color: AppColors.kBlackTextColor.withOpacity(0.4),
            //               thickness: 0.4 * SizeConfig.widthMultiplier!,
            //             ),
            //             SizedBox(
            //               height: 14 * SizeConfig.heightMultiplier!,
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(
            //                 left: 31 * SizeConfig.widthMultiplier!,
            //                 right: 33 * SizeConfig.widthMultiplier!,
            //               ),
            //               child: Row(
            //                 children: [
            //                   Text(
            //                     "breakdown_trips".tr,
            //                     style: TextStyle(
            //                         color: AppColors.kBlackTextColor,
            //                         fontWeight: FontWeight.w700,
            //                         fontSize: 20 * SizeConfig.textMultiplier!),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Column(
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.only(
            //                     left: 31 * SizeConfig.widthMultiplier!,
            //                     right: 33 * SizeConfig.widthMultiplier!,
            //                   ),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       SizedBox(
            //                         height: 20 * SizeConfig.heightMultiplier!,
            //                       ),
            //                       UsableRow(
            //                         title: "total_distance_trips".tr,
            //                         subTitle: state
            //                                 .tripSingleModel
            //                                 .data
            //                                 ?.metrics
            //                                 ?.breakdown
            //                                 ?.totalDistance ??
            //                             "",
            //                       ),
            //                       UsableRow(
            //                         title: "total_time_trips".tr,
            //                         subTitle: state.tripSingleModel.data
            //                                 ?.metrics?.breakdown?.totalTime
            //                                 .toString() ??
            //                             "",
            //                       ),
            //                       Divider(
            //                         color: AppColors.kBlackTextColor
            //                             .withOpacity(0.4),
            //                         thickness:
            //                             0.4 * SizeConfig.widthMultiplier!,
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             CustomSizedBox(
            //               height: 12 * SizeConfig.heightMultiplier!,
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(
            //                 left: 20 * SizeConfig.widthMultiplier!,
            //                 right: 20 * SizeConfig.widthMultiplier!,
            //               ),
            //               child: Wrap(
            //                   children: List.generate(
            //                 state.tripSingleModel.data?.activities?.length ?? 0,
            //                 (activityIndex) => Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     ...List.generate(
            //                         state
            //                                 .tripSingleModel
            //                                 .data
            //                                 ?.activities?[activityIndex]
            //                                 .length ??
            //                             0,
            //                         (index) => Column(
            //                               crossAxisAlignment:
            //                                   CrossAxisAlignment.start,
            //                               children: [
            //                                 ContainerWithBorder(
            //                                   borderRadius: 8 *
            //                                       SizeConfig.widthMultiplier!,
            //                                   wantPadding: false,
            //                                   borderColor:
            //                                       AppColors.kWhiteF2F3F3,
            //                                   containerColor:
            //                                       AppColors.kWhiteF2F3F3,
            //                                   child: Text(
            //                                     state
            //                                             .tripSingleModel
            //                                             .data
            //                                             ?.activities?[
            //                                                 activityIndex]
            //                                                 [index]
            //                                             .date ??
            //                                         "",
            //                                     style: TextStyle(
            //                                         color: AppColors
            //                                             .kBlackTextColor
            //                                             .withOpacity(0.80),
            //                                         fontWeight: FontWeight.w600,
            //                                         fontSize: 14 *
            //                                             SizeConfig
            //                                                 .textMultiplier!),
            //                                   ),
            //                                 ),
            //                                 CustomSizedBox(
            //                                   height: 5 *
            //                                       SizeConfig.heightMultiplier!,
            //                                 ),
            //                                 Padding(
            //                                   padding: EdgeInsets.only(
            //                                       bottom: 12 *
            //                                           SizeConfig
            //                                               .heightMultiplier!),
            //                                   child: ContainerWithBorder(
            //                                     containerColor:
            //                                         Color(0xffFFFBE782)
            //                                             .withOpacity(.100),
            //                                     borderRadius: 7 *
            //                                         SizeConfig.widthMultiplier!,
            //                                     child: Column(
            //                                       crossAxisAlignment:
            //                                           CrossAxisAlignment.start,
            //                                       mainAxisAlignment:
            //                                           MainAxisAlignment.start,
            //                                       children: [
            //                                         Text(
            //                                           "ID : ${state.tripSingleModel.data?.activities?[activityIndex][index].rideId ?? ""}",
            //                                           style: AppTextStyle
            //                                               .text12black0000W400
            //                                               ?.copyWith(
            //                                             color: AppColors
            //                                                 .kBlackTextColor
            //                                                 .withOpacity(0.61),
            //                                           ),
            //                                         ),
            //                                         CustomSizedBox(
            //                                           height: 11 *
            //                                               SizeConfig
            //                                                   .heightMultiplier!,
            //                                         ),
            //                                         ContainerWithBorder(
            //                                           borderColor:
            //                                               AppColors.kWhite,
            //                                           containerColor:
            //                                               Colors.transparent,
            //                                           borderRadius: 10 *
            //                                               SizeConfig
            //                                                   .widthMultiplier!,
            //                                           child: Row(
            //                                             children: [
            //                                               Row(
            //                                                 children: [
            //                                                   Text("Vehicle : ",
            //                                                       style: AppTextStyle
            //                                                           .text14kBlack090000W700
            //                                                           ?.copyWith(
            //                                                         color: AppColors
            //                                                             .kBlack090000
            //                                                             .withOpacity(
            //                                                                 0.60),
            //                                                       )),
            //                                                   Text(
            //                                                     state
            //                                                             .tripSingleModel
            //                                                             .data
            //                                                             ?.activities?[
            //                                                                 activityIndex]
            //                                                                 [
            //                                                                 index]
            //                                                             .vehicleType ??
            //                                                         "",
            //                                                     style: AppTextStyle
            //                                                         .text14kBlack090000W400
            //                                                         ?.copyWith(
            //                                                       color: AppColors
            //                                                           .kBlack090000
            //                                                           .withOpacity(
            //                                                               0.60),
            //                                                     ),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                               Spacer(),
            //                                               Column(
            //                                                 crossAxisAlignment:
            //                                                     CrossAxisAlignment
            //                                                         .end,
            //                                                 children: [
            //                                                   Text(
            //                                                     "${state.tripSingleModel.data?.activities?[activityIndex][index].fee ?? ""} ${state.tripSingleModel.data?.activities?[activityIndex][index].currency ?? ""}",
            //                                                     style: AppTextStyle
            //                                                         .text16kBlack090000W700,
            //                                                   ),
            //                                                   Text(
            //                                                     '(Includes All)',
            //                                                     style: AppTextStyle
            //                                                         .text10black0000W400
            //                                                         ?.copyWith(
            //                                                             height:
            //                                                                 0.1,
            //                                                             color: AppColors
            //                                                                 .kBlackTextColor
            //                                                                 .withOpacity(0.60)),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ],
            //                                           ),
            //                                         ),
            //                                         CustomSizedBox(
            //                                           height: 10,
            //                                         ),
            //                                         Row(
            //                                           children: [
            //                                             ContainerWithBorder(
            //                                               containerColor: Colors
            //                                                   .transparent,
            //                                               borderColor:
            //                                                   Color(0xff13E800),
            //                                               borderWidth: 1,
            //                                               borderRadius: 16 *
            //                                                   SizeConfig
            //                                                       .widthMultiplier!,
            //                                               child: Row(
            //                                                 children: [
            //                                                   Padding(
            //                                                     padding:
            //                                                         EdgeInsets
            //                                                             .only(
            //                                                       left: 12 *
            //                                                           SizeConfig
            //                                                               .widthMultiplier!,
            //                                                     ),
            //                                                     child: Row(
            //                                                       children: [
            //                                                         ImageLoader.svgPictureAssetImage(
            //                                                             width: 20 *
            //                                                                 SizeConfig
            //                                                                     .widthMultiplier!,
            //                                                             height: 20 *
            //                                                                 SizeConfig
            //                                                                     .heightMultiplier!,
            //                                                             imagePath:
            //                                                                 ImagePath.blueLocIcon),
            //                                                         CustomSizedBox(
            //                                                           width: 10,
            //                                                         ),
            //                                                         Text(
            //                                                           state
            //                                                                   .tripSingleModel
            //                                                                   .data
            //                                                                   ?.activities?[activityIndex][index]
            //                                                                   .rideType
            //                                                               ?.capitalizeFirst ??
            //                                                               "",
            //                                                           style: AppTextStyle
            //                                                               .text14black0000W500
            //                                                               ?.copyWith(
            //                                                                   color: AppColors.kBlack272727),
            //                                                         ),
            //                                                       ],
            //                                                     ),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ),
            //                                             CustomSizedBox(
            //                                               width: 12,
            //                                             ),
            //                                             ContainerWithBorder(
            //                                               containerColor: Colors
            //                                                   .transparent,
            //                                               borderColor:
            //                                                   Color(0xff13E800),
            //                                               borderWidth: 1,
            //                                               borderRadius: 16 *
            //                                                   SizeConfig
            //                                                       .widthMultiplier!,
            //                                               child: Row(
            //                                                 children: [
            //                                                   Text(
            //                                                     state
            //                                                             .tripSingleModel
            //                                                             .data
            //                                                             ?.activities?[
            //                                                                 activityIndex]
            //                                                                 [
            //                                                                 index]
            //                                                             .distance ??
            //                                                         "",
            //                                                     style:
            //                                                         TextStyle(
            //                                                       color: AppColors
            //                                                           .kBlackTextColor,
            //                                                       fontWeight:
            //                                                           FontWeight
            //                                                               .w600,
            //                                                       fontSize: 14 *
            //                                                           SizeConfig
            //                                                               .textMultiplier!,
            //                                                     ),
            //                                                   ),
            //                                                   SizedBox(
            //                                                     width: 2 *
            //                                                         SizeConfig
            //                                                             .widthMultiplier!,
            //                                                   ),
            //                                                   Icon(
            //                                                     Icons.circle,
            //                                                     size: 7 *
            //                                                         SizeConfig
            //                                                             .imageSizeMultiplier!,
            //                                                   ),
            //                                                   SizedBox(
            //                                                     width: 2 *
            //                                                         SizeConfig
            //                                                             .widthMultiplier!,
            //                                                   ),
            //                                                   Text(
            //                                                     state
            //                                                             .tripSingleModel
            //                                                             .data
            //                                                             ?.activities?[
            //                                                                 activityIndex]
            //                                                                 [
            //                                                                 index]
            //                                                             .time ??
            //                                                         "",
            //                                                     style:
            //                                                         TextStyle(
            //                                                       color: AppColors
            //                                                           .kBlackTextColor,
            //                                                       fontWeight:
            //                                                           FontWeight
            //                                                               .w600,
            //                                                       fontSize: 14 *
            //                                                           SizeConfig
            //                                                               .textMultiplier!,
            //                                                     ),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                         CustomSizedBox(
            //                                           height: 10,
            //                                         ),
            //                                         UsableSingleAddressRow(
            //                                           pickupAddress: state
            //                                                   .tripSingleModel
            //                                                   .data
            //                                                   ?.activities?[
            //                                                       activityIndex]
            //                                                       [index]
            //                                                   .pickupAddress ??
            //                                               "",
            //                                           dropUpAddress: state
            //                                                   .tripSingleModel
            //                                                   .data
            //                                                   ?.activities?[
            //                                                       activityIndex]
            //                                                       [index]
            //                                                   .dropoffAddress ??
            //                                               "",
            //                                         ),
            //                                         CustomSizedBox(
            //                                           height: 17 *
            //                                               SizeConfig
            //                                                   .heightMultiplier!,
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ],
            //                             ))
            //                   ],
            //                 ),
            //               )),
            //             ),
            //           ],
            //         );
            //       }
            //
            //       if (state is TripEmptyState) {
            //         return Center(
            //           child: TripCancelEmpty(
            //             message: state.emptyMessage,
            //           ),
            //         );
            //       }
            //       if (state is TripLoadingState) {
            //         return Center(
            //           child: Lottie.asset(ImagePath.loadingAnimation,
            //               height: 50 * SizeConfig.heightMultiplier!,
            //               width: 300 * SizeConfig.widthMultiplier!),
            //         );
            //       }
            //       return Center(
            //           child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text("no_data_available".tr),
            //       ));
            //     },
            //   ),
            // if (controllerTab == 1)
            //   Padding(
            //     padding: EdgeInsets.only(left: 20.0),
            //     child: SizedBox(
            //       child: DecoratedBox(
            //           decoration: BoxDecoration(
            //             color: AppColors
            //                 .kWhite, //background color of dropdown button
            //             border: Border.all(
            //                 color: AppColors.kblueDF0000,
            //                 width: 2 *
            //                     SizeConfig
            //                         .widthMultiplier!), //border of dropdown button
            //             borderRadius: BorderRadius.circular(
            //                 12 * SizeConfig.widthMultiplier!),
            //           ),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             value: selectName,
            //             hint: Row(
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.all(8.0),
            //                   child: Text(
            //                     EarningActivity.today.getEarningActivityString,
            //                     style: TextStyle(
            //                         color: AppColors.kblueDF0000,
            //                         fontWeight: FontWeight.w700,
            //                         fontSize: 16 * SizeConfig.textMultiplier!),
            //                   ),
            //                 ),
            //                 Icon(
            //                   Icons.arrow_forward_ios_rounded,
            //                   color: AppColors.kblueDF0000,
            //                   size: 20 * SizeConfig.imageSizeMultiplier!,
            //                 ),
            //               ],
            //             ),
            //
            //             items: [
            //               DropdownMenuItem(
            //                 value:
            //                     EarningActivity.today.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(
            //                           left: 20.0 * SizeConfig.widthMultiplier!),
            //                       child: Text(
            //                         EarningActivity
            //                             .today.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .yesterday.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(
            //                           left: 20.0 * SizeConfig.widthMultiplier!),
            //                       child: Text(
            //                         EarningActivity
            //                             .yesterday.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .lastweek.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(
            //                           left: 20.0 * SizeConfig.widthMultiplier!),
            //                       child: Text(
            //                         EarningActivity
            //                             .lastweek.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .thisWeek.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(
            //                           left: 20.0 * SizeConfig.widthMultiplier!),
            //                       child: Text(
            //                         EarningActivity
            //                             .thisWeek.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .lastmonth.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(
            //                           left: 20.0 * SizeConfig.widthMultiplier!),
            //                       child: Text(
            //                         EarningActivity
            //                             .lastmonth.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .thisMonth.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .thisMonth.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //             onChanged: (value) {
            //               //get value when changed
            //               setState(() {
            //                 selectName = value;
            //               });
            //
            //               if (selectName ==
            //                       EarningActivity
            //                           .today.getEarningActivityString ||
            //                   selectName ==
            //                       EarningActivity
            //                           .yesterday.getEarningActivityString) {
            //                 _tripCubit.getSingleTripData(
            //                     dateFilter: selectName,
            //                     tripStatus: 'cancelled');
            //               } else {
            //                 _tripCubit.getFilterData(
            //                     dateFilter: selectName,
            //                     tripStatus: 'cancelled');
            //               }
            //             },
            //
            //             iconEnabledColor: AppColors.kWhite, //Icon color
            //             style: TextStyle(
            //                 color: AppColors.kBlackTextColor.withOpacity(0.70),
            //                 fontWeight: FontWeight.w700,
            //                 fontSize: 16 * SizeConfig.textMultiplier!),
            //
            //             dropdownColor:
            //                 AppColors.kWhite, //dropdown background color
            //             underline: Container(), //remove underline
            //           )),
            //     ),
            //   ),
            // if (controllerTab == 1)
            //   BlocConsumer<TripCubit, TripState>(
            //     listener: (context, state) {},
            //     builder: (context, state) {
            //       if (state is GotTripSuccessState) {
            //         int? totalTrips =
            //             state.tripSingleModel.data?.metrics?.totalTrips;
            //
            //         totalTrip = totalTrips.toString();
            //
            //         return Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.only(left: 20.0, top: 10),
            //               child: Row(
            //                 children: [
            //                   Text(
            //                     "completed_trips".tr,
            //                     style: TextStyle(
            //                         color: AppColors.kblueDF0000,
            //                         fontWeight: FontWeight.w500,
            //                         fontSize: 16 * SizeConfig.textMultiplier!),
            //                   ),
            //                   SizedBox(
            //                     width: 7 * SizeConfig.heightMultiplier!,
            //                   ),
            //                   Text(
            //                     "${state.tripSingleModel.data?.metrics?.totalTrips}",
            //                     style: TextStyle(
            //                         color: AppColors.kblueDF0000,
            //                         fontWeight: FontWeight.w700,
            //                         fontSize: 14 * SizeConfig.textMultiplier!),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             SizedBox(
            //               height: 20 * SizeConfig.heightMultiplier!,
            //             ),
            //             Divider(
            //               indent: 31 * SizeConfig.widthMultiplier!,
            //               endIndent: 29 * SizeConfig.widthMultiplier!,
            //               color: AppColors.kBlackTextColor.withOpacity(0.4),
            //               thickness: 0.4 * SizeConfig.widthMultiplier!,
            //             ),
            //             SizedBox(
            //               height: 14 * SizeConfig.heightMultiplier!,
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(
            //                 left: 31 * SizeConfig.widthMultiplier!,
            //                 right: 33 * SizeConfig.widthMultiplier!,
            //               ),
            //               child: Row(
            //                 children: [
            //                   Text(
            //                     "breakdown".tr,
            //                     style: TextStyle(
            //                         color: AppColors.kBlackTextColor,
            //                         fontWeight: FontWeight.w700,
            //                         fontSize: 20 * SizeConfig.textMultiplier!),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Column(
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.only(
            //                     left: 31 * SizeConfig.widthMultiplier!,
            //                     right: 33 * SizeConfig.widthMultiplier!,
            //                   ),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       SizedBox(
            //                         height: 20 * SizeConfig.heightMultiplier!,
            //                       ),
            //                       UsableRow(
            //                         title: "total_distance_trips".tr,
            //                         subTitle: state
            //                                 .tripSingleModel
            //                                 .data
            //                                 ?.metrics
            //                                 ?.breakdown
            //                                 ?.totalDistance ??
            //                             "",
            //                       ),
            //                       UsableRow(
            //                         title: "total_time_trips".tr,
            //                         subTitle: state.tripSingleModel.data
            //                                 ?.metrics?.breakdown?.totalTime
            //                                 .toString() ??
            //                             "",
            //                       ),
            //                       Divider(
            //                         color: AppColors.kBlackTextColor
            //                             .withOpacity(0.4),
            //                         thickness:
            //                             0.4 * SizeConfig.widthMultiplier!,
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             CustomSizedBox(
            //               height: 12 * SizeConfig.heightMultiplier!,
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(
            //                 left: 20 * SizeConfig.widthMultiplier!,
            //                 right: 20 * SizeConfig.widthMultiplier!,
            //               ),
            //               child: Wrap(
            //                   children: List.generate(
            //                 state.tripSingleModel.data?.activities?.length ?? 0,
            //                 (activityIndex) => Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     ...List.generate(
            //                       state.tripSingleModel.data
            //                               ?.activities?[activityIndex].length ??
            //                           0,
            //                       (index) => Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           ContainerWithBorder(
            //                             borderRadius:
            //                                 8 * SizeConfig.widthMultiplier!,
            //                             wantPadding: false,
            //                             borderColor: AppColors.kWhiteF2F3F3,
            //                             containerColor: AppColors.kWhiteF2F3F3,
            //                             child: Text(
            //                               state
            //                                       .tripSingleModel
            //                                       .data
            //                                       ?.activities?[activityIndex]
            //                                           [index]
            //                                       .date ??
            //                                   "",
            //                               style: TextStyle(
            //                                   color: AppColors.kBlackTextColor
            //                                       .withOpacity(0.80),
            //                                   fontWeight: FontWeight.w600,
            //                                   fontSize: 14 *
            //                                       SizeConfig.textMultiplier!),
            //                             ),
            //                           ),
            //                           CustomSizedBox(
            //                             height:
            //                                 5 * SizeConfig.heightMultiplier!,
            //                           ),
            //                           Padding(
            //                             padding: EdgeInsets.only(
            //                                 bottom: 12 *
            //                                     SizeConfig.heightMultiplier!),
            //                             child: ContainerWithBorder(
            //                               containerColor: Color(0xffFFFBE782)
            //                                   .withOpacity(.100),
            //                               borderRadius:
            //                                   7 * SizeConfig.widthMultiplier!,
            //                               child: Column(
            //                                 crossAxisAlignment:
            //                                     CrossAxisAlignment.start,
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.start,
            //                                 children: [
            //                                   Text(
            //                                     "ID : ${state.tripSingleModel.data?.activities?[activityIndex][index].rideId ?? ""}",
            //                                     style: AppTextStyle
            //                                         .text12black0000W400
            //                                         ?.copyWith(
            //                                       color: AppColors
            //                                           .kBlackTextColor
            //                                           .withOpacity(0.61),
            //                                     ),
            //                                   ),
            //                                   CustomSizedBox(
            //                                     height: 11 *
            //                                         SizeConfig
            //                                             .heightMultiplier!,
            //                                   ),
            //                                   ContainerWithBorder(
            //                                     borderColor: AppColors.kWhite,
            //                                     containerColor:
            //                                         Colors.transparent,
            //                                     borderRadius: 10 *
            //                                         SizeConfig.widthMultiplier!,
            //                                     child: Row(
            //                                       children: [
            //                                         Padding(
            //                                           padding: EdgeInsets.only(
            //                                             left: 12 *
            //                                                 SizeConfig
            //                                                     .widthMultiplier!,
            //                                           ),
            //                                           child: Row(
            //                                             children: [
            //                                               Text("Vehicle : ",
            //                                                   style: AppTextStyle
            //                                                       .text14kBlack090000W700
            //                                                       ?.copyWith(
            //                                                     color: AppColors
            //                                                         .kBlack090000
            //                                                         .withOpacity(
            //                                                             0.60),
            //                                                   )),
            //                                               Text(
            //                                                 state
            //                                                         .tripSingleModel
            //                                                         .data
            //                                                         ?.activities?[
            //                                                             activityIndex]
            //                                                             [index]
            //                                                         .vehicleType ??
            //                                                     "",
            //                                                 style: AppTextStyle
            //                                                     .text14kBlack090000W400
            //                                                     ?.copyWith(
            //                                                   color: AppColors
            //                                                       .kBlack090000
            //                                                       .withOpacity(
            //                                                           0.60),
            //                                                 ),
            //                                               ),
            //                                             ],
            //                                           ),
            //                                         ),
            //                                         Spacer(),
            //                                         Column(
            //                                           crossAxisAlignment:
            //                                               CrossAxisAlignment
            //                                                   .end,
            //                                           children: [
            //                                             Text(
            //                                               "${state.tripSingleModel.data?.activities?[activityIndex][index].fee ?? ""} ${state.tripSingleModel.data?.activities?[activityIndex][index].currency ?? ""}",
            //                                               style: AppTextStyle
            //                                                   .text16kBlack090000W700,
            //                                             ),
            //                                             Text(
            //                                               '(Includes All)',
            //                                               style: AppTextStyle
            //                                                   .text10black0000W400
            //                                                   ?.copyWith(
            //                                                       height: 0.1,
            //                                                       color: AppColors
            //                                                           .kBlackTextColor
            //                                                           .withOpacity(
            //                                                               0.60)),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                   CustomSizedBox(
            //                                     height: 10,
            //                                   ),
            //                                   Row(
            //                                     children: [
            //                                       ContainerWithBorder(
            //                                         containerColor:
            //                                             Colors.transparent,
            //                                         borderColor:
            //                                             Color(0xff13E800),
            //                                         borderWidth: 1,
            //                                         borderRadius: 16 *
            //                                             SizeConfig
            //                                                 .widthMultiplier!,
            //                                         child: Row(
            //                                           children: [
            //                                             Padding(
            //                                               padding:
            //                                                   EdgeInsets.only(
            //                                                 left: 12 *
            //                                                     SizeConfig
            //                                                         .widthMultiplier!,
            //                                               ),
            //                                               child: Row(
            //                                                 children: [
            //                                                   ImageLoader.svgPictureAssetImage(
            //                                                       width: 20 *
            //                                                           SizeConfig
            //                                                               .widthMultiplier!,
            //                                                       height: 20 *
            //                                                           SizeConfig
            //                                                               .heightMultiplier!,
            //                                                       imagePath:
            //                                                           ImagePath
            //                                                               .blueLocIcon),
            //                                                   CustomSizedBox(
            //                                                     width: 10,
            //                                                   ),
            //                                                   Text(
            //                                                     state
            //                                                             .tripSingleModel
            //                                                             .data
            //                                                             ?.activities?[
            //                                                                 activityIndex]
            //                                                                 [
            //                                                                 index]
            //                                                             .rideType
            //                                                             ?.capitalizeFirst ??
            //                                                         "",
            //                                                     style: AppTextStyle
            //                                                         .text14black0000W500
            //                                                         ?.copyWith(
            //                                                             color: AppColors
            //                                                                 .kBlack272727),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ),
            //                                       CustomSizedBox(
            //                                         width: 12,
            //                                       ),
            //                                       ContainerWithBorder(
            //                                         containerColor:
            //                                             Colors.transparent,
            //                                         borderColor:
            //                                             Color(0xff13E800),
            //                                         borderWidth: 1,
            //                                         borderRadius: 16 *
            //                                             SizeConfig
            //                                                 .widthMultiplier!,
            //                                         child: Row(
            //                                           children: [
            //                                             Text(
            //                                               state
            //                                                       .tripSingleModel
            //                                                       .data
            //                                                       ?.activities?[
            //                                                           activityIndex]
            //                                                           [index]
            //                                                       .distance ??
            //                                                   "",
            //                                               style: TextStyle(
            //                                                 color: AppColors
            //                                                     .kBlackTextColor,
            //                                                 fontWeight:
            //                                                     FontWeight.w600,
            //                                                 fontSize: 14 *
            //                                                     SizeConfig
            //                                                         .textMultiplier!,
            //                                               ),
            //                                             ),
            //                                             SizedBox(
            //                                               width: 2 *
            //                                                   SizeConfig
            //                                                       .widthMultiplier!,
            //                                             ),
            //                                             Icon(
            //                                               Icons.circle,
            //                                               size: 7 *
            //                                                   SizeConfig
            //                                                       .imageSizeMultiplier!,
            //                                             ),
            //                                             SizedBox(
            //                                               width: 2 *
            //                                                   SizeConfig
            //                                                       .widthMultiplier!,
            //                                             ),
            //                                             Text(
            //                                               state
            //                                                       .tripSingleModel
            //                                                       .data
            //                                                       ?.activities?[
            //                                                           activityIndex]
            //                                                           [index]
            //                                                       .time ??
            //                                                   "",
            //                                               style: TextStyle(
            //                                                 color: AppColors
            //                                                     .kBlackTextColor,
            //                                                 fontWeight:
            //                                                     FontWeight.w600,
            //                                                 fontSize: 14 *
            //                                                     SizeConfig
            //                                                         .textMultiplier!,
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   CustomSizedBox(
            //                                     height: 10,
            //                                   ),
            //                                   UsableSingleAddressRow(
            //                                     pickupAddress: state
            //                                             .tripSingleModel
            //                                             .data
            //                                             ?.activities?[
            //                                                 activityIndex]
            //                                                 [index]
            //                                             .pickupAddress ??
            //                                         "",
            //                                     dropUpAddress: state
            //                                             .tripSingleModel
            //                                             .data
            //                                             ?.activities?[
            //                                                 activityIndex]
            //                                                 [index]
            //                                             .dropoffAddress ??
            //                                         "",
            //                                   ),
            //                                   CustomSizedBox(
            //                                     height: 17 *
            //                                         SizeConfig
            //                                             .heightMultiplier!,
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               )),
            //             ),
            //           ],
            //         );
            //       }
            //
            //       if (state is TripEmptyState) {
            //         return Center(
            //           child: TripCancelEmpty(
            //             message: state.emptyMessage,
            //           ),
            //         );
            //       }
            //       if (state is TripLoadingState) {
            //         return Center(
            //           child: Lottie.asset(ImagePath.loadingAnimation,
            //               height: 50 * SizeConfig.heightMultiplier!,
            //               width: 300 * SizeConfig.widthMultiplier!),
            //         );
            //       }
            //
            //       return Center(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text("no_data_available".tr),
            //         ),
            //       );
            //     },
            //   ),
            // if (controllerTab == 2)
            //   Padding(
            //     padding: EdgeInsets.only(
            //         left: 6.0 * SizeConfig.widthMultiplier!,
            //         right: 6 * SizeConfig.widthMultiplier!),
            //     child: SizedBox(
            //       child: DecoratedBox(
            //           decoration: BoxDecoration(
            //             color: AppColors
            //                 .kWhite, //background color of dropdown button
            //             border: Border.all(
            //                 color: AppColors.kblueDF0000,
            //                 width: 2 *
            //                     SizeConfig
            //                         .widthMultiplier!), //border of dropdown button
            //             borderRadius: BorderRadius.circular(
            //                 12 * SizeConfig.widthMultiplier!),
            //           ),
            //           child: DropdownButton(
            //             isExpanded: true,
            //             value: selectName,
            //             hint: Padding(
            //               padding: EdgeInsets.only(left: 20.0),
            //               child: Row(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     EarningActivity.today.getEarningActivityString,
            //                     style: TextStyle(
            //                         color: AppColors.kblueDF0000,
            //                         fontWeight: FontWeight.w700,
            //                         fontSize: 16 * SizeConfig.textMultiplier!),
            //                   ),
            //                   Icon(
            //                     Icons.arrow_forward_ios_rounded,
            //                     color: AppColors.kblueDF0000,
            //                     size: 20 * SizeConfig.imageSizeMultiplier!,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             items: [
            //               DropdownMenuItem(
            //                 value:
            //                     EarningActivity.today.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .today.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .yesterday.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .yesterday.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .lastweek.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .lastweek.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .thisWeek.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .thisWeek.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .lastmonth.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .lastmonth.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               DropdownMenuItem(
            //                 value: EarningActivity
            //                     .thisMonth.getEarningActivityString,
            //                 child: Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 20.0),
            //                       child: Text(
            //                         EarningActivity
            //                             .thisMonth.getEarningActivityString,
            //                         style: TextStyle(
            //                             color: AppColors.kblueDF0000,
            //                             fontWeight: FontWeight.w700,
            //                             fontSize:
            //                                 16 * SizeConfig.textMultiplier!),
            //                       ),
            //                     ),
            //                     Icon(
            //                       Icons.arrow_forward_ios_rounded,
            //                       color: AppColors.kblueDF0000,
            //                       size: 20 * SizeConfig.imageSizeMultiplier!,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //             onChanged: (value) {
            //               //get value when changed
            //               setState(() {
            //                 selectName = value;
            //               });
            //               if (selectName ==
            //                       EarningActivity
            //                           .today.getEarningActivityString ||
            //                   selectName ==
            //                       EarningActivity
            //                           .yesterday.getEarningActivityString) {
            //                 _tripCubit.getSingleTripData(
            //                     dateFilter: selectName, tripStatus: 'assigned');
            //               } else {
            //                 _tripCubit.getFilterData(
            //                     dateFilter: selectName, tripStatus: 'assigned');
            //               }
            //             },
            //
            //             iconEnabledColor: AppColors.kWhite, //Icon color
            //             style: TextStyle(
            //                 color: AppColors.kBlackTextColor.withOpacity(0.70),
            //                 fontWeight: FontWeight.w700,
            //                 fontSize: 16 * SizeConfig.textMultiplier!),
            //
            //             dropdownColor:
            //                 AppColors.kWhite, //dropdown background color
            //             underline: Container(), //remove underline
            //           )),
            //     ),
            //   ),
            // if (controllerTab == 2)
            //   BlocConsumer<TripCubit, TripState>(
            //     listener: (context, state) {},
            //     builder: (context, state) {
            //       if (state is GotTripSuccessState) {
            //         int? totalTrips =
            //             state.tripSingleModel.data?.metrics?.totalTrips;
            //
            //         totalTrip = totalTrips.toString();
            //
            //         return Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Row(
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.only(left: 8.0),
            //                   child: Text(
            //                     "assigned_trips".tr,
            //                     style: TextStyle(
            //                         color: AppColors.kblueDF0000,
            //                         fontWeight: FontWeight.w500,
            //                         fontSize: 16 * SizeConfig.textMultiplier!),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 7 * SizeConfig.heightMultiplier!,
            //                 ),
            //                 Text(
            //                   "${state.tripSingleModel.data?.metrics?.totalTrips}",
            //                   style: TextStyle(
            //                       color: AppColors.kblueDF0000,
            //                       fontWeight: FontWeight.w700,
            //                       fontSize: 16 * SizeConfig.textMultiplier!),
            //                 ),
            //               ],
            //             ),
            //             SizedBox(
            //               height: 20 * SizeConfig.heightMultiplier!,
            //             ),
            //             Divider(
            //               indent: 31 * SizeConfig.widthMultiplier!,
            //               endIndent: 29 * SizeConfig.widthMultiplier!,
            //               color: AppColors.kBlackTextColor.withOpacity(0.4),
            //               thickness: 0.4 * SizeConfig.widthMultiplier!,
            //             ),
            //             SizedBox(
            //               height: 14 * SizeConfig.heightMultiplier!,
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(
            //                 left: 31 * SizeConfig.widthMultiplier!,
            //                 right: 33 * SizeConfig.widthMultiplier!,
            //               ),
            //               child: Row(
            //                 children: [
            //                   Text(
            //                     "breakdown".tr,
            //                     style: TextStyle(
            //                         color: AppColors.kBlackTextColor,
            //                         fontWeight: FontWeight.w700,
            //                         fontSize: 20 * SizeConfig.textMultiplier!),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Column(
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.only(
            //                     left: 31 * SizeConfig.widthMultiplier!,
            //                     right: 33 * SizeConfig.widthMultiplier!,
            //                   ),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       SizedBox(
            //                         height: 20 * SizeConfig.heightMultiplier!,
            //                       ),
            //                       UsableRow(
            //                         title: "total_distance_trips".tr,
            //                         subTitle: state
            //                                 .tripSingleModel
            //                                 .data
            //                                 ?.metrics
            //                                 ?.breakdown
            //                                 ?.totalDistance ??
            //                             "",
            //                       ),
            //                       UsableRow(
            //                         title: "total_time_trips".tr,
            //                         subTitle: state.tripSingleModel.data
            //                                 ?.metrics?.breakdown?.totalTime
            //                                 .toString() ??
            //                             "",
            //                       ),
            //                       Divider(
            //                         color: AppColors.kBlackTextColor
            //                             .withOpacity(0.4),
            //                         thickness:
            //                             0.4 * SizeConfig.widthMultiplier!,
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             CustomSizedBox(
            //               height: 12 * SizeConfig.heightMultiplier!,
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(
            //                 left: 20 * SizeConfig.widthMultiplier!,
            //                 right: 20 * SizeConfig.widthMultiplier!,
            //               ),
            //               child: Wrap(
            //                   children: List.generate(
            //                 state.tripSingleModel.data?.activities?.length ?? 0,
            //                 (activityIndex) => Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     ...List.generate(
            //                       state.tripSingleModel.data
            //                               ?.activities?[activityIndex].length ??
            //                           0,
            //                       (index) => Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           ContainerWithBorder(
            //                             borderRadius:
            //                                 8 * SizeConfig.widthMultiplier!,
            //                             wantPadding: false,
            //                             borderColor: AppColors.kWhiteF2F3F3,
            //                             containerColor: AppColors.kWhiteF2F3F3,
            //                             child: Text(
            //                               state
            //                                       .tripSingleModel
            //                                       .data
            //                                       ?.activities?[activityIndex]
            //                                           [index]
            //                                       .date ??
            //                                   "",
            //                               style: TextStyle(
            //                                   color: AppColors.kBlackTextColor
            //                                       .withOpacity(0.80),
            //                                   fontWeight: FontWeight.w600,
            //                                   fontSize: 14 *
            //                                       SizeConfig.textMultiplier!),
            //                             ),
            //                           ),
            //                           CustomSizedBox(
            //                             height:
            //                                 5 * SizeConfig.heightMultiplier!,
            //                           ),
            //                           Padding(
            //                             padding: EdgeInsets.only(
            //                                 bottom: 12 *
            //                                     SizeConfig.heightMultiplier!),
            //                             child: ContainerWithBorder(
            //                               containerColor: Color(0xffFFFBE782)
            //                                   .withOpacity(.100),
            //                               borderRadius:
            //                                   7 * SizeConfig.widthMultiplier!,
            //                               child: Column(
            //                                 crossAxisAlignment:
            //                                     CrossAxisAlignment.start,
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.start,
            //                                 children: [
            //                                   Text(
            //                                     "ID : ${state.tripSingleModel.data?.activities?[activityIndex][index].rideId ?? ""}",
            //                                     style: AppTextStyle
            //                                         .text12black0000W400
            //                                         ?.copyWith(
            //                                       color: AppColors
            //                                           .kBlackTextColor
            //                                           .withOpacity(0.61),
            //                                     ),
            //                                   ),
            //                                   CustomSizedBox(
            //                                     height: 11 *
            //                                         SizeConfig
            //                                             .heightMultiplier!,
            //                                   ),
            //                                   ContainerWithBorder(
            //                                     borderColor: AppColors.kWhite,
            //                                     containerColor:
            //                                         Colors.transparent,
            //                                     borderRadius: 10 *
            //                                         SizeConfig.widthMultiplier!,
            //                                     child: Row(
            //                                       children: [
            //                                         Padding(
            //                                           padding: EdgeInsets.only(
            //                                             left: 12 *
            //                                                 SizeConfig
            //                                                     .widthMultiplier!,
            //                                           ),
            //                                           child: Row(
            //                                             children: [
            //                                               Text("Vehicle : ",
            //                                                   style: AppTextStyle
            //                                                       .text14kBlack090000W700
            //                                                       ?.copyWith(
            //                                                     color: AppColors
            //                                                         .kBlack090000
            //                                                         .withOpacity(
            //                                                             0.60),
            //                                                   )),
            //                                               Text(
            //                                                 state
            //                                                         .tripSingleModel
            //                                                         .data
            //                                                         ?.activities?[
            //                                                             activityIndex]
            //                                                             [index]
            //                                                         .vehicleType ??
            //                                                     "",
            //                                                 style: AppTextStyle
            //                                                     .text14kBlack090000W400
            //                                                     ?.copyWith(
            //                                                   color: AppColors
            //                                                       .kBlack090000
            //                                                       .withOpacity(
            //                                                           0.60),
            //                                                 ),
            //                                               ),
            //                                             ],
            //                                           ),
            //                                         ),
            //                                         Spacer(),
            //                                         Column(
            //                                           crossAxisAlignment:
            //                                               CrossAxisAlignment
            //                                                   .end,
            //                                           children: [
            //                                             Text(
            //                                               "${state.tripSingleModel.data?.activities?[activityIndex][index].fee ?? ""} ${state.tripSingleModel.data?.activities?[activityIndex][index].currency ?? ""}",
            //                                               style: AppTextStyle
            //                                                   .text16kBlack090000W700,
            //                                             ),
            //                                             Text(
            //                                               '(Includes All)',
            //                                               style: AppTextStyle
            //                                                   .text10black0000W400
            //                                                   ?.copyWith(
            //                                                       height: 0.1,
            //                                                       color: AppColors
            //                                                           .kBlackTextColor
            //                                                           .withOpacity(
            //                                                               0.60)),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                   CustomSizedBox(
            //                                     height: 10,
            //                                   ),
            //                                   Row(
            //                                     children: [
            //                                       ContainerWithBorder(
            //                                         containerColor:
            //                                             Colors.transparent,
            //                                         borderColor:
            //                                             Color(0xff13E800),
            //                                         borderWidth: 1,
            //                                         borderRadius: 16 *
            //                                             SizeConfig
            //                                                 .widthMultiplier!,
            //                                         child: Row(
            //                                           children: [
            //                                             Padding(
            //                                               padding:
            //                                                   EdgeInsets.only(
            //                                                 left: 12 *
            //                                                     SizeConfig
            //                                                         .widthMultiplier!,
            //                                               ),
            //                                               child: Row(
            //                                                 children: [
            //                                                   ImageLoader.svgPictureAssetImage(
            //                                                       width: 20 *
            //                                                           SizeConfig
            //                                                               .widthMultiplier!,
            //                                                       height: 20 *
            //                                                           SizeConfig
            //                                                               .heightMultiplier!,
            //                                                       imagePath:
            //                                                           ImagePath
            //                                                               .blueLocIcon),
            //                                                   CustomSizedBox(
            //                                                     width: 10,
            //                                                   ),
            //                                                   Text(
            //                                                     state
            //                                                             .tripSingleModel
            //                                                             .data
            //                                                             ?.activities?[
            //                                                                 activityIndex]
            //                                                                 [
            //                                                                 index]
            //                                                             .rideType
            //                                                         ?.capitalizeFirst ??
            //                                                         "",
            //                                                     style: AppTextStyle
            //                                                         .text14black0000W500
            //                                                         ?.copyWith(
            //                                                             color: AppColors
            //                                                                 .kBlack272727),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ),
            //                                       CustomSizedBox(
            //                                         width: 12,
            //                                       ),
            //                                       ContainerWithBorder(
            //                                         containerColor:
            //                                             Colors.transparent,
            //                                         borderColor:
            //                                             Color(0xff13E800),
            //                                         borderWidth: 1,
            //                                         borderRadius: 16 *
            //                                             SizeConfig
            //                                                 .widthMultiplier!,
            //                                         child: Row(
            //                                           children: [
            //                                             Text(
            //                                               state
            //                                                       .tripSingleModel
            //                                                       .data
            //                                                       ?.activities?[
            //                                                           activityIndex]
            //                                                           [index]
            //                                                       .distance ??
            //                                                   "",
            //                                               style: TextStyle(
            //                                                 color: AppColors
            //                                                     .kBlackTextColor,
            //                                                 fontWeight:
            //                                                     FontWeight.w600,
            //                                                 fontSize: 14 *
            //                                                     SizeConfig
            //                                                         .textMultiplier!,
            //                                               ),
            //                                             ),
            //                                             SizedBox(
            //                                               width: 2 *
            //                                                   SizeConfig
            //                                                       .widthMultiplier!,
            //                                             ),
            //                                             Icon(
            //                                               Icons.circle,
            //                                               size: 7 *
            //                                                   SizeConfig
            //                                                       .imageSizeMultiplier!,
            //                                             ),
            //                                             SizedBox(
            //                                               width: 2 *
            //                                                   SizeConfig
            //                                                       .widthMultiplier!,
            //                                             ),
            //                                             Text(
            //                                               state
            //                                                       .tripSingleModel
            //                                                       .data
            //                                                       ?.activities?[
            //                                                           activityIndex]
            //                                                           [index]
            //                                                       .time ??
            //                                                   "",
            //                                               style: TextStyle(
            //                                                 color: AppColors
            //                                                     .kBlackTextColor,
            //                                                 fontWeight:
            //                                                     FontWeight.w600,
            //                                                 fontSize: 14 *
            //                                                     SizeConfig
            //                                                         .textMultiplier!,
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   CustomSizedBox(
            //                                     height: 10,
            //                                   ),
            //                                   UsableSingleAddressRow(
            //                                     pickupAddress: state
            //                                             .tripSingleModel
            //                                             .data
            //                                             ?.activities?[
            //                                                 activityIndex]
            //                                                 [index]
            //                                             .pickupAddress ??
            //                                         "",
            //                                     dropUpAddress: state
            //                                             .tripSingleModel
            //                                             .data
            //                                             ?.activities?[
            //                                                 activityIndex]
            //                                                 [index]
            //                                             .dropoffAddress ??
            //                                         "",
            //                                   ),
            //                                   CustomSizedBox(
            //                                     height: 17 *
            //                                         SizeConfig
            //                                             .heightMultiplier!,
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               )),
            //             ),
            //           ],
            //         );
            //       }
            //
            //       if (state is TripEmptyState) {
            //         return Center(
            //           child: TripCancelEmpty(
            //             message: state.emptyMessage,
            //           ),
            //         );
            //       }
            //       if (state is TripLoadingState) {
            //         return Center(
            //           child: Lottie.asset(ImagePath.loadingAnimation,
            //               height: 50 * SizeConfig.heightMultiplier!,
            //               width: 300 * SizeConfig.widthMultiplier!),
            //         );
            //       }
            //
            //       return Center(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text("no_data_available".tr),
            //         ),
            //       );
            //     },
            //   ),
          ],
        ),
      ),
    );
  }

  rowContainerCard({
    String? title,
    required bool isSelected,
    required VoidCallback onTap,
    int? total,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16 * SizeConfig.widthMultiplier!,
            ),
            height: 32 * SizeConfig.widthMultiplier!,
            decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected
                      ? AppColors.kBlue1A73E8
                      : AppColors.kGreen198F52),
              borderRadius: BorderRadius.circular(
                10 * SizeConfig.widthMultiplier!,
              ),
              color: isSelected ? AppColors.kBlue1A73E8 : AppColors.kWhite,
            ),
            child: Center(
              child: Row(
                children: [
                  Text(
                    title ?? "",
                    style: AppTextStyle.text14Black0000W400?.copyWith(
                      color: isSelected
                          ? AppColors.kWhite
                          : AppColors.kGreen198F52,
                    ),
                  ),
                  CustomSizedBox(
                    width: 5,
                  ),
                  Text(
                    "(${total.toString()})",
                    style: AppTextStyle.text14Black0000W400?.copyWith(
                      color: isSelected
                          ? AppColors.kWhite
                          : AppColors.kGreen198F52,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
