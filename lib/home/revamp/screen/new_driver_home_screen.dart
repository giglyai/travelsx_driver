import 'dart:io';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shimmer/main.dart';
import 'package:travelx_driver/home/revamp/bloc/main_home_cubit.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';

import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../widgets/home_widget.dart';

class NewDriverHomeScreen extends StatefulWidget {
  const NewDriverHomeScreen({super.key});

  @override
  State<NewDriverHomeScreen> createState() => _NewDriverHomeScreenState();
}

class _NewDriverHomeScreenState extends State<NewDriverHomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _scrollController = ScrollController();
  IndicatorController controller = IndicatorController(refreshEnabled: true);

  /// Boolean to check if the current device is an iPad.
  bool isDeviceIpad = false;

  /// Boolean flag for toggle functionality.
  var vlu = true;

  /// Instance of MainHomeCubit for managing the state of the home screen.
  late MainHomeCubit mainHomeCubit;

  /// Currently selected date filter for earnings or metrics.
  String selectedDate = "This Week";

  /// Flag to track if a button/action has been clicked.
  bool isClick = false;

  /// Controller for managing the behavior of a DraggableScrollableSheet.
  DraggableScrollableController newOrderController =
      DraggableScrollableController();

  /// List of earning activity filters.
  List<String> earningActivityList = [
    EarningActivity.today.getEarningActivityString,
    EarningActivity.yesterday.getEarningActivityString,
    EarningActivity.lastweek.getEarningActivityString,
    EarningActivity.thisWeek.getEarningActivityString,
    EarningActivity.lastmonth.getEarningActivityString,
    EarningActivity.thisMonth.getEarningActivityString,
  ];

  void checkAndRequestLocationPermission() async {
    // Check location permission status
    final permissionStatus = await Geolocator.checkPermission();

    if (permissionStatus == LocationPermission.denied ||
        permissionStatus == LocationPermission.deniedForever) {
      // Request location permission
      final newPermissionStatus = await Geolocator.requestPermission();

      if (newPermissionStatus == LocationPermission.denied ||
          newPermissionStatus == LocationPermission.deniedForever) {
        // Show bottom sheet if permission is still denied
        WidgetsBinding.instance.addPostFrameCallback((_) {
          mainHomeCubit.showLocationBottomSheet();
        });
        return;
      }
    }

    // If permission is granted, fetch the location
    if (UserRepository.getLat == null || UserRepository.getLong == null) {
      final position = await Geolocator.getCurrentPosition();
      UserRepository.instance.setUserCurrentLat(position.latitude);
      UserRepository.instance.setUserCurrentLong(position.longitude);
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate data fetch
    //setState(() {}); // Rebuild UI after refreshing

    // Fetch data concurrently to reduce waiting time
    Future.microtask(() async {
      await Future.wait([
        mainHomeCubit.getUserData(),
        mainHomeCubit.getDriverBusinessOverview(),
        mainHomeCubit.getUpcomingOnTripRideData(),
        mainHomeCubit.getRideHomeData(),
        mainHomeCubit.getRidesMatrix(),
      ]);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// Initialize MainHomeCubit and other dependencies.
    mainHomeCubit = context.read<MainHomeCubit>();
    // Initialize critical processes first
    // CountryListBottomSheet().init();
    checkAndRequestLocationPermission();

    // Fetch data concurrently to reduce waiting time
    Future.microtask(() async {
      await Future.wait([
        mainHomeCubit.updateDeviceToken(),
        mainHomeCubit.getUserData(),
        mainHomeCubit.getDriverBusinessOverview(),
        mainHomeCubit.getUpcomingOnTripRideData(),
        mainHomeCubit.getRideHomeData(),
        mainHomeCubit.getRidesMatrix(),
      ]);
    });

    // Listen for scroll events
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        _refresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomMaterialIndicator(
      onRefresh: _refresh,
      backgroundColor: AppColors.kLightYelFFF3F0,
      controller: controller,
      indicatorBuilder: (context, controller) {
        return ImageLoader.assetLottie(imagePath: ImagePath.refreshLoader);
      },
      child: Scaffold(
        /// Extend body under floating action button.
        extendBody: true,

        /// Prevent resizing when the keyboard appears.
        resizeToAvoidBottomInset: false,

        /// Set the location of the floating action button.
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        /// Floating Action Button (FAB) to handle bottom sheet logic dynamically.
        floatingActionButton: BlocBuilder<MainHomeCubit, MainHomeState>(
          builder: (context, state) {
            return HomeWidgets.floatingActionButton(
              context: context,
              mainHomeCubit: context.read<MainHomeCubit>(),
              newOrderController: newOrderController,
              state: state,
            );
          },
        ),

        /// Main content of the screen.
        body: BlocBuilder<MainHomeCubit, MainHomeState>(
          builder: (context, state) {
            /// Show loading shimmer while data is being fetched.
            if (state.mainHomeApiStatus.isLoading ||
                state.getProfileData.isLoading ||
                state.ridesMatrixApiStatus.isLoading) {
              return HomeWidgets.newDriverHomeShimmer();
            }

            /// Render main content when data is successfully fetched.
            if (state.ridesMatrixApiStatus.success) {
              final getHomeData = state.dlvyBusinessOverviewData?.data;

              return Stack(
                children: [
                  /// Scrollable content containing the main widgets.
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom:
                          Platform.isIOS
                              ? 150 * SizeConfig.heightMultiplier!
                              : 220 * SizeConfig.heightMultiplier!,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Top spacing.
                        CustomSizedBox(height: 40),

                        /// Top bar with menu icon and online/offline toggle.
                        Row(
                          children: [
                            HomeWidgets.topBarMenuIcon(context: context),
                            const Spacer(),
                            HomeWidgets.onlineOfflineSwitch(
                              onToggle: (value) {
                                setState(() {
                                  vlu = value;
                                });
                              },
                              value: vlu,
                            ),
                          ],
                        ),

                        /// Spacing below the top bar.
                        CustomSizedBox(height: 20),

                        /// Business overview section with date filter.
                        HomeWidgets.businessOverview(
                          context: context,
                          firstName: state.getUserProfileData?.data?.firstName,
                          getHomeData: getHomeData,
                          onChanged: (String? value) async {
                            setState(() {
                              selectedDate = value!;
                            });

                            /// Fetch metrics based on the selected filter.
                            await mainHomeCubit.getDriverBusinessOverview(
                              date: selectedDate,
                            );
                          },
                          selectedDate: selectedDate,
                          earningActivityList: earningActivityList,
                        ),

                        /// Spacing below the business overview.
                        CustomSizedBox(height: 16),

                        /// Order details section.
                        HomeWidgets.orderDetails(
                          context: context,
                          getHomeData: getHomeData,
                        ),

                        /// Extra spacing for bottom padding.
                        CustomSizedBox(height: 10),

                        /// Banner indicating a missing email address.
                        if (state
                                .getUserProfileData
                                ?.data
                                ?.missingDocs
                                ?.isEmpty ==
                            false)
                          HomeWidgets.missingDocumentsBanner(
                            profileData: state.getUserProfileData,
                            onTap: () {
                              AnywhereDoor.pushNamed(
                                context,
                                routeName: RouteName.driverAccountScreen,
                              );
                            },
                          ),

                        /// Extra spacing for bottom padding.
                        CustomSizedBox(height: 10),

                        /// Banner indicating a missing email address.
                        if ((state.getUserProfileData?.data?.vehicleNumber ??
                                '')
                            .isEmpty)
                          HomeWidgets.missingVehicleBanner(
                            profileData: state.getUserProfileData,
                            onTap: () {
                              AnywhereDoor.pushNamed(
                                context,
                                routeName: RouteName.addVehicleScreen,
                              );
                            },
                          ),
                      ],
                    ),
                  ),

                  /// Fixed bottom UI when there are no new orders.
                  if (state.upComingRideData?.data?.upcomingRide?.isEmpty ==
                          true ||
                      state.upComingRideData?.data?.newRide?.isEmpty == true)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: kBottomNavigationBarHeight,
                      child: Column(
                        children: [
                          /// Banner indicating no new orders.
                          HomeWidgets.noNewOrder(
                            onTap: () async {
                              await mainHomeCubit.getDriverBusinessOverview(
                                date: selectedDate,
                              );
                            },
                          ),

                          /// Spacing between banners.
                          CustomSizedBox(height: 5),

                          /// Banner indicating a missing email address.
                          if (state
                                  .getUserProfileData
                                  ?.data
                                  ?.missingDocs
                                  ?.isEmpty ==
                              true)
                            HomeWidgets.missingDocumentsBanner(
                              profileData: state.getUserProfileData,
                              onTap: () {
                                AnywhereDoor.pushNamed(
                                  context,
                                  routeName: RouteName.driverAccountScreen,
                                );
                              },
                            ),

                          CustomSizedBox(height: 5),

                          if (state
                                      .getUserProfileData
                                      ?.data
                                      ?.vehicleType
                                      ?.isEmpty ==
                                  true &&
                              state.isOnTripBottomSheetIsOpen == true)
                            HomeWidgets.missingVehicleBanner(
                              profileData: state.getUserProfileData,
                              onTap: () {
                                AnywhereDoor.pushNamed(
                                  context,
                                  routeName: RouteName.addVehicleScreen,
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                ],
              );
            }

            /// Handle failure or no data case.
            return HomeWidgets.newDriverHomeShimmer();
          },
        ),
      ),
    );
  }
}
