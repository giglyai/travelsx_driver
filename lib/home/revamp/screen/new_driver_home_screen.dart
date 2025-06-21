import 'dart:io';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:travelx_driver/home/revamp/bloc/main_home_cubit.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
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
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  IndicatorController controller = IndicatorController(refreshEnabled: true);

  /// Boolean to check if the current device is an iPad.
  bool isDeviceIpad = false;

  /// Boolean flag for toggle functionality.
  var vlu = true;

  /// Instance of MainHomeCubit for managing the state of the home screen.
  late MainHomeCubit mainHomeCubit;

  /// Currently selected date filter for earnings or metrics.
  String selectedDate = "Today";

  /// Flag to track if a button/action has been clicked.
  bool isClick = false;

  /// Controller for managing the behavior of a DraggableScrollableSheet.
  DraggableScrollableController newOrderController =
      DraggableScrollableController();

  /// List of earning activity filters.
  List<String> earningActivityList = [
    EarningActivity.thisWeek.getEarningActivityString,

    EarningActivity.today.getEarningActivityString,
    EarningActivity.yesterday.getEarningActivityString,
    EarningActivity.lastweek.getEarningActivityString,
    EarningActivity.lastmonth.getEarningActivityString,
    EarningActivity.thisMonth.getEarningActivityString,
    "Date Range",
  ];

  String? customDateRangeLabel;

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
        // mainHomeCubit.getUserData(),
        mainHomeCubit.getDriverBusinessOverview(),
        mainHomeCubit.getUpcomingOnTripRideData(),
        // mainHomeCubit.getRideHomeData(),
        // mainHomeCubit.getRidesMatrix(),
      ]);
    });
  }

  // Future<void> downloadAndInstallApk(BuildContext context) async {
  //     // Ask permissions
  //     if (!(await Permission.storage.request().isGranted)) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Storage permission required')),
  //       );
  //       return;
  //     }

  //     final dir = await getExternalStorageDirectory();
  //     final apkPath = "${dir!.path}/driver-latest.apk";

  //     try {
  //       // Download APK
  //       Dio dio = Dio();
  //       await dio.download("apkUrl", apkPath, onReceiveProgress: (r, t) {
  //         print("Download: ${((r / t) * 100).toStringAsFixed(0)}%");
  //       });

  //       // Install APK
  //       await InstallPlugin.installApk(apkPath, 'com.gigly.driverapp');
  //     } catch (e) {
  //       print("Error downloading/installing: $e");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to install APK')),
  //       );
  //     }
  //   }

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
        mainHomeCubit.getAppVersion(),
        mainHomeCubit.updateDeviceToken(),
        mainHomeCubit.getUserData(),
        //  mainHomeCubit.getDriverBusinessOverview(),
        mainHomeCubit.getUpcomingOnTripRideData(),
        // mainHomeCubit.getRideHomeData(),
        // mainHomeCubit.getRidesMatrix(),
        mainHomeCubit.postUserCurrentLocation(),
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
    // super.build(context);
    return Scaffold(
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
          if (state.getProfileData.isLoading ||
              state.upComingRideApiStatus.isLoading) {
            return HomeWidgets.newDriverHomeShimmer();
          }

          /// Render main content when data is successfully fetched.
          if (state.upComingRideApiStatus.success ||
              state.upComingRideApiStatus.empty) {
            final getHomeData = state.upComingRideData?.data;

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
                          await mainHomeCubit.getUpcomingOnTripRideData(
                            dateFilter: selectedDate,
                          );
                        },
                        selectedDate: selectedDate,
                        earningActivityList: earningActivityList,
                        customDateRangeLabel:
                            selectedDate == "Date Range"
                                ? customDateRangeLabel ?? "Date Range"
                                : selectedDate,

                        onCustomTap: () async {
                          final picked = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Colors.black,
                                    onPrimary: Colors.white,
                                    surface: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                  dialogBackgroundColor: Colors.white,
                                  textTheme: const TextTheme(
                                    bodyMedium: TextStyle(color: Colors.black),
                                  ),
                                  datePickerTheme: DatePickerThemeData(
                                    todayBackgroundColor:
                                        MaterialStatePropertyAll(Colors.grey),
                                    rangePickerHeaderBackgroundColor:
                                        Colors.white,
                                    rangeSelectionBackgroundColor:
                                        AppColors.kBlue3D6,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (picked != null) {
                            final formatted =
                                "${DateFormat('dd MMM').format(picked.start)} - ${DateFormat('dd MMM yyyy').format(picked.end)}";
                            final rangeString =
                                "${DateFormat('yyyy-MM-dd').format(picked.start)},${DateFormat('yyyy-MM-dd').format(picked.end)}";

                            setState(() {
                              customDateRangeLabel = formatted;
                              selectedDate = "Date Range";
                            });

                            print(rangeString);

                            mainHomeCubit.getUpcomingOnTripRideData(
                              dateFilter: rangeString,
                            );
                          } else {
                            customDateRangeLabel = null;
                            setState(() {});
                          }
                        },
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
                      if ((state.getUserProfileData?.data?.vehicleNumber ?? '')
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
                            await mainHomeCubit.getUpcomingOnTripRideData(
                              dateFilter: selectedDate,
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
    );

    //   CustomMaterialIndicator(
    //   onRefresh: _refresh,
    //   backgroundColor: AppColors.kLightYelFFF3F0,
    //   controller: controller,
    //   indicatorBuilder: (context, controller) {
    //     return ImageLoader.assetLottie(imagePath: ImagePath.refreshLoader);
    //   },
    //   child:
    // );
  }
}
