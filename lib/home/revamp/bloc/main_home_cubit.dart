import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travelx_driver/global_variables.dart';
import 'package:travelx_driver/home/hire_driver_bloc/entity/upcoming_ontrip_ride_res.dart'
    as upcoming;
import 'package:travelx_driver/home/hire_driver_bloc/screen/hire_driver_direction_screen.dart';
import 'package:travelx_driver/home/models/app_version_res.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/home/models/post_userdata_params.dart'
    as driverData;
import 'package:travelx_driver/home/revamp/data/main_home_data.dart';
import 'package:travelx_driver/home/revamp/entity/dlvy_biz_overview_entity.dart';
import 'package:travelx_driver/home/revamp/entity/ride_home_entity.dart';
import 'package:travelx_driver/home/revamp/entity/ride_matrix.dart';
import 'package:travelx_driver/home/revamp/widgets/ride_home_shimmer.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/api_client/api_exception.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/local_storage/log_in_status.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/update_bottom_sheet.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/container_with_border/container_with_border.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/outline_button/outline_button.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/shared/widgets/usable_address_row/single_address_row.dart';
import 'package:travelx_driver/user/account/enitity/profile_model.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';

import '../../hire_driver_bloc/entity/accepted_hire_ride.dart';

class MainHomeState extends Equatable {
  final ApiStatus mainHomeApiStatus;
  final ApiStatus getProfileData;
  final ApiStatus upComingRideApiStatus;
  final ApiStatus driverMutateRideStatus;
  final ApiStatus cancelDriverMutateRideStatus;
  final ApiStatus ridesMatrixApiStatus;
  final RideHomeModel? rideHomeModel;
  final AppVersionRes? appVersionRes;
  GetUserProfileData? getUserProfileData;
  upcoming.UpcomingOntripRideRes? upComingRideData;
  final List<upcoming.UpcomingRide>? acceptedHireRides;
  final List<upcoming.NewRide>? acceptedNewRides;
  bool? isOnTripBottomSheetIsOpen;
  final RideStatus rideStatus;
  bool? joiningFeePaydone;
  GetAllTripsData? getAllTripsData;
  DlvyBusinessOverviewData? dlvyBusinessOverviewData;
  DriverStatus? driverStatus;
  int? driverStatusValue;
  MainHomeState({
    required this.mainHomeApiStatus,
    required this.getProfileData,
    this.rideHomeModel,
    this.appVersionRes,
    this.isOnTripBottomSheetIsOpen,
    this.getUserProfileData,
    required this.upComingRideApiStatus,
    this.upComingRideData,
    required this.driverMutateRideStatus,
    required this.cancelDriverMutateRideStatus,
    required this.ridesMatrixApiStatus,
    required this.rideStatus,
    this.acceptedHireRides,
    this.acceptedNewRides,
    this.joiningFeePaydone,
    this.getAllTripsData,
    this.dlvyBusinessOverviewData,
    this.driverStatus,
    this.driverStatusValue,
  });

  static MainHomeState init() => MainHomeState(
    mainHomeApiStatus: ApiStatus.init,
    getProfileData: ApiStatus.init,
    upComingRideApiStatus: ApiStatus.init,
    ridesMatrixApiStatus: ApiStatus.init,
    rideHomeModel: RideHomeModel(),
    appVersionRes: AppVersionRes(),
    getUserProfileData: GetUserProfileData(),
    upComingRideData: upcoming.UpcomingOntripRideRes(),
    driverMutateRideStatus: ApiStatus.init,
    cancelDriverMutateRideStatus: ApiStatus.init,
    rideStatus: RideStatus.none,
    acceptedHireRides: const [],
    acceptedNewRides: const [],
    isOnTripBottomSheetIsOpen: true,
    joiningFeePaydone: false,
    getAllTripsData: GetAllTripsData(),
    dlvyBusinessOverviewData: DlvyBusinessOverviewData(),
    driverStatus: DriverStatus.online,
    driverStatusValue: 1,
  );

  MainHomeState copyWith({
    ApiStatus? mainHomeApiStatus,
    ApiStatus? driverMutateRideStatus,
    ApiStatus? cancelDriverMutateRideStatus,
    ApiStatus? ridesMatrixApiStatus,
    ApiStatus? getProfileData,
    RideHomeModel? rideHomeModel,
    AppVersionRes? appVersionRes,
    bool? isOnTripBottomSheetIsOpen,
    GetUserProfileData? getUserProfileData,
    ApiStatus? upComingRideApiStatus,
    upcoming.UpcomingOntripRideRes? upComingRideData,
    RideStatus? rideStatus,
    List<upcoming.UpcomingRide>? acceptedHireRides,
    List<upcoming.NewRide>? acceptedNewRides,
    bool? joiningFeePaydone,
    GetAllTripsData? getAllTripsData,
    DlvyBusinessOverviewData? dlvyBusinessOverviewData,
    DriverStatus? driverStatus,
    int? driverStatusValue,
  }) {
    return MainHomeState(
      mainHomeApiStatus: mainHomeApiStatus ?? this.mainHomeApiStatus,
      ridesMatrixApiStatus: ridesMatrixApiStatus ?? this.ridesMatrixApiStatus,
      getProfileData: getProfileData ?? this.getProfileData,
      rideHomeModel: rideHomeModel ?? this.rideHomeModel,
      appVersionRes: appVersionRes ?? this.appVersionRes,
      isOnTripBottomSheetIsOpen:
          isOnTripBottomSheetIsOpen ?? this.isOnTripBottomSheetIsOpen,
      getUserProfileData: getUserProfileData ?? this.getUserProfileData,
      upComingRideApiStatus:
          upComingRideApiStatus ?? this.upComingRideApiStatus,
      upComingRideData: upComingRideData ?? this.upComingRideData,
      driverMutateRideStatus:
          driverMutateRideStatus ?? this.driverMutateRideStatus,
      cancelDriverMutateRideStatus:
          cancelDriverMutateRideStatus ?? this.cancelDriverMutateRideStatus,
      rideStatus: rideStatus ?? this.rideStatus,
      acceptedHireRides: acceptedHireRides ?? this.acceptedHireRides,
      acceptedNewRides: acceptedNewRides ?? this.acceptedNewRides,
      joiningFeePaydone: joiningFeePaydone ?? this.joiningFeePaydone,
      getAllTripsData: getAllTripsData ?? this.getAllTripsData,
      dlvyBusinessOverviewData:
          dlvyBusinessOverviewData ?? this.dlvyBusinessOverviewData,
      driverStatus: driverStatus ?? this.driverStatus,
      driverStatusValue: driverStatusValue ?? this.driverStatusValue,
    );
  }

  @override
  List<Object?> get props => [
    ridesMatrixApiStatus,
    getProfileData,
    mainHomeApiStatus,
    rideHomeModel,
    appVersionRes,
    isOnTripBottomSheetIsOpen,
    getUserProfileData,
    upComingRideApiStatus,
    upComingRideData,
    driverMutateRideStatus,
    cancelDriverMutateRideStatus,
    rideStatus,
    acceptedHireRides,
    acceptedNewRides,
    joiningFeePaydone,
    getAllTripsData,
    dlvyBusinessOverviewData,
    driverStatus,
    driverStatusValue,
  ];
}

class MainHomeCubit extends Cubit<MainHomeState> {
  MainHomeCubit() : super(MainHomeState.init());

  Future<void> postUserCurrentLocation({
    int? userStatus,
    String? source,
  }) async {
    LogInStatus logInStatus = LogInStatus();
    String? getLpId = await logInStatus.getDriverLpId();
    String? getUserId = await logInStatus.getUserID();
    String? firstName = await logInStatus.getUserProfileFirstName();
    String? countryCode = await logInStatus.getCountryCode();
    String? phoneNumber = await logInStatus.getUserPhoneNumber();
    List<AgencyList>? agencyList = await logInStatus.getAgencyList();
    String? vehicleType = await logInStatus.getUserVehicleModel();
    String? deviceId = await logInStatus.getDeviceTokenDetails();
    String? driverStatus = await logInStatus.driverStatus();
    String? accountStatus = await logInStatus.getUserProfileAccountData();

    if (driverStatus == "ONTRIP") {
      state.driverStatusValue = 2;
    } else if (userStatus == 0) {
      state.driverStatusValue = 0;
    } else {
      state.driverStatusValue = 1;
    }

    try {
      // Get package info
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      // Get current location
      final currentLocation = await Utils.getCurrentLocation();

      // Fetch device info
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      String osName = Platform.operatingSystem;
      driverData.Device device;

      // Determine the user's current status
      // if (state.driverStatus == DriverStatus.onTrip) {
      //   state.driverStatusValue = 2; // On trip
      // } else if (state.driverStatus == DriverStatus.online) {
      //   state.driverStatusValue = 1; // Online
      // } else if (state.driverStatus == DriverStatus.offline) {
      //   state.driverStatusValue = 0; // Offline
      // }

      // Create user and position objects
      DriverPosition currentPosition = DriverPosition(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      );

      driverData.User user = driverData.User(
        userId: int.parse(UserRepository.getUserID ?? getUserId ?? ""),
        name: firstName,
        countryCode: countryCode,
        phoneNumber: phoneNumber,
        userStatus: state.driverStatusValue,
        position: currentPosition,
        accountStatus: accountStatus,
      );

      // Handle device-specific details
      if (deviceInfo is AndroidDeviceInfo) {
        device = driverData.Device(
          name: deviceInfo.model,
          os: 'Android',
          osVersion: deviceInfo.version.release,
        );
      } else if (deviceInfo is IosDeviceInfo) {
        device = driverData.Device(
          name: deviceInfo.name ?? "",
          os: 'iOS',
          osVersion: deviceInfo.systemVersion ?? "",
        );
      } else {
        device = driverData.Device(
          name: 'Unknown',
          os: 'Unknown',
          osVersion: "0",
        );
      }

      // Create app object
      driverData.App app = driverData.App(
        name: packageInfo.appName,
        version: packageInfo.version,
      );

      // Create parameters for API call
      driverData.PostUserDataParams params = driverData.PostUserDataParams(
        lpId: int.tryParse(UserRepository.getLpID ?? getLpId ?? ""),
        user: user,
        source: source ?? "",
        deviceToken: deviceId,
        device: device,
        app: app,
        vehicleType: vehicleType,
        timezone: DateTime.now().timeZoneName,
        createIsoTime: DateTime.now().toIso8601String(),
      );

      // API call
      final response = await MainHomeData.postUserData(params);

      // Log success (optional)
      print("User data updated successfully: ${response}");
    } catch (e) {
      // Log the error
      print("Error updating user location: $e");
    }
  }

  showLocationBottomSheet() async {
    bool isLoading = false; // Track the loading state

    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.black.withOpacity(0.7),
      context: navigatorKey.currentState!.context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (
            BuildContext context,
            void Function(void Function()) setState1,
          ) {
            return PopScope(
              canPop: false,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        20 * SizeConfig.widthMultiplier!,
                      ),
                      topRight: Radius.circular(
                        20 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                  ),
                  height: 400 * SizeConfig.heightMultiplier!,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                        ImageLoader.assetImage(
                          imagePath: ImagePath.mapPinIcon,
                          height: 120 * SizeConfig.heightMultiplier!,
                          width: 120 * SizeConfig.widthMultiplier!,
                          filterQuality: FilterQuality.low,
                        ),
                        SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                        Text(
                          "Location permission is off",
                          style: TextStyle(
                            fontSize: 20 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10 * SizeConfig.heightMultiplier!),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20 * SizeConfig.widthMultiplier!,
                          ),
                          child: Text(
                            "Please enable location permission for better delivery experience",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16 * SizeConfig.textMultiplier!,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        SizedBox(height: 30 * SizeConfig.heightMultiplier!),
                        BlueButton(
                          buttonColor: Colors.pink,
                          title: "Continue",
                          isLoading: isLoading,
                          onTap: () async {
                            setState1(() {
                              isLoading = true; // Show loader when tapped
                            });
                            await Utils.handleBottomSheetPermissions(
                              context: context,
                              fromLogin: false,
                            );

                            setState1(() {
                              isLoading = false; // Hide loader when done
                            });
                          },
                        ),
                        SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  DraggableScrollableSheet showAccountNotVerifiedStatusBottomSheet() {
    DraggableScrollableController accountPendingController =
        DraggableScrollableController();
    return DraggableScrollableSheet(
      controller: accountPendingController,
      snap: false,
      minChildSize: 0.3,
      initialChildSize: 0.3,
      maxChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlackTextColor.withOpacity(0.20),
                blurRadius: 4, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
              ),
            ],
            color: AppColors.kWhite,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10 * SizeConfig.widthMultiplier!),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSizedBox(height: 20),
                Center(
                  child: Container(
                    width: 63 * SizeConfig.widthMultiplier!,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50 * SizeConfig.widthMultiplier!,
                      ),
                      color: AppColors.kBlackTextColor.withOpacity(0.21),
                      border: Border.all(
                        color: AppColors.kBlackTextColor.withOpacity(0.21),
                        width: 2 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                  ),
                ),
                CustomSizedBox(height: 10),
                Center(
                  child: Text(
                    "Your account is under verification",
                    style: AppTextStyle.text18black0000W600,
                  ),
                ),
                CustomSizedBox(height: 2),
                Center(
                  child: ImageLoader.assetImage(
                    imagePath: ImagePath.docLoader,
                    height: 80 * SizeConfig.heightMultiplier!,
                    width: 80 * SizeConfig.widthMultiplier!,
                  ),
                ),
                CustomSizedBox(height: 14),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "This might take upto 24 hours",
                        style: AppTextStyle.text12kRedF24141W300,
                      ),
                    ],
                  ),
                ),
                CustomSizedBox(height: 14),
                GestureDetector(
                  onTap: () {
                    AnywhereDoor.pushNamed(
                      context,
                      routeName: RouteName.helpScreen,
                    );
                  },
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Chat with help team",
                          style: AppTextStyle.text12black0000W600,
                        ),
                        Container(
                          width: 110 * SizeConfig.widthMultiplier!,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50 * SizeConfig.widthMultiplier!,
                            ),
                            color: AppColors.kRedF24141,
                            border: Border.all(
                              color: AppColors.kBlackTextColor,
                              width: 0.4 * SizeConfig.widthMultiplier!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onDragabbleBottmSheetChanges(bool? value) {
    emit(state.copyWith(isOnTripBottomSheetIsOpen: value));
  }

  Future<void> updateDeviceToken() async {
    try {
      final deviceToken = UserRepository.getDeviceToken ?? "";
      final response = await MainHomeData.updateDeviceToken(
        lpId: int.parse(UserRepository.getLpID!),
        userId: int.parse(UserRepository.getUserID!),
        user: 'travelsx-driver',
        deviceToken: deviceToken ?? "",
      );
    } on ApiException catch (e) {}
  }

  Future<bool> getAppVersion() async {
    try {
      final response = await MainHomeData.getAppVersion();
      if (response['status'] == "success") {
        final appVersion = AppVersionRes.fromJson(response);
        if (appVersion.data?.installMandatory == "yes") {
          isUpdateCrucial = false;
        } else {
          isUpdateCrucial = true;
        }
        if (appVersion.data?.appVersion.isNotEmpty == true) {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          int appCurrentVersion = int.parse(
            packageInfo.version.replaceAll(".", ""),
          );
          int appUpdateVersion = int.parse(
            appVersion.data!.appVersion.replaceAll(".", ""),
          );
          if (appCurrentVersion < appUpdateVersion) {
            ///todo Remove this in next release line logoutVersion =  true;
            logoutVersion = true;
            print('app needs update');
            updateAppVersion = appVersion.data?.appVersion;
            emit(state.copyWith(appVersionRes: appVersion));
            UpdateBottomSheet().updateBottomSheet(
              context: navigatorKey.currentState!.context,
            );

            return true;
          } else {
            print('app needs update');
            return false;
          }
        }
      }
      return false;
    } catch (e) {
      throw e;
    }
  }

  Future<void> getDriverBusinessOverview({String? date}) async {
    try {
      emit(state.copyWith(ridesMatrixApiStatus: ApiStatus.loading));

      final response = await MainHomeData.getDriverBusinessOverview(
        lpId: UserRepository.getLpID ?? '',
        userId: UserRepository.getUserID ?? '',
        date: date ?? "This Week",
      );

      if (response['status'] == "success") {
        emit(
          state.copyWith(
            dlvyBusinessOverviewData: DlvyBusinessOverviewData.fromJson(
              response,
            ),
            ridesMatrixApiStatus: ApiStatus.success,
          ),
        );
      }
    } on ApiException {
      emit(state.copyWith(ridesMatrixApiStatus: ApiStatus.failure));
    }
  }

  Future<void> getRideHomeData() async {
    final currentPosition = await Utils.getCurrentLocation();
    try {
      emit(state.copyWith(mainHomeApiStatus: ApiStatus.loading));
      final response = await MainHomeData.getRideHomeData(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        currentPosition: currentPosition,
      );
      final rideHomeModel = RideHomeModel.fromJson(response);
      if (rideHomeModel.status == "success") {
        if (rideHomeModel.data != null) {
          emit(
            state.copyWith(
              mainHomeApiStatus: ApiStatus.success,
              rideHomeModel: rideHomeModel,
            ),
          );
        }
      }
    } on ApiException catch (e) {
      emit(state.copyWith(mainHomeApiStatus: ApiStatus.failure));
    }
  }

  Future<void> getUpcomingOnTripRideData({String? dateFilter}) async {
    try {
      emit(state.copyWith(upComingRideApiStatus: ApiStatus.loading));
      final response = await MainHomeData.getUpcomingOnTripRideData(
        lpId: UserRepository.getLpID ?? '',
        userId: UserRepository.getUserID ?? '',
        date: dateFilter ?? "Today",
      );
      final upcomingOntripRideRes = upcoming.UpcomingOntripRideRes.fromJson(
        response,
      );

      if (upcomingOntripRideRes.data?.ontripRide?.isNotEmpty == true) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(
          navigatorKey.currentState!.context,
          arguments: HireDriverRideDirectionsScreenParams(
            ride: upcomingOntripRideRes.data!.ontripRide![0],
          ),
          RouteName.hireDriverRideDirectionsScreen,
        );
      } else if (upcomingOntripRideRes.data?.upcomingRide?.isNotEmpty == true ||
          upcomingOntripRideRes.data?.newRide?.isNotEmpty == true) {
        emit(
          state.copyWith(
            isOnTripBottomSheetIsOpen: true,
            upComingRideData: upcomingOntripRideRes,
            upComingRideApiStatus: ApiStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            upComingRideData: upcoming.UpcomingOntripRideRes(
              data: upcoming.UpcomingOntripRideResData(
                cancelledRide: upcomingOntripRideRes.data?.cancelledRide,
                completedRide: upcomingOntripRideRes.data?.completedRide,
                all: upcomingOntripRideRes.data?.all,
                assignedRide: upcomingOntripRideRes.data?.assignedRide,
                revenue: upcomingOntripRideRes.data?.revenue,
              ),
            ),
            isOnTripBottomSheetIsOpen: true,
            upComingRideApiStatus: ApiStatus.empty,
          ),
        );
      }
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          isOnTripBottomSheetIsOpen: false,
          upComingRideApiStatus: ApiStatus.failure,
        ),
      );
    }
  }

  Future<void> getRidesMatrix({String? date}) async {
    try {
      emit(state.copyWith(ridesMatrixApiStatus: ApiStatus.loading));
      final response = await MainHomeData.getRidesMatrix(
        lpId: UserRepository.getLpID ?? '',
        userId: UserRepository.getUserID ?? '',
        date: date ?? "This Week",
      );

      if (response['status'] == "success") {
        final getAllTripData = GetAllTripsData.fromJson(response);
        emit(
          state.copyWith(
            getAllTripsData: getAllTripData,
            ridesMatrixApiStatus: ApiStatus.success,
          ),
        );
      }
    } on ApiException catch (e) {
      emit(state.copyWith(ridesMatrixApiStatus: ApiStatus.failure));
    }
  }

  Future<void> getUserData() async {
    try {
      emit(state.copyWith(getProfileData: ApiStatus.loading));

      final response = await MainHomeData.getProfileData(
        lpId: UserRepository.getLpID ?? '',
        userId: UserRepository.getUserID ?? '',
      );

      if (response['status'] == "success") {
        final getUserProfileData = GetUserProfileData.fromJson(response);
        ProfileRepository.instance.setUserFirstName(
          getUserProfileData.data?.firstName ?? "",
        );
        ProfileRepository.instance.setCountryCode(
          getUserProfileData.data?.countryCode ?? "",
        );
        ProfileRepository.instance.setUserPhoneNumber(
          getUserProfileData.data?.phoneNumber ?? "",
        );
        UserRepository.instance.setAccessPhoneNumber(
          getUserProfileData.data?.phoneNumber ?? "",
        );

        ProfileRepository.instance.setUserLastName(
          getUserProfileData.data?.lastName ?? "",
        );
        ProfileRepository.instance.setUserEmail(
          getUserProfileData.data?.email ?? "",
        );
        ProfileRepository.instance.setUserProfileIcon(
          getUserProfileData.data?.profileImage ?? "",
        );
        ProfileRepository.instance.setUserProfileAccountStatus(
          getUserProfileData.data?.accountStatus ?? "",
        );
        ProfileRepository.instance.setUserProfileAccountRating(
          getUserProfileData.data?.accountRating ?? "",
        );
        ProfileRepository.instance.setActingDriver(
          getUserProfileData.data?.activeDriver.toString() ?? "",
        );
        ProfileRepository.instance.setVehicleModel(
          getUserProfileData.data?.vehicleModel ?? "",
        );
        ProfileRepository.instance.setVehicleType(
          getUserProfileData.data?.vehicleType ?? "",
        );
        ProfileRepository.instance.setVehicleName(
          getUserProfileData.data?.vehicleName ?? "",
        );
        ProfileRepository.instance.setVehicleNumber(
          getUserProfileData.data?.vehicleNumber ?? "",
        );
        ProfileRepository.instance.setAgencyList(
          getUserProfileData.data?.agencyList,
        );
        ProfileRepository.instance.setUserProfileAccountStatus(
          getUserProfileData.data?.accountStatus ?? "",
        );
        ProfileRepository.instance.init();

        if (getUserProfileData.data?.firstName?.isEmpty == true) {
          AnywhereDoor.pushReplacementNamed(
            navigatorKey.currentState!.context,
            routeName: RouteName.newDriverScreen,
          );
        }
        // else if (getUserProfileData.data?.vehicleModel?.isEmpty == true &&
        //     flavour.F.appFlavor != flavour.Flavor.bmtravels) {
        //   AnywhereDoor.pushReplacementNamed(navigatorKey.currentState!.context,
        //       routeName: RouteName.vehicleInfoScreen);
        // }

        // await getDlvyBusinessOverview(date: "This Week");
        emit(
          state.copyWith(
            getProfileData: ApiStatus.success,
            getUserProfileData: getUserProfileData,
          ),
        );
      }
    } on ApiException catch (e) {
      emit(state.copyWith(getProfileData: ApiStatus.failure));
    }
  }

  Future<bool?> mutateHireDriverRides({
    required String rideID,
    required RideStatus rideStatus,
    required String mutationReason,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    int? index,
  }) async {
    try {
      emit(state.copyWith(driverMutateRideStatus: ApiStatus.loading));
      User rideUser = User(deviceToken: userDeviceToken ?? "");
      Payment payment = Payment(
        amount: userAmount,
        mode: userMode,
        status: userPaymentStatus,
        currency: userCurrency,
      );

      final currentLocation = await Utils.getCurrentLocation();
      final response = await MainHomeData.hireDriverMutateRide(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        position: DriverPosition(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        ),
        deviceToken: UserRepository.getDeviceToken ?? '',
        rideID: rideID,
        rideStatus: rideStatus.getRideStatusString,
        mutationReason: mutationReason,
        firstName: ProfileRepository.getFirstName ?? '',
        vehicleModel: ProfileRepository.getVehicleModel ?? '',
        vehicleName: ProfileRepository.getVehicleName ?? '',
        vehicleNumber: ProfileRepository.getVehicleNumber ?? '',
        userData: rideUser,
        payment: payment,
      );

      if (response['status'] == "error") {
        emit(state.copyWith(driverMutateRideStatus: ApiStatus.failure));
        rideAcceptedByOtherDriver(
          context: navigatorKey.currentState!.context,
          message: response['message'],
        );
      } else {
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.success,
            rideStatus: rideStatus,
          ),
        );

        goToRideStatusRoute(state.rideStatus, index!);
        final rides = List<upcoming.UpcomingRide>.from(
          state.acceptedHireRides ?? [],
        );
        rides.removeWhere((element) => element.rideId == rideID);
        emit(state.copyWith(acceptedHireRides: rides));

        return true;
      }
    } catch (e) {
      emit(state.copyWith(driverMutateRideStatus: ApiStatus.failure));
    }
  }

  Future<bool?> canceMutateHireDriverRides({
    required String tripId,
    required String rideID,
    required String rateID,
    required RideStatus rideStatus,
    required String mutationReason,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    String? mode,
  }) async {
    try {
      emit(state.copyWith(cancelDriverMutateRideStatus: ApiStatus.loading));

      User rideUser = User(deviceToken: userDeviceToken ?? "");
      Payment payment = Payment(
        amount: userAmount,
        mode: userMode,
        status: userPaymentStatus,
        currency: userCurrency,
      );

      final currentLocation = await Utils.getCurrentLocation();
      final response = await MainHomeData.hireDriverMutateRide(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        position: DriverPosition(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        ),
        deviceToken: UserRepository.getDeviceToken ?? '',
        rideID: rideID,
        rideStatus: rideStatus.getRideStatusString,
        mutationReason: mutationReason,
        userData: rideUser,
        payment: payment,
        firstName: ProfileRepository.getFirstName ?? '',
        vehicleModel: ProfileRepository.getVehicleModel ?? '',
        vehicleName: ProfileRepository.getVehicleName ?? '',
        vehicleNumber: ProfileRepository.getVehicleNumber ?? '',
      );

      if (response['status'] == "success") {
        final rides = List<upcoming.UpcomingRide>.from(
          state.acceptedHireRides ?? [],
        );

        rides.removeWhere((element) => element.rideId == rideID);

        emit(
          state.copyWith(
            cancelDriverMutateRideStatus: ApiStatus.success,
            acceptedHireRides: rides,
          ),
        );

        return true;
      }
    } catch (e) {
      emit(state.copyWith(cancelDriverMutateRideStatus: ApiStatus.failure));
    }
  }

  Future<bool?> canceMutateNewDriverRides({
    required String tripId,
    required String rideID,
    required String rateID,
    required RideStatus rideStatus,
    required String mutationReason,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    String? mode,
  }) async {
    try {
      emit(state.copyWith(cancelDriverMutateRideStatus: ApiStatus.loading));

      User rideUser = User(deviceToken: userDeviceToken ?? "");
      Payment payment = Payment(
        amount: userAmount,
        mode: userMode,
        status: userPaymentStatus,
        currency: userCurrency,
      );

      final currentLocation = await Utils.getCurrentLocation();
      final response = await MainHomeData.hireDriverMutateRide(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        position: DriverPosition(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        ),
        deviceToken: UserRepository.getDeviceToken ?? '',
        rideID: rideID,
        rideStatus: rideStatus.getRideStatusString,
        mutationReason: mutationReason,
        userData: rideUser,
        payment: payment,
        firstName: ProfileRepository.getFirstName ?? '',
        vehicleModel: ProfileRepository.getVehicleModel ?? '',
        vehicleName: ProfileRepository.getVehicleName ?? '',
        vehicleNumber: ProfileRepository.getVehicleNumber ?? '',
      );

      if (response['status'] == "success") {
        final rides = List<upcoming.NewRide>.from(state.acceptedNewRides ?? []);

        rides.removeWhere((element) => element.rideId == rideID);

        emit(
          state.copyWith(
            cancelDriverMutateRideStatus: ApiStatus.success,
            acceptedNewRides: rides,
          ),
        );

        return true;
      }
    } catch (e) {
      emit(state.copyWith(cancelDriverMutateRideStatus: ApiStatus.failure));
    }
  }

  goToRideStatusRoute(RideStatus rideStatus, int index) {
    switch (rideStatus) {
      case RideStatus.accepted:
        break;
      case RideStatus.started:
        Navigator.pushReplacementNamed(
          navigatorKey.currentState!.context,
          arguments: HireDriverRideDirectionsScreenParams(
            ride:
                state.upComingRideData?.data?.ontripRide?.firstOrNull ??
                upcoming.OntripRide.fromJson(
                  state.upComingRideData?.data?.upcomingRide?[index].toJson() ??
                      {},
                ),
          ),
          RouteName.hireDriverRideDirectionsScreen,
        );
        break;
      case RideStatus.declined:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Navigator.of(navigatorKey.currentState!.context).canPop()) {
            AnywhereDoor.pop(navigatorKey.currentState!.context);
          }
        });

        break;
      case RideStatus.unresponsive:
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
      case RideStatus.cancel:
        // TODO: Handle this case.
        break;
      case RideStatus.none:
        // TODO: Handle this case.
        break;
    }
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
                right: 20 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 150 * SizeConfig.heightMultiplier!,
                width: 320 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: AppColors.kRedD32F2F,
                  borderRadius: BorderRadius.circular(
                    5 * SizeConfig.widthMultiplier!,
                  ),
                ),
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
                            imagePath: ImagePath.errorOutlineIcon,
                          ),
                          CustomSizedBox(width: 7),
                          Expanded(
                            child: Text(
                              message ?? "something went wrong..",
                              style: AppTextStyle.text16kWhiteW600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CustomSizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              AnywhereDoor.pop(context);
                            },
                            child: ImageLoader.svgPictureAssetImage(
                              imagePath: ImagePath.cutIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String?> getImgUrl({required String imgUrl}) async {
    try {
      Uint8List bytes =
          (await NetworkAssetBundle(
            Uri.parse(imgUrl),
          ).load(imgUrl)).buffer.asUint8List();
      print("The image exists!");
      return imgUrl;
    } catch (e) {
      return null;
    }
  }

  Widget futureBulder({required String imgUrl}) {
    return FutureBuilder(
      future: getImgUrl(imgUrl: imgUrl),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        bool error = snapshot.data == null;
        return error
            ? const HomeScreenShimmer()
            : Padding(
              padding: EdgeInsets.only(
                left: 18.0 * SizeConfig.widthMultiplier!,
                right: 18 * SizeConfig.widthMultiplier!,
              ),
              child: Center(
                child: SizedBox(
                  height: 160 * SizeConfig.heightMultiplier!,
                  child: GestureDetector(
                    onTap: () async {
                      if (Platform.isAndroid) {
                        Share.share(
                          'https://play.google.com/store/apps/details?id=com.byteplace.gigly.driver.ride&hl=en_US',
                          subject: 'GiglyAi Driver',
                        );
                      } else if (Platform.isIOS) {
                        Share.share(
                          'https://apps.apple.com/in/app/giglyai-driver/id6502331194',
                          subject: 'GiglyAi Driver',
                        );
                      }
                    },
                    child: ImageLoader.networkAssetImage(
                      imagePath: snapshot.data!,
                    ),
                  ),
                ),
              ),
            );
      },
    );
  }

  DraggableScrollableSheet showAcceptedRideBottomSheet() {
    DraggableScrollableController guestController =
        DraggableScrollableController();
    int? selectedRideIndex;
    return DraggableScrollableSheet(
      controller: guestController,
      snap: false,
      minChildSize: 0.3 * SizeConfig.heightMultiplier!,
      initialChildSize: 0.3 * SizeConfig.heightMultiplier!,
      maxChildSize: 0.72 * SizeConfig.heightMultiplier!,
      builder: (context, scrollController) {
        return StatefulBuilder(
          builder: (context, setState1) {
            final newDeliveryCount =
                state.upComingRideData?.data?.upcomingRide?.length ?? 0;
            final upcomingDeliveryCount =
                state.upComingRideData?.data?.newRide?.length ?? 0;

            if (newDeliveryCount == 0 && upcomingDeliveryCount == 0) {
              return SizedBox(); // Don't render the Positioned widget at all
            }
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kBlackTextColor.withOpacity(0.20),
                        blurRadius: 4, // soften the shadow
                        spreadRadius: 1.0, //extend the shadow
                      ),
                    ],
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10 * SizeConfig.widthMultiplier!),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: BlocBuilder<MainHomeCubit, MainHomeState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomSizedBox(height: 20),
                            Center(
                              child: Container(
                                width: 63 * SizeConfig.widthMultiplier!,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    50 * SizeConfig.widthMultiplier!,
                                  ),
                                  color: AppColors.kBlackTextColor.withOpacity(
                                    0.21,
                                  ),
                                  border: Border.all(
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.21),
                                    width: 2 * SizeConfig.widthMultiplier!,
                                  ),
                                ),
                              ),
                            ),
                            CustomSizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CustomSizedBox(width: 5),
                                  ...List.generate(
                                    state
                                            .upComingRideData
                                            ?.data
                                            ?.upcomingRide
                                            ?.length ??
                                        0,
                                    (index) {
                                      final acceptedRide =
                                          state
                                              .upComingRideData
                                              ?.data
                                              ?.upcomingRide?[index];
                                      return SizedBox(
                                        width:
                                            380 * SizeConfig.widthMultiplier!,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left:
                                                10 *
                                                SizeConfig.widthMultiplier!,
                                            right:
                                                20 *
                                                SizeConfig.widthMultiplier!,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomSizedBox(height: 10),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      10 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "ID: ${acceptedRide?.rideId}",
                                                      style: AppTextStyle
                                                          .text14Black0000W800
                                                          ?.copyWith(
                                                            color: AppColors
                                                                .kBlackTextColor
                                                                .withOpacity(
                                                                  0.64,
                                                                ),
                                                          ),
                                                    ),
                                                    // Spacer(),
                                                    // ImageLoader.svgPictureAssetImage(
                                                    //     imagePath: ImagePath
                                                    //         .arrowRightDoubleLineIcon)
                                                  ],
                                                ),
                                              ),
                                              CustomSizedBox(height: 10),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxWidth:
                                                          120 *
                                                          SizeConfig
                                                              .widthMultiplier!, // Adjust this value as per your requirement
                                                      // or set a specific maxWidth value if needed
                                                    ),
                                                    child: ContainerWithBorder(
                                                      wantPadding: true,
                                                      containerColor:
                                                          AppColors
                                                              .kLightYelFFF3F0,
                                                      borderColor:
                                                          AppColors
                                                              .kLightYelFFF3F0,
                                                      borderRadius:
                                                          32 *
                                                          SizeConfig
                                                              .widthMultiplier!,
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal:
                                                              16 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          vertical:
                                                              8 *
                                                              SizeConfig
                                                                  .heightMultiplier!,
                                                        ),
                                                        child: Text(
                                                          "${acceptedRide?.createdBy?.name.toString()}",
                                                          style:
                                                              AppTextStyle
                                                                  .text14black0000W800,
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      try {
                                                        Utils.launchPhoneDialer(
                                                          acceptedRide
                                                                  ?.tripSequence?[0]
                                                                  .phoneNumber ??
                                                              '',
                                                        );
                                                      } catch (e) {}
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            16 *
                                                            SizeConfig
                                                                .widthMultiplier!,
                                                        vertical:
                                                            8 *
                                                            SizeConfig
                                                                .heightMultiplier!,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            AppColors
                                                                .kGreenE8FAF0,
                                                      ),
                                                      child:
                                                          ImageLoader.svgPictureAssetImage(
                                                            imagePath:
                                                                ImagePath
                                                                    .onlyCallIcon,
                                                          ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${acceptedRide?.payment?.amount.toString()}",
                                                        style: AppTextStyle
                                                            .text45kBlue0644AAW900
                                                            ?.copyWith(
                                                              height: 0.8,
                                                            ),
                                                      ),
                                                      Text(
                                                        " ${acceptedRide?.payment?.currency.toString()}",
                                                        style:
                                                            AppTextStyle
                                                                .text14kBlue0644AAW300,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              CustomSizedBox(height: 10),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ContainerWithBorder(
                                                    wantPadding: true,
                                                    containerColor: AppColors
                                                        .kLightYelFE8C00
                                                        .withOpacity(0.08),
                                                    borderColor: AppColors
                                                        .kLightYelFE8C00
                                                        .withOpacity(0.08),
                                                    borderRadius:
                                                        8 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            10 *
                                                            SizeConfig
                                                                .widthMultiplier!,
                                                        vertical:
                                                            10 *
                                                            SizeConfig
                                                                .heightMultiplier!,
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ImageLoader.svgPictureAssetImage(
                                                            imagePath:
                                                                ImagePath
                                                                    .timeNewIcon,
                                                            color:
                                                                AppColors
                                                                    .kBlackTextColor,
                                                          ),
                                                          CustomSizedBox(
                                                            width: 8,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Pickup Time",
                                                                style:
                                                                    AppTextStyle
                                                                        .text14black0000W500,
                                                              ),
                                                              Text(
                                                                acceptedRide
                                                                        ?.tripSequence?[0]
                                                                        .pickupTime ??
                                                                    '',
                                                                style: AppTextStyle
                                                                    .text12darkGreen12B76AW700
                                                                    ?.copyWith(
                                                                      fontSize:
                                                                          16 *
                                                                          SizeConfig
                                                                              .textMultiplier!,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  // ContainerWithBorder(
                                                  //   wantPadding: true,
                                                  //   containerColor:
                                                  //       AppColors
                                                  //           .kLightYelFFF3F0,
                                                  //   borderColor:
                                                  //       AppColors
                                                  //           .kLightYelFFF3F0,
                                                  //   borderRadius:
                                                  //       32 *
                                                  //       SizeConfig
                                                  //           .widthMultiplier!,
                                                  //   child: Padding(
                                                  //     padding: EdgeInsets.symmetric(
                                                  //       horizontal:
                                                  //           16 *
                                                  //           SizeConfig
                                                  //               .widthMultiplier!,
                                                  //       vertical:
                                                  //           8 *
                                                  //           SizeConfig
                                                  //               .heightMultiplier!,
                                                  //     ),
                                                  //     child: Text(
                                                  //       "Amount Fee",
                                                  //       style:
                                                  //           AppTextStyle
                                                  //               .text14Black0000W400,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              CustomSizedBox(height: 10),
                                              Divider(
                                                thickness:
                                                    2 *
                                                    SizeConfig.widthMultiplier!,
                                                color: AppColors.kBlackTextColor
                                                    .withOpacity(0.10),
                                              ),
                                              CustomSizedBox(height: 5),
                                              Row(
                                                children: [
                                                  ImageLoader.svgPictureAssetImage(
                                                    width:
                                                        16 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    height:
                                                        16 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    imagePath:
                                                        ImagePath
                                                            .locationFilledIcon,
                                                    color:
                                                        AppColors
                                                            .kBlackTextColor,
                                                  ),
                                                  CustomSizedBox(width: 5),
                                                  Text(
                                                    "Pickup",
                                                    style: AppTextStyle
                                                        .text17black0000W800
                                                        ?.copyWith(
                                                          color: AppColors
                                                              .kBlackTextColor
                                                              .withOpacity(
                                                                0.64,
                                                              ),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              CustomSizedBox(height: 5),
                                              ContainerWithBorder(
                                                wantPadding: true,
                                                containerColor: AppColors
                                                    .kBlack242424
                                                    .withOpacity(0.04),
                                                borderColor: AppColors
                                                    .kBlack242424
                                                    .withOpacity(0.08),
                                                borderRadius:
                                                    10 *
                                                    SizeConfig.widthMultiplier!,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        8 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    vertical:
                                                        8 *
                                                        SizeConfig
                                                            .heightMultiplier!,
                                                  ),
                                                  child: SingleUsableAddressRow(
                                                    dropUpAddress:
                                                        "${acceptedRide?.tripSequence?[0].address}",
                                                  ),
                                                ),
                                              ),
                                              CustomSizedBox(height: 5),
                                              Row(
                                                children: [
                                                  ImageLoader.svgPictureAssetImage(
                                                    width:
                                                        16 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    height:
                                                        16 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    imagePath:
                                                        ImagePath
                                                            .dropFilledIcon,
                                                    color:
                                                        AppColors
                                                            .kBlackTextColor,
                                                  ),
                                                  CustomSizedBox(width: 5),
                                                  Text(
                                                    "Dropoff",
                                                    style: AppTextStyle
                                                        .text17black0000W800
                                                        ?.copyWith(
                                                          color: AppColors
                                                              .kBlackTextColor
                                                              .withOpacity(
                                                                0.64,
                                                              ),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              CustomSizedBox(height: 5),
                                              ContainerWithBorder(
                                                wantPadding: true,
                                                containerColor: AppColors
                                                    .kBlack242424
                                                    .withOpacity(0.04),
                                                borderColor: AppColors
                                                    .kBlack242424
                                                    .withOpacity(0.08),
                                                borderRadius:
                                                    10 *
                                                    SizeConfig.widthMultiplier!,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        8 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    vertical:
                                                        8 *
                                                        SizeConfig
                                                            .heightMultiplier!,
                                                  ),
                                                  child: SingleUsableAddressRow(
                                                    dropUpAddress:
                                                        "${acceptedRide?.tripSequence?[1].address}",
                                                  ),
                                                ),
                                              ),
                                              CustomSizedBox(height: 10),

                                              CustomSizedBox(height: 10),
                                              if (acceptedRide?.payment?.mode
                                                      ?.toUpperCase() ==
                                                  "CASH")
                                                ContainerWithBorder(
                                                  wantPadding: true,
                                                  containerColor:
                                                      AppColors.kGreenE8FAF0,
                                                  borderColor:
                                                      AppColors.kGreenE8FAF0,
                                                  borderRadius:
                                                      8 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          8 *
                                                          SizeConfig
                                                              .widthMultiplier!,
                                                      vertical:
                                                          8 *
                                                          SizeConfig
                                                              .heightMultiplier!,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        // Left Side: Icon + Commission (if any) + Amount
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if ((acceptedRide
                                                                        ?.commAmount ??
                                                                    0) >
                                                                0)
                                                              CustomSizedBox(
                                                                width: 20,
                                                              ),
                                                            Text(
                                                              'Commission: INR ${acceptedRide?.commAmount}',
                                                              style:
                                                                  AppTextStyle
                                                                      .text12kGrey909093W400,
                                                            ),
                                                            Row(
                                                              children: [
                                                                ImageLoader.svgPictureAssetImage(
                                                                  width:
                                                                      18 *
                                                                      SizeConfig
                                                                          .widthMultiplier!,
                                                                  height:
                                                                      18 *
                                                                      SizeConfig
                                                                          .widthMultiplier!,
                                                                  imagePath:
                                                                      ImagePath
                                                                          .billNotesIcon,
                                                                ),
                                                                CustomSizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  'Amount : ${acceptedRide?.payment?.currency} ${(acceptedRide?.payment?.amount)}',
                                                                  style:
                                                                      AppTextStyle
                                                                          .text18black0000W700,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                        const Spacer(),

                                                        // Right Side: Payment Mode Chip
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                horizontal:
                                                                    10 *
                                                                    SizeConfig
                                                                        .widthMultiplier!,
                                                              ),
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  16 *
                                                                  SizeConfig
                                                                      .widthMultiplier!,
                                                              vertical:
                                                                  8 *
                                                                  SizeConfig
                                                                      .widthMultiplier!,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10 *
                                                                        SizeConfig
                                                                            .widthMultiplier!,
                                                                  ),
                                                              color:
                                                                  AppColors
                                                                      .kLightYelDECF45,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                acceptedRide
                                                                            ?.payment
                                                                            ?.mode
                                                                            ?.toUpperCase() ==
                                                                        "CASH"
                                                                    ? "CASH"
                                                                    : "${acceptedRide?.payment?.mode?.toUpperCase()}",
                                                                style:
                                                                    AppTextStyle
                                                                        .text14black0000W600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              else
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            16 *
                                                            SizeConfig
                                                                .widthMultiplier!,
                                                        vertical:
                                                            8 *
                                                            SizeConfig
                                                                .widthMultiplier!,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10 *
                                                                  SizeConfig
                                                                      .widthMultiplier!,
                                                            ),
                                                        color:
                                                            AppColors
                                                                .darkGreen59BF70,
                                                      ),
                                                      child: Text(
                                                        "${acceptedRide?.payment?.mode?.toUpperCase()}",
                                                        style: AppTextStyle
                                                            .text14kWhiteFFW500
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              CustomSizedBox(height: 20),
                                              Row(
                                                children: [
                                                  CustomSizedBox(width: 5),
                                                  BlueButton(
                                                    wantMargin: false,
                                                    height:
                                                        50 *
                                                        SizeConfig
                                                            .heightMultiplier!,
                                                    width:
                                                        200 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    buttonColor:
                                                        AppColors.kGreen489D5B,
                                                    borderRadius:
                                                        20 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    title: "start_now".tr,
                                                    fontSize:
                                                        22 *
                                                        SizeConfig
                                                            .textMultiplier!,
                                                    isLoading:
                                                        state
                                                            .driverMutateRideStatus
                                                            .isLoading,
                                                    onTap: () async {
                                                      selectedRideIndex = index;

                                                      bool?
                                                      getValue = await mutateHireDriverRides(
                                                        index:
                                                            selectedRideIndex ??
                                                            0,
                                                        bookedFor: "book_ride",
                                                        rideID:
                                                            acceptedRide
                                                                ?.rideId ??
                                                            '',
                                                        rideStatus:
                                                            RideStatus.started,
                                                        userDeviceToken:
                                                            acceptedRide
                                                                ?.user
                                                                ?.deviceToken ??
                                                            '',
                                                        userAmount:
                                                            acceptedRide
                                                                ?.payment
                                                                ?.amount ??
                                                            '',
                                                        userCurrency:
                                                            acceptedRide
                                                                ?.payment
                                                                ?.currency ??
                                                            '',
                                                        userMode:
                                                            acceptedRide
                                                                ?.payment
                                                                ?.mode ??
                                                            '',
                                                        userPaymentStatus:
                                                            acceptedRide
                                                                ?.payment
                                                                ?.status ??
                                                            '',
                                                        mutationReason: '',
                                                      );

                                                      if (getValue == true) {
                                                        await getUpcomingOnTripRideData();
                                                      }
                                                    },
                                                  ),
                                                  CustomSizedBox(width: 10),
                                                  CustomOutlineButton(
                                                    borderColor:
                                                        AppColors.kredFA4A0C,
                                                    borderWidth: 0.5,
                                                    titleColor:
                                                        AppColors
                                                            .kBlackTextColor,
                                                    wantMargin: false,
                                                    height:
                                                        50 *
                                                        SizeConfig
                                                            .heightMultiplier!,
                                                    width:
                                                        109 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    buttonColor:
                                                        AppColors.kWhiteFFFF,
                                                    borderRadius:
                                                        20 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    onTap: () async {
                                                      cancelRideUpComingConfirmationPop(
                                                        context: context,
                                                        bookedFor: "book_ride",
                                                        tripId:
                                                            acceptedRide
                                                                ?.tripId ??
                                                            '',
                                                        rateID:
                                                            acceptedRide
                                                                ?.price
                                                                ?.id ??
                                                            "",
                                                        rideId:
                                                            acceptedRide
                                                                ?.rideId ??
                                                            '',
                                                        rideStatus:
                                                            RideStatus.cancel,
                                                        userDeviceToken:
                                                            acceptedRide
                                                                ?.user
                                                                ?.deviceToken ??
                                                            '',
                                                        userAmount:
                                                            acceptedRide
                                                                ?.payment
                                                                ?.amount ??
                                                            '',
                                                        userCurrency:
                                                            acceptedRide
                                                                ?.payment
                                                                ?.currency ??
                                                            '',
                                                        userMode:
                                                            acceptedRide
                                                                ?.payment
                                                                ?.mode ??
                                                            '',
                                                        userPaymentStatus:
                                                            acceptedRide
                                                                ?.payment
                                                                ?.status ??
                                                            '',
                                                        mutationReason: '',
                                                      );
                                                    },
                                                    title: "cancel".tr,
                                                    buttonIsEnabled:
                                                        acceptedRide
                                                            ?.cancelRide ==
                                                        true,
                                                  ),
                                                ],
                                              ),
                                              CustomSizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  /// this is new order list (accept order)
                                  ...List.generate(
                                    state
                                            .upComingRideData
                                            ?.data
                                            ?.newRide
                                            ?.length ??
                                        0,
                                    (index) {
                                      final acceptedRide =
                                          state
                                              .upComingRideData
                                              ?.data
                                              ?.newRide?[index];
                                      return SizedBox(
                                        width:
                                            380 * SizeConfig.widthMultiplier!,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left:
                                                10 *
                                                SizeConfig.widthMultiplier!,
                                            right:
                                                10 *
                                                SizeConfig.widthMultiplier!,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomSizedBox(height: 10),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      14 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "ID: ${acceptedRide?.rideId}",
                                                      style: AppTextStyle
                                                          .text14Black0000W800
                                                          ?.copyWith(
                                                            color: AppColors
                                                                .kBlackTextColor
                                                                .withOpacity(
                                                                  0.64,
                                                                ),
                                                          ),
                                                    ),

                                                    // Spacer(),
                                                    // ImageLoader.svgPictureAssetImage(
                                                    //     imagePath: ImagePath
                                                    //         .arrowRightDoubleLineIcon)
                                                  ],
                                                ),
                                              ),
                                              CustomSizedBox(height: 10),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left:
                                                      5 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                  right:
                                                      16 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                            maxWidth:
                                                                120 *
                                                                SizeConfig
                                                                    .widthMultiplier!, // Adjust this value as per your requirement
                                                            // or set a specific maxWidth value if needed
                                                          ),
                                                          child: ContainerWithBorder(
                                                            wantPadding: true,
                                                            containerColor:
                                                                AppColors
                                                                    .kLightYelFFF3F0,
                                                            borderColor:
                                                                AppColors
                                                                    .kLightYelFFF3F0,
                                                            borderRadius:
                                                                32 *
                                                                SizeConfig
                                                                    .widthMultiplier!,
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    16 *
                                                                    SizeConfig
                                                                        .widthMultiplier!,
                                                                vertical:
                                                                    8 *
                                                                    SizeConfig
                                                                        .heightMultiplier!,
                                                              ),
                                                              child: Text(
                                                                "${acceptedRide?.createdBy?.name.toString()}",
                                                                style:
                                                                    AppTextStyle
                                                                        .text14black0000W800,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            try {
                                                              Utils.launchPhoneDialer(
                                                                acceptedRide
                                                                        ?.tripSequence?[0]
                                                                        .phoneNumber ??
                                                                    '',
                                                              );
                                                            } catch (e) {}
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  16 *
                                                                  SizeConfig
                                                                      .widthMultiplier!,
                                                              vertical:
                                                                  8 *
                                                                  SizeConfig
                                                                      .heightMultiplier!,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  AppColors
                                                                      .kGreenE8FAF0,
                                                            ),
                                                            child: ImageLoader.svgPictureAssetImage(
                                                              imagePath:
                                                                  ImagePath
                                                                      .onlyCallIcon,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${acceptedRide?.payment?.amount.toString()}",
                                                              style: AppTextStyle
                                                                  .text45kBlue0644AAW900
                                                                  ?.copyWith(
                                                                    height: 0.8,
                                                                  ),
                                                            ),
                                                            Text(
                                                              " ${acceptedRide?.payment?.currency.toString()}",
                                                              style:
                                                                  AppTextStyle
                                                                      .text14kBlue0644AAW300,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    CustomSizedBox(height: 10),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ContainerWithBorder(
                                                          wantPadding: true,
                                                          containerColor:
                                                              AppColors
                                                                  .kLightYelFE8C00
                                                                  .withOpacity(
                                                                    0.08,
                                                                  ),
                                                          borderColor: AppColors
                                                              .kLightYelFE8C00
                                                              .withOpacity(
                                                                0.08,
                                                              ),
                                                          borderRadius:
                                                              8 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10 *
                                                                  SizeConfig
                                                                      .widthMultiplier!,
                                                              vertical:
                                                                  10 *
                                                                  SizeConfig
                                                                      .heightMultiplier!,
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                ImageLoader.svgPictureAssetImage(
                                                                  imagePath:
                                                                      ImagePath
                                                                          .timeNewIcon,
                                                                  color:
                                                                      AppColors
                                                                          .kBlackTextColor,
                                                                ),
                                                                CustomSizedBox(
                                                                  width: 8,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Pickup Time",
                                                                      style:
                                                                          AppTextStyle
                                                                              .text14black0000W500,
                                                                    ),
                                                                    Text(
                                                                      acceptedRide
                                                                              ?.tripSequence?[0]
                                                                              .pickupTime ??
                                                                          '',
                                                                      style: AppTextStyle.text12darkGreen12B76AW700?.copyWith(
                                                                        fontSize:
                                                                            16 *
                                                                            SizeConfig.textMultiplier!,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // Spacer(),
                                                        // ContainerWithBorder(
                                                        //   wantPadding: true,
                                                        //   containerColor:
                                                        //       AppColors
                                                        //           .kLightYelFFF3F0,
                                                        //   borderColor:
                                                        //       AppColors
                                                        //           .kLightYelFFF3F0,
                                                        //   borderRadius:
                                                        //       32 *
                                                        //       SizeConfig
                                                        //           .widthMultiplier!,
                                                        //   child: Padding(
                                                        //     padding: EdgeInsets.symmetric(
                                                        //       horizontal:
                                                        //           16 *
                                                        //           SizeConfig
                                                        //               .widthMultiplier!,
                                                        //       vertical:
                                                        //           8 *
                                                        //           SizeConfig
                                                        //               .heightMultiplier!,
                                                        //     ),
                                                        //     child: Text(
                                                        //       "Amount Fee",
                                                        //       style:
                                                        //           AppTextStyle
                                                        //               .text14Black0000W400,
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                    CustomSizedBox(height: 10),
                                                    Divider(
                                                      thickness:
                                                          2 *
                                                          SizeConfig
                                                              .widthMultiplier!,
                                                      color: AppColors
                                                          .kBlackTextColor
                                                          .withOpacity(0.10),
                                                    ),
                                                    CustomSizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        ImageLoader.svgPictureAssetImage(
                                                          width:
                                                              16 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          height:
                                                              16 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          imagePath:
                                                              ImagePath
                                                                  .locationFilledIcon,
                                                          color:
                                                              AppColors
                                                                  .kBlackTextColor,
                                                        ),
                                                        CustomSizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "Pickup",
                                                          style: AppTextStyle
                                                              .text17black0000W800
                                                              ?.copyWith(
                                                                color: AppColors
                                                                    .kBlackTextColor
                                                                    .withOpacity(
                                                                      0.64,
                                                                    ),
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    CustomSizedBox(height: 5),
                                                    ContainerWithBorder(
                                                      wantPadding: true,
                                                      containerColor: AppColors
                                                          .kBlack242424
                                                          .withOpacity(0.04),
                                                      borderColor: AppColors
                                                          .kBlack242424
                                                          .withOpacity(0.08),
                                                      borderRadius:
                                                          10 *
                                                          SizeConfig
                                                              .widthMultiplier!,
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal:
                                                              8 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          vertical:
                                                              8 *
                                                              SizeConfig
                                                                  .heightMultiplier!,
                                                        ),
                                                        child: SingleUsableAddressRow(
                                                          dropUpAddress:
                                                              "${acceptedRide?.tripSequence?[0].address}",
                                                        ),
                                                      ),
                                                    ),
                                                    CustomSizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        ImageLoader.svgPictureAssetImage(
                                                          width:
                                                              16 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          height:
                                                              16 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          imagePath:
                                                              ImagePath
                                                                  .dropFilledIcon,
                                                          color:
                                                              AppColors
                                                                  .kBlackTextColor,
                                                        ),
                                                        CustomSizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "Dropoff",
                                                          style: AppTextStyle
                                                              .text17black0000W800
                                                              ?.copyWith(
                                                                color: AppColors
                                                                    .kBlackTextColor
                                                                    .withOpacity(
                                                                      0.64,
                                                                    ),
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    CustomSizedBox(height: 5),
                                                    ContainerWithBorder(
                                                      wantPadding: true,
                                                      containerColor: AppColors
                                                          .kBlack242424
                                                          .withOpacity(0.04),
                                                      borderColor: AppColors
                                                          .kBlack242424
                                                          .withOpacity(0.08),
                                                      borderRadius:
                                                          10 *
                                                          SizeConfig
                                                              .widthMultiplier!,
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal:
                                                              8 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          vertical:
                                                              8 *
                                                              SizeConfig
                                                                  .heightMultiplier!,
                                                        ),
                                                        child: SingleUsableAddressRow(
                                                          dropUpAddress:
                                                              "${acceptedRide?.tripSequence?[1].address}",
                                                        ),
                                                      ),
                                                    ),

                                                    CustomSizedBox(height: 10),
                                                    if (acceptedRide
                                                            ?.payment
                                                            ?.mode
                                                            ?.toUpperCase() ==
                                                        "CASH")
                                                      ContainerWithBorder(
                                                        wantPadding: true,
                                                        containerColor:
                                                            AppColors
                                                                .kGreenE8FAF0,
                                                        borderColor:
                                                            AppColors
                                                                .kGreenE8FAF0,
                                                        borderRadius:
                                                            8 *
                                                            SizeConfig
                                                                .widthMultiplier!,
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                8 *
                                                                SizeConfig
                                                                    .widthMultiplier!,
                                                            vertical:
                                                                8 *
                                                                SizeConfig
                                                                    .heightMultiplier!,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              // Left Side: Icon + Commission (if any) + Amount
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  if ((acceptedRide
                                                                              ?.commAount ??
                                                                          0) >
                                                                      0)
                                                                    Text(
                                                                      'Commission: INR ${acceptedRide?.commAount}',
                                                                      style:
                                                                          AppTextStyle
                                                                              .text16black0000W600,
                                                                    ),
                                                                  Row(
                                                                    children: [
                                                                      ImageLoader.svgPictureAssetImage(
                                                                        width:
                                                                            18 *
                                                                            SizeConfig.widthMultiplier!,
                                                                        height:
                                                                            18 *
                                                                            SizeConfig.widthMultiplier!,
                                                                        imagePath:
                                                                            ImagePath.billNotesIcon,
                                                                      ),
                                                                      CustomSizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'Amount : ${acceptedRide?.payment?.currency} ${(acceptedRide?.payment?.amount)}',
                                                                        style:
                                                                            AppTextStyle.text18black0000W700,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),

                                                              const Spacer(),

                                                              // Right Side: Payment Mode Chip
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      10 *
                                                                      SizeConfig
                                                                          .widthMultiplier!,
                                                                ),
                                                                child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        16 *
                                                                        SizeConfig
                                                                            .widthMultiplier!,
                                                                    vertical:
                                                                        8 *
                                                                        SizeConfig
                                                                            .widthMultiplier!,
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          10 *
                                                                              SizeConfig.widthMultiplier!,
                                                                        ),
                                                                    color:
                                                                        AppColors
                                                                            .kLightYelDECF45,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      acceptedRide?.payment?.mode?.toUpperCase() ==
                                                                              "CASH"
                                                                          ? "CASH"
                                                                          : "${acceptedRide?.payment?.mode?.toUpperCase()}",
                                                                      style:
                                                                          AppTextStyle
                                                                              .text14black0000W600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    else
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  16 *
                                                                  SizeConfig
                                                                      .widthMultiplier!,
                                                              vertical:
                                                                  8 *
                                                                  SizeConfig
                                                                      .widthMultiplier!,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10 *
                                                                        SizeConfig
                                                                            .widthMultiplier!,
                                                                  ),
                                                              color:
                                                                  AppColors
                                                                      .darkGreen59BF70,
                                                            ),
                                                            child: Text(
                                                              "${acceptedRide?.payment?.mode?.toUpperCase()}",
                                                              style: AppTextStyle
                                                                  .text14kWhiteFFW500
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    CustomSizedBox(height: 20),
                                                    Row(
                                                      children: [
                                                        BlueButton(
                                                          wantMargin: false,
                                                          height:
                                                              50 *
                                                              SizeConfig
                                                                  .heightMultiplier!,
                                                          width:
                                                              200 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          buttonColor:
                                                              AppColors
                                                                  .kBlue3D6,
                                                          fontSize:
                                                              22 *
                                                              SizeConfig
                                                                  .textMultiplier!,
                                                          borderRadius:
                                                              20 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          title: "Accept".tr,
                                                          isLoading:
                                                              state
                                                                  .driverMutateRideStatus
                                                                  .isLoading,
                                                          onTap: () async {
                                                            selectedRideIndex =
                                                                index;

                                                            bool?
                                                            getValue = await mutateHireDriverRides(
                                                              index:
                                                                  selectedRideIndex ??
                                                                  0,
                                                              bookedFor:
                                                                  "book_ride",
                                                              rideID:
                                                                  acceptedRide
                                                                      ?.rideId ??
                                                                  '',
                                                              rideStatus:
                                                                  RideStatus
                                                                      .accepted,
                                                              userDeviceToken:
                                                                  acceptedRide
                                                                      ?.user
                                                                      ?.deviceToken ??
                                                                  '',
                                                              userAmount:
                                                                  acceptedRide
                                                                      ?.payment
                                                                      ?.amount ??
                                                                  '',
                                                              userCurrency:
                                                                  acceptedRide
                                                                      ?.payment
                                                                      ?.currency ??
                                                                  '',
                                                              userMode:
                                                                  acceptedRide
                                                                      ?.payment
                                                                      ?.mode ??
                                                                  '',
                                                              userPaymentStatus:
                                                                  acceptedRide
                                                                      ?.payment
                                                                      ?.status ??
                                                                  '',
                                                              mutationReason:
                                                                  '',
                                                            );

                                                            if (getValue ==
                                                                true) {
                                                              await getUpcomingOnTripRideData();
                                                            }
                                                          },
                                                        ),
                                                        CustomSizedBox(
                                                          width: 20,
                                                        ),
                                                        CustomOutlineButton(
                                                          borderColor:
                                                              AppColors
                                                                  .kredFA4A0C,
                                                          borderWidth: 0.5,
                                                          titleColor:
                                                              AppColors
                                                                  .kBlackTextColor,
                                                          wantMargin: false,
                                                          height:
                                                              50 *
                                                              SizeConfig
                                                                  .heightMultiplier!,
                                                          width:
                                                              109 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          buttonColor:
                                                              AppColors
                                                                  .kWhiteFFFF,
                                                          borderRadius:
                                                              20 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          onTap: () async {
                                                            cancelRideNewRideConfirmationPop(
                                                              context: context,
                                                              bookedFor:
                                                                  "book_ride",
                                                              tripId:
                                                                  acceptedRide
                                                                      ?.tripId ??
                                                                  '',
                                                              rateID:
                                                                  acceptedRide
                                                                      ?.price
                                                                      ?.id ??
                                                                  "",
                                                              rideId:
                                                                  acceptedRide
                                                                      ?.rideId ??
                                                                  '',
                                                              rideStatus:
                                                                  RideStatus
                                                                      .cancel,
                                                              userDeviceToken:
                                                                  acceptedRide
                                                                      ?.user
                                                                      ?.deviceToken ??
                                                                  '',
                                                              userAmount:
                                                                  acceptedRide
                                                                      ?.payment
                                                                      ?.amount ??
                                                                  '',
                                                              userCurrency:
                                                                  acceptedRide
                                                                      ?.payment
                                                                      ?.currency ??
                                                                  '',
                                                              userMode:
                                                                  acceptedRide
                                                                      ?.payment
                                                                      ?.mode ??
                                                                  '',
                                                              userPaymentStatus:
                                                                  acceptedRide
                                                                      ?.payment
                                                                      ?.status ??
                                                                  '',
                                                              mutationReason:
                                                                  '',
                                                            );
                                                          },
                                                          title: "cancel".tr,
                                                          buttonIsEnabled:
                                                              acceptedRide
                                                                  ?.cancelRide ==
                                                              true,
                                                        ),
                                                      ],
                                                    ),
                                                    CustomSizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            CustomSizedBox(height: 30),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: -20 * SizeConfig.heightMultiplier!,
                  right: 10 * SizeConfig.widthMultiplier!,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12 * SizeConfig.widthMultiplier!,
                      vertical: 5 * SizeConfig.heightMultiplier!,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kGreenE8FAF0,
                      borderRadius: BorderRadius.circular(
                        16 * SizeConfig.widthMultiplier!,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.kBlackTextColor.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          newDeliveryCount > 0 ? "New Ride" : "Ready To Pickup",
                          style: AppTextStyle.text12black0000W600,
                        ),
                        CustomSizedBox(width: 5),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 6 * SizeConfig.heightMultiplier!,
                            horizontal: 10 * SizeConfig.widthMultiplier!,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kBlue2C6DFF,
                            borderRadius: BorderRadius.circular(
                              11 * SizeConfig.widthMultiplier!,
                            ),
                          ),
                          child: Text(
                            (newDeliveryCount > 0
                                    ? newDeliveryCount
                                    : upcomingDeliveryCount)
                                .toString(),
                            style: AppTextStyle.text16white0000W600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // DraggableScrollableSheet showAcceptedRideBottomSheet() {
  //   DraggableScrollableController guestController =
  //       DraggableScrollableController();
  //   int? selectedRideIndex;
  //   return DraggableScrollableSheet(
  //     controller: guestController,
  //     snap: false,
  //     minChildSize: 0.12,
  //     initialChildSize: 0.65,
  //     maxChildSize: 0.65,
  //     builder: (context, scrollController) {
  //       return Container(
  //         decoration: BoxDecoration(
  //           boxShadow: [
  //             BoxShadow(
  //               color: AppColors.kBlackTextColor.withOpacity(0.20),
  //               blurRadius: 4, // soften the shadow
  //               spreadRadius: 1.0, //extend the shadow
  //             ),
  //           ],
  //           color: AppColors.kWhite,
  //           borderRadius: BorderRadius.vertical(
  //             top: Radius.circular(10 * SizeConfig.widthMultiplier!),
  //           ),
  //         ),
  //         child: SingleChildScrollView(
  //           controller: scrollController,
  //           child: BlocBuilder<MainHomeCubit, MainHomeState>(
  //             builder: (context, state) {
  //               return Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   CustomSizedBox(height: 20),
  //                   Center(
  //                     child: Container(
  //                       width: 63 * SizeConfig.widthMultiplier!,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(
  //                           50 * SizeConfig.widthMultiplier!,
  //                         ),
  //                         color: AppColors.kBlackTextColor.withOpacity(0.21),
  //                         border: Border.all(
  //                           color: AppColors.kBlackTextColor.withOpacity(0.21),
  //                           width: 2 * SizeConfig.widthMultiplier!,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   CustomSizedBox(height: 10),
  //                   SingleChildScrollView(
  //                     scrollDirection: Axis.horizontal,
  //                     child: Row(
  //                       children: [
  //                         CustomSizedBox(width: 10),
  //                         ...List.generate(
  //                           state
  //                                   .upComingRideData
  //                                   ?.data
  //                                   ?.upcomingRide
  //                                   ?.length ??
  //                               0,
  //                           (index) {
  //                             final acceptedRide =
  //                                 state
  //                                     .upComingRideData
  //                                     ?.data
  //                                     ?.upcomingRide?[index];
  //                             return Padding(
  //                               padding: EdgeInsets.only(
  //                                 right: 10 * SizeConfig.widthMultiplier!,
  //                               ),
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 children: [
  //                                   Center(
  //                                     child: Text(
  //                                       "upcoming_rides".tr,
  //                                       style: AppTextStyle.text18black0000W600,
  //                                     ),
  //                                   ),
  //                                   CustomSizedBox(height: 10),
  //                                   Container(
  //                                     decoration: BoxDecoration(
  //                                       border: Border.all(
  //                                         color: AppColors.kBlackTextColor
  //                                             .withOpacity(0.19),
  //                                       ),
  //                                       boxShadow: [
  //                                         BoxShadow(
  //                                           blurRadius: 3,
  //                                           color: AppColors.kBlackTextColor
  //                                               .withOpacity(0.19),
  //                                         ),
  //                                       ],
  //                                       color: AppColors.kWhite,
  //                                       borderRadius: BorderRadius.circular(
  //                                         8 * SizeConfig.widthMultiplier!,
  //                                       ),
  //                                     ),
  //                                     child: Padding(
  //                                       padding: EdgeInsets.only(
  //                                         left:
  //                                             12 * SizeConfig.widthMultiplier!,
  //                                         top:
  //                                             12 * SizeConfig.heightMultiplier!,
  //                                         bottom:
  //                                             12 * SizeConfig.heightMultiplier!,
  //                                         right:
  //                                             12 * SizeConfig.widthMultiplier!,
  //                                       ),
  //                                       child: Column(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.start,
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         mainAxisSize: MainAxisSize.min,
  //                                         children: [
  //                                           CustomSizedBox(height: 10),
  //                                           Row(
  //                                             children: [
  //                                               ContainerWithBorder(
  //                                                 wantPadding: true,
  //                                                 containerColor:
  //                                                     acceptedRide?.rideFeature ==
  //                                                             "Ride"
  //                                                         ? AppColors
  //                                                             .kBlack1E2E2E
  //                                                         : AppColors
  //                                                             .kGreen40B59F,
  //                                                 borderColor:
  //                                                     acceptedRide?.rideFeature ==
  //                                                             "Ride"
  //                                                         ? AppColors
  //                                                             .kBlack1E2E2E
  //                                                         : AppColors
  //                                                             .kGreen40B59F,
  //                                                 child: Padding(
  //                                                   padding: EdgeInsets.only(
  //                                                     left:
  //                                                         15 *
  //                                                         SizeConfig
  //                                                             .widthMultiplier!,
  //                                                     right:
  //                                                         15 *
  //                                                         SizeConfig
  //                                                             .widthMultiplier!,
  //                                                     top:
  //                                                         2 *
  //                                                         SizeConfig
  //                                                             .heightMultiplier!,
  //                                                     bottom:
  //                                                         2 *
  //                                                         SizeConfig
  //                                                             .heightMultiplier!,
  //                                                   ),
  //                                                   child: Text(
  //                                                     acceptedRide
  //                                                             ?.rideFeature ??
  //                                                         "",
  //                                                     style:
  //                                                         acceptedRide?.rideFeature ==
  //                                                                 "Ride"
  //                                                             ? AppTextStyle
  //                                                                 .text12kWhiteFFW500
  //                                                             : AppTextStyle
  //                                                                 .text12Bblack0000W500,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               CustomSizedBox(
  //                                                 width:
  //                                                     150 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                               ),
  //                                               Text(
  //                                                 "${acceptedRide?.payment?.amount.toString()} ${acceptedRide?.payment?.currency.toString()}",
  //                                                 style:
  //                                                     AppTextStyle
  //                                                         .text20black0000W700,
  //                                               ),
  //                                               CustomSizedBox(width: 10),
  //                                             ],
  //                                           ),
  //                                           CustomSizedBox(height: 8),
  //                                           Row(
  //                                             mainAxisAlignment:
  //                                                 MainAxisAlignment.start,
  //                                             children: [
  //                                               Text(
  //                                                 "ID: ${acceptedRide?.rideId}",
  //                                                 style: AppTextStyle
  //                                                     .text12black0000W400
  //                                                     ?.copyWith(
  //                                                       color: AppColors
  //                                                           .kBlackTextColor
  //                                                           .withOpacity(0.50),
  //                                                     ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                           CustomSizedBox(height: 10),
  //                                           Container(
  //                                             padding: EdgeInsets.only(
  //                                               top:
  //                                                   4 *
  //                                                   SizeConfig
  //                                                       .heightMultiplier!,
  //                                               bottom:
  //                                                   4 *
  //                                                   SizeConfig
  //                                                       .heightMultiplier!,
  //                                             ),
  //                                             decoration: BoxDecoration(
  //                                               border: Border.all(
  //                                                 color: AppColors.kGreyD5DDE0,
  //                                               ),
  //                                               color: AppColors.kWhite,
  //                                               borderRadius:
  //                                                   BorderRadius.circular(
  //                                                     10 *
  //                                                         SizeConfig
  //                                                             .widthMultiplier!,
  //                                                   ),
  //                                             ),
  //                                             child: Padding(
  //                                               padding: EdgeInsets.only(
  //                                                 left:
  //                                                     11 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 right:
  //                                                     5 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                               ),
  //                                               child: Row(
  //                                                 crossAxisAlignment:
  //                                                     CrossAxisAlignment.center,
  //                                                 mainAxisSize:
  //                                                     MainAxisSize.min,
  //                                                 children: [
  //                                                   Text(
  //                                                     "${acceptedRide?.tripDetails?.distance.toString() ?? ""} ${acceptedRide?.tripDetails?.distanceUnit.toString() ?? ""}",
  //                                                     style:
  //                                                         AppTextStyle
  //                                                             .text12kRed907171W500,
  //                                                   ),
  //                                                   CustomSizedBox(width: 3),
  //                                                   SizedBox(
  //                                                     height:
  //                                                         10 *
  //                                                         SizeConfig
  //                                                             .heightMultiplier!,
  //                                                     child: VerticalDivider(
  //                                                       thickness: 1,
  //                                                       color: AppColors
  //                                                           .kBlackTextColor
  //                                                           .withOpacity(0.18),
  //                                                     ),
  //                                                   ),
  //                                                   Text(
  //                                                     "${acceptedRide?.tripDetails?.duration.toString() ?? ""} ${acceptedRide?.tripDetails?.durationUnit.toString() ?? ""}",
  //                                                     style:
  //                                                         AppTextStyle
  //                                                             .text12kRed907171W500,
  //                                                   ),
  //                                                   if (acceptedRide
  //                                                               ?.tripDetails
  //                                                               ?.noOfTolls !=
  //                                                           null &&
  //                                                       acceptedRide!
  //                                                               .tripDetails!
  //                                                               .noOfTolls! >
  //                                                           0)
  //                                                     SizedBox(
  //                                                       height:
  //                                                           10 *
  //                                                           SizeConfig
  //                                                               .heightMultiplier!,
  //                                                       child: VerticalDivider(
  //                                                         thickness: 1,
  //                                                         color: AppColors
  //                                                             .kBlackTextColor
  //                                                             .withOpacity(
  //                                                               0.18,
  //                                                             ),
  //                                                       ),
  //                                                     ),
  //                                                   acceptedRide
  //                                                                   ?.tripDetails
  //                                                                   ?.noOfTolls !=
  //                                                               null &&
  //                                                           acceptedRide!
  //                                                                   .tripDetails!
  //                                                                   .noOfTolls! >
  //                                                               0
  //                                                       ? Container(
  //                                                         padding: EdgeInsets.all(
  //                                                           5 *
  //                                                               SizeConfig
  //                                                                   .widthMultiplier!,
  //                                                         ),
  //                                                         decoration: BoxDecoration(
  //                                                           color:
  //                                                               AppColors
  //                                                                   .kWhiteFFFF,
  //                                                           borderRadius:
  //                                                               BorderRadius.circular(
  //                                                                 21 *
  //                                                                     SizeConfig
  //                                                                         .widthMultiplier!,
  //                                                               ),
  //                                                         ),
  //                                                         child: Row(
  //                                                           children: [
  //                                                             ImageLoader.svgPictureAssetImage(
  //                                                               imagePath:
  //                                                                   ImagePath
  //                                                                       .tollIcon,
  //                                                             ),
  //                                                             CustomSizedBox(
  //                                                               width: 5,
  //                                                             ),
  //                                                             Text(
  //                                                               "${acceptedRide.tripDetails?.noOfTolls.toString() ?? ""} tolls",
  //                                                               style:
  //                                                                   AppTextStyle
  //                                                                       .text12kRed907171W500,
  //                                                             ),
  //                                                           ],
  //                                                         ),
  //                                                       )
  //                                                       : const SizedBox.shrink(),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           CustomSizedBox(height: 10),
  //                                           Row(
  //                                             children: [
  //                                               Container(
  //                                                 padding: EdgeInsets.only(
  //                                                   left:
  //                                                       9 *
  //                                                       SizeConfig
  //                                                           .widthMultiplier!,
  //                                                   right:
  //                                                       9 *
  //                                                       SizeConfig
  //                                                           .widthMultiplier!,
  //                                                   top:
  //                                                       5 *
  //                                                       SizeConfig
  //                                                           .heightMultiplier!,
  //                                                   bottom:
  //                                                       5 *
  //                                                       SizeConfig
  //                                                           .heightMultiplier!,
  //                                                 ),
  //                                                 decoration: BoxDecoration(
  //                                                   color: AppColors
  //                                                       .kWhiteEAE4E4
  //                                                       .withOpacity(0.48),
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                         16 *
  //                                                             SizeConfig
  //                                                                 .widthMultiplier!,
  //                                                       ),
  //                                                 ),
  //                                                 child: Row(
  //                                                   children: [
  //                                                     ImageLoader.svgPictureAssetImage(
  //                                                       imagePath:
  //                                                           ImagePath
  //                                                               .checkRadioIcon,
  //                                                     ),
  //                                                     CustomSizedBox(width: 7),
  //                                                     Text(
  //                                                       acceptedRide
  //                                                               ?.rideType ??
  //                                                           "",
  //                                                       style:
  //                                                           AppTextStyle
  //                                                               .text12black0000W500,
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                               ),
  //                                               CustomSizedBox(width: 10),
  //                                               if (acceptedRide?.rideFeature !=
  //                                                   "Ride")
  //                                                 Container(
  //                                                   padding: EdgeInsets.only(
  //                                                     left:
  //                                                         9 *
  //                                                         SizeConfig
  //                                                             .widthMultiplier!,
  //                                                     right:
  //                                                         9 *
  //                                                         SizeConfig
  //                                                             .widthMultiplier!,
  //                                                     top:
  //                                                         5 *
  //                                                         SizeConfig
  //                                                             .heightMultiplier!,
  //                                                     bottom:
  //                                                         5 *
  //                                                         SizeConfig
  //                                                             .heightMultiplier!,
  //                                                   ),
  //                                                   decoration: BoxDecoration(
  //                                                     color: AppColors
  //                                                         .kWhiteEAE4E4
  //                                                         .withOpacity(0.48),
  //                                                     borderRadius:
  //                                                         BorderRadius.circular(
  //                                                           16 *
  //                                                               SizeConfig
  //                                                                   .widthMultiplier!,
  //                                                         ),
  //                                                   ),
  //                                                   child: Row(
  //                                                     children: [
  //                                                       ImageLoader.svgPictureAssetImage(
  //                                                         imagePath:
  //                                                             ImagePath
  //                                                                 .checkRadioIcon,
  //                                                       ),
  //                                                       CustomSizedBox(
  //                                                         width: 7,
  //                                                       ),
  //                                                       Text(
  //                                                         acceptedRide
  //                                                                 ?.vehicleType ??
  //                                                             "",
  //                                                         style:
  //                                                             AppTextStyle
  //                                                                 .text12black0000W500,
  //                                                       ),
  //                                                     ],
  //                                                   ),
  //                                                 ),
  //                                               Container(
  //                                                 padding: EdgeInsets.only(
  //                                                   left:
  //                                                       9 *
  //                                                       SizeConfig
  //                                                           .widthMultiplier!,
  //                                                   right:
  //                                                       9 *
  //                                                       SizeConfig
  //                                                           .widthMultiplier!,
  //                                                   top:
  //                                                       5 *
  //                                                       SizeConfig
  //                                                           .heightMultiplier!,
  //                                                   bottom:
  //                                                       5 *
  //                                                       SizeConfig
  //                                                           .heightMultiplier!,
  //                                                 ),
  //                                                 decoration: BoxDecoration(
  //                                                   color: AppColors
  //                                                       .kWhiteEAE4E4
  //                                                       .withOpacity(0.48),
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                         16 *
  //                                                             SizeConfig
  //                                                                 .widthMultiplier!,
  //                                                       ),
  //                                                 ),
  //                                                 child: Row(
  //                                                   children: [
  //                                                     ImageLoader.svgPictureAssetImage(
  //                                                       imagePath:
  //                                                           ImagePath
  //                                                               .checkRadioIcon,
  //                                                     ),
  //                                                     CustomSizedBox(width: 7),
  //                                                     Text(
  //                                                       acceptedRide
  //                                                               ?.rideVehicle ??
  //                                                           "",
  //                                                       style:
  //                                                           AppTextStyle
  //                                                               .text12black0000W500,
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                           CustomSizedBox(height: 14),
  //                                           Row(
  //                                             children: [
  //                                               Text(
  //                                                 "pickup_time".tr,
  //                                                 style:
  //                                                     AppTextStyle
  //                                                         .text14black0000W400,
  //                                               ),
  //                                               CustomSizedBox(width: 10),
  //                                               Text(
  //                                                 acceptedRide
  //                                                         ?.tripSequence?[0]
  //                                                         .pickupTime ??
  //                                                     '',
  //                                                 style:
  //                                                     AppTextStyle
  //                                                         .text16black0000W700,
  //                                               ),
  //                                             ],
  //                                           ),
  //                                           CustomSizedBox(height: 14),
  //                                           Row(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               ImageLoader.svgPictureAssetImage(
  //                                                 width:
  //                                                     20 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 height:
  //                                                     20 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 imagePath:
  //                                                     ImagePath
  //                                                         .locationIconGreen,
  //                                               ),
  //                                               CustomSizedBox(width: 10),
  //                                               SizedBox(
  //                                                 width:
  //                                                     250 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 child: Text(
  //                                                   "${acceptedRide?.tripSequence?[0].address} (Pickup)",
  //                                                   style:
  //                                                       AppTextStyle
  //                                                           .text14black0000W400,
  //                                                   maxLines: 2,
  //                                                   overflow:
  //                                                       TextOverflow.ellipsis,
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                           CustomSizedBox(height: 10),
  //                                           Row(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               ImageLoader.svgPictureAssetImage(
  //                                                 width:
  //                                                     20 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 height:
  //                                                     20 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 imagePath:
  //                                                     ImagePath
  //                                                         .locationIconGreen,
  //                                               ),
  //                                               CustomSizedBox(width: 10),
  //                                               SizedBox(
  //                                                 width:
  //                                                     250 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 child: Text(
  //                                                   "${acceptedRide?.tripSequence?[1].address} (Dropoff)",
  //                                                   style:
  //                                                       AppTextStyle
  //                                                           .text14black0000W400,
  //                                                   maxLines: 2,
  //                                                   overflow:
  //                                                       TextOverflow.ellipsis,
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                           CustomSizedBox(height: 10),
  //                                           GestureDetector(
  //                                             onTap: () {
  //                                               try {
  //                                                 Utils.launchPhoneDialer(
  //                                                   acceptedRide
  //                                                           ?.tripSequence?[0]
  //                                                           .phoneNumber ??
  //                                                       '',
  //                                                 );
  //                                               } catch (e) {}
  //                                             },
  //                                             child: Container(
  //                                               padding: EdgeInsets.symmetric(
  //                                                 vertical:
  //                                                     5 *
  //                                                     SizeConfig
  //                                                         .heightMultiplier!,
  //                                                 horizontal:
  //                                                     10 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                               ),
  //                                               decoration: BoxDecoration(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(
  //                                                       8 *
  //                                                           SizeConfig
  //                                                               .widthMultiplier!,
  //                                                     ),
  //                                                 border: Border.all(
  //                                                   color:
  //                                                       AppColors
  //                                                           .kBlackTextColor,
  //                                                   width:
  //                                                       1 *
  //                                                       SizeConfig
  //                                                           .widthMultiplier!,
  //                                                 ),
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize:
  //                                                     MainAxisSize.min,
  //                                                 children: [
  //                                                   ImageLoader.svgPictureAssetImage(
  //                                                     imagePath:
  //                                                         ImagePath.phoneNumber,
  //                                                   ),
  //                                                   Text(
  //                                                     "${acceptedRide?.tripSequence?[0].countryCode} - ${acceptedRide?.tripSequence?[0].phoneNumber}",
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           CustomSizedBox(height: 10),
  //                                           Row(
  //                                             children: [
  //                                               ImageLoader.svgPictureAssetImage(
  //                                                 imagePath: ImagePath.userIcon,
  //                                                 color:
  //                                                     AppColors.kBlackTextColor,
  //                                               ),
  //                                               CustomSizedBox(width: 7),
  //                                               Text(
  //                                                 acceptedRide
  //                                                         ?.tripSequence?[0]
  //                                                         .firstName ??
  //                                                     "",
  //                                                 style:
  //                                                     AppTextStyle
  //                                                         .text14black0000W400,
  //                                               ),
  //                                             ],
  //                                           ),
  //                                           CustomSizedBox(height: 13),
  //                                           Row(
  //                                             children: [
  //                                               BlueButton(
  //                                                 width:
  //                                                     150 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 wantMargin: false,
  //                                                 height:
  //                                                     40 *
  //                                                     SizeConfig
  //                                                         .heightMultiplier!,
  //                                                 title: "start_now".tr,
  //                                                 textColor:
  //                                                     AppColors.kBlackTextColor,
  //                                                 isLoading:
  //                                                     state
  //                                                         .driverMutateRideStatus
  //                                                         .isLoading,
  //                                                 buttonColor:
  //                                                     AppColors.kGreen199675,
  //                                                 onTap: () async {
  //                                                   selectedRideIndex = index;
  //
  //                                                   await mutateHireDriverRides(
  //                                                     index:
  //                                                         selectedRideIndex ??
  //                                                         0,
  //                                                     bookedFor: "book_ride",
  //                                                     rideID:
  //                                                         acceptedRide
  //                                                             ?.rideId ??
  //                                                         '',
  //                                                     rideStatus:
  //                                                         RideStatus.started,
  //                                                     userDeviceToken:
  //                                                         acceptedRide
  //                                                             ?.user
  //                                                             ?.deviceToken ??
  //                                                         '',
  //                                                     userAmount:
  //                                                         acceptedRide
  //                                                             ?.payment
  //                                                             ?.amount ??
  //                                                         '',
  //                                                     userCurrency:
  //                                                         acceptedRide
  //                                                             ?.payment
  //                                                             ?.currency ??
  //                                                         '',
  //                                                     userMode:
  //                                                         acceptedRide
  //                                                             ?.payment
  //                                                             ?.mode ??
  //                                                         '',
  //                                                     userPaymentStatus:
  //                                                         acceptedRide
  //                                                             ?.payment
  //                                                             ?.status ??
  //                                                         '',
  //                                                     mutationReason: '',
  //                                                   );
  //                                                 },
  //                                               ),
  //                                               CustomSizedBox(width: 10),
  //                                               CustomOutlineButton(
  //                                                 width:
  //                                                     140 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 onTap: () async {
  //                                                   cancelRideUpComingConfirmationPop(
  //                                                     context: context,
  //                                                     bookedFor: "book_ride",
  //                                                     tripId:
  //                                                         acceptedRide
  //                                                             ?.tripId ??
  //                                                         '',
  //                                                     rateID:
  //                                                         acceptedRide
  //                                                             ?.price
  //                                                             ?.id ??
  //                                                         "",
  //                                                     rideId:
  //                                                         acceptedRide
  //                                                             ?.rideId ??
  //                                                         '',
  //                                                     rideStatus:
  //                                                         RideStatus.cancel,
  //                                                     userDeviceToken:
  //                                                         acceptedRide
  //                                                             ?.user
  //                                                             ?.deviceToken ??
  //                                                         '',
  //                                                     userAmount:
  //                                                         acceptedRide
  //                                                             ?.payment
  //                                                             ?.amount ??
  //                                                         '',
  //                                                     userCurrency:
  //                                                         acceptedRide
  //                                                             ?.payment
  //                                                             ?.currency ??
  //                                                         '',
  //                                                     userMode:
  //                                                         acceptedRide
  //                                                             ?.payment
  //                                                             ?.mode ??
  //                                                         '',
  //                                                     userPaymentStatus:
  //                                                         acceptedRide
  //                                                             ?.payment
  //                                                             ?.status ??
  //                                                         '',
  //                                                     mutationReason: '',
  //                                                   );
  //
  //                                                   // await showDialog(
  //                                                   //     context: context,
  //                                                   //     builder: (BuildContext
  //                                                   //         context) {
  //                                                   //       return AlertDialog(
  //                                                   //         backgroundColor:
  //                                                   //             AppColors
  //                                                   //                 .kWhite,
  //                                                   //         titlePadding:
  //                                                   //             EdgeInsets
  //                                                   //                 .zero,
  //                                                   //         shape: RoundedRectangleBorder(
  //                                                   //             borderRadius:
  //                                                   //                 BorderRadius.circular(10 *
  //                                                   //                     SizeConfig
  //                                                   //                         .widthMultiplier!)),
  //                                                   //         title: Column(
  //                                                   //           crossAxisAlignment:
  //                                                   //               CrossAxisAlignment
  //                                                   //                   .start,
  //                                                   //           mainAxisSize:
  //                                                   //               MainAxisSize
  //                                                   //                   .min,
  //                                                   //           children: [
  //                                                   //             CustomSizedBox(
  //                                                   //                 height: 10 *
  //                                                   //                     SizeConfig
  //                                                   //                         .heightMultiplier!),
  //                                                   //             Padding(
  //                                                   //               padding: EdgeInsets.only(
  //                                                   //                   left: 16 *
  //                                                   //                       SizeConfig.widthMultiplier!),
  //                                                   //               child: Text(
  //                                                   //                 "Do_you_want_to_cancel_this_ride"
  //                                                   //                     .tr,
  //                                                   //                 style: AppTextStyle
  //                                                   //                     .text14Black0000W400,
  //                                                   //                 textAlign:
  //                                                   //                     TextAlign
  //                                                   //                         .start,
  //                                                   //               ),
  //                                                   //             ),
  //                                                   //             SizedBox(
  //                                                   //                 height: 10 *
  //                                                   //                     SizeConfig
  //                                                   //                         .heightMultiplier!),
  //                                                   //             Row(
  //                                                   //               mainAxisAlignment:
  //                                                   //                   MainAxisAlignment
  //                                                   //                       .spaceBetween,
  //                                                   //               children: [
  //                                                   //                 CustomOutlineButton(
  //                                                   //                   borderRadius:
  //                                                   //                       5 * SizeConfig.widthMultiplier!,
  //                                                   //                   width: 90 *
  //                                                   //                       SizeConfig.widthMultiplier!,
  //                                                   //                   height: 30 *
  //                                                   //                       SizeConfig.heightMultiplier!,
  //                                                   //                   borderColor:
  //                                                   //                       AppColors.kBlackTextColor,
  //                                                   //                   titleColor:
  //                                                   //                       AppColors.kBlackTextColor,
  //                                                   //                   title: "confirm"
  //                                                   //                       .tr,
  //                                                   //                   isLoading: state
  //                                                   //                       .cancelDriverMutateRideStatus
  //                                                   //                       .isLoading,
  //                                                   //                   buttonIsEnabled:
  //                                                   //                       acceptedRide?.cancelRide ==
  //                                                   //                           true,
  //                                                   //                   onTap:
  //                                                   //                       () async {
  //                                                   //                     bool? status = await canceMutateHireDriverRides(
  //                                                   //                         bookedFor: "book_ride",
  //                                                   //                         tripId: acceptedRide?.tripId ?? '',
  //                                                   //                         rateID: acceptedRide?.price?.id ?? "",
  //                                                   //                         rideID: acceptedRide?.rideId ?? '',
  //                                                   //                         rideStatus: RideStatus.cancel,
  //                                                   //                         userDeviceToken: acceptedRide?.user?.deviceToken ?? '',
  //                                                   //                         userAmount: acceptedRide?.payment?.amount ?? '',
  //                                                   //                         userCurrency: acceptedRide?.payment?.currency ?? '',
  //                                                   //                         userMode: acceptedRide?.payment?.mode ?? '',
  //                                                   //                         userPaymentStatus: acceptedRide?.payment?.status ?? '',
  //                                                   //                         mutationReason: '');
  //                                                   //                     if (status ==
  //                                                   //                         true) {
  //                                                   //                       await getUpcomingOnTripRideData();
  //                                                   //                       AnywhereDoor.pop(context);
  //                                                   //                     }
  //                                                   //                   },
  //                                                   //                 ),
  //                                                   //                 CustomOutlineButton(
  //                                                   //                   titleColor:
  //                                                   //                       AppColors.kRed1,
  //                                                   //                   borderColor:
  //                                                   //                       AppColors.kRed1,
  //                                                   //                   borderRadius:
  //                                                   //                       5 * SizeConfig.widthMultiplier!,
  //                                                   //                   width: 90 *
  //                                                   //                       SizeConfig.widthMultiplier!,
  //                                                   //                   height: 30 *
  //                                                   //                       SizeConfig.heightMultiplier!,
  //                                                   //                   title: "cancel"
  //                                                   //                       .tr,
  //                                                   //                   onTap:
  //                                                   //                       () {
  //                                                   //                     AnywhereDoor.pop(
  //                                                   //                         context);
  //                                                   //                   },
  //                                                   //                 ),
  //                                                   //               ],
  //                                                   //             ),
  //                                                   //             SizedBox(
  //                                                   //                 height: 20 *
  //                                                   //                     SizeConfig
  //                                                   //                         .heightMultiplier!),
  //                                                   //           ],
  //                                                   //         ),
  //                                                   //       );
  //                                                   //     });
  //                                                 },
  //                                                 wantMargin: false,
  //                                                 titleColor:
  //                                                     AppColors.kBlackTextColor,
  //                                                 borderColor:
  //                                                     AppColors.kGreen00996,
  //                                                 height:
  //                                                     40 *
  //                                                     SizeConfig
  //                                                         .heightMultiplier!,
  //                                                 borderRadius:
  //                                                     10 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 title: "cancel".tr,
  //                                                 buttonIsEnabled:
  //                                                     acceptedRide
  //                                                         ?.cancelRide ==
  //                                                     true,
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             );
  //                           },
  //                         ),
  //                         ...List.generate(state.upComingRideData?.data?.newRide?.length ?? 0, (
  //                           index,
  //                         ) {
  //                           final acceptedRide =
  //                               state.upComingRideData?.data?.newRide?[index];
  //                           return Padding(
  //                             padding: EdgeInsets.only(
  //                               right: 10 * SizeConfig.widthMultiplier!,
  //                             ),
  //                             child: Column(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 Center(
  //                                   child: Text(
  //                                     "New Ride".tr,
  //                                     style: AppTextStyle.text18black0000W600,
  //                                   ),
  //                                 ),
  //                                 CustomSizedBox(height: 10),
  //                                 Container(
  //                                   decoration: BoxDecoration(
  //                                     border: Border.all(
  //                                       color: AppColors.kBlackTextColor
  //                                           .withOpacity(0.19),
  //                                     ),
  //                                     boxShadow: [
  //                                       BoxShadow(
  //                                         blurRadius: 3,
  //                                         color: AppColors.kBlackTextColor
  //                                             .withOpacity(0.19),
  //                                       ),
  //                                     ],
  //                                     color: AppColors.kWhite,
  //                                     borderRadius: BorderRadius.circular(
  //                                       8 * SizeConfig.widthMultiplier!,
  //                                     ),
  //                                   ),
  //                                   child: Padding(
  //                                     padding: EdgeInsets.only(
  //                                       left: 12 * SizeConfig.widthMultiplier!,
  //                                       top: 12 * SizeConfig.heightMultiplier!,
  //                                       bottom:
  //                                           12 * SizeConfig.heightMultiplier!,
  //                                       right: 12 * SizeConfig.widthMultiplier!,
  //                                     ),
  //                                     child: Column(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.start,
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       mainAxisSize: MainAxisSize.min,
  //                                       children: [
  //                                         CustomSizedBox(height: 10),
  //                                         Row(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.spaceBetween,
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             ContainerWithBorder(
  //                                               wantPadding: true,
  //                                               containerColor:
  //                                                   acceptedRide?.rideFeature ==
  //                                                           "Ride"
  //                                                       ? AppColors.kBlack1E2E2E
  //                                                       : AppColors
  //                                                           .kGreen40B59F,
  //                                               borderColor:
  //                                                   acceptedRide?.rideFeature ==
  //                                                           "Ride"
  //                                                       ? AppColors.kBlack1E2E2E
  //                                                       : AppColors
  //                                                           .kGreen40B59F,
  //                                               child: Padding(
  //                                                 padding: EdgeInsets.only(
  //                                                   left:
  //                                                       15 *
  //                                                       SizeConfig
  //                                                           .widthMultiplier!,
  //                                                   right:
  //                                                       15 *
  //                                                       SizeConfig
  //                                                           .widthMultiplier!,
  //                                                   top:
  //                                                       2 *
  //                                                       SizeConfig
  //                                                           .heightMultiplier!,
  //                                                   bottom:
  //                                                       2 *
  //                                                       SizeConfig
  //                                                           .heightMultiplier!,
  //                                                 ),
  //                                                 child: Text(
  //                                                   acceptedRide?.rideFeature ??
  //                                                       "",
  //                                                   style:
  //                                                       acceptedRide?.rideFeature ==
  //                                                               "Ride"
  //                                                           ? AppTextStyle
  //                                                               .text12kWhiteFFW500
  //                                                           : AppTextStyle
  //                                                               .text12Bblack0000W500,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                             CustomSizedBox(
  //                                               width:
  //                                                   150 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                             ),
  //                                             Text(
  //                                               "${acceptedRide?.payment?.amount.toString()} ${acceptedRide?.payment?.currency.toString()}",
  //                                               style:
  //                                                   AppTextStyle
  //                                                       .text20black0000W700,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         CustomSizedBox(height: 8),
  //                                         Row(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.start,
  //                                           children: [
  //                                             Text(
  //                                               "ID: ${acceptedRide?.rideId}",
  //                                               style: AppTextStyle
  //                                                   .text12black0000W400
  //                                                   ?.copyWith(
  //                                                     color: AppColors
  //                                                         .kBlackTextColor
  //                                                         .withOpacity(0.50),
  //                                                   ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         CustomSizedBox(height: 10),
  //                                         Container(
  //                                           padding: EdgeInsets.only(
  //                                             top:
  //                                                 4 *
  //                                                 SizeConfig.heightMultiplier!,
  //                                             bottom:
  //                                                 4 *
  //                                                 SizeConfig.heightMultiplier!,
  //                                           ),
  //                                           decoration: BoxDecoration(
  //                                             border: Border.all(
  //                                               color: AppColors.kGreyD5DDE0,
  //                                             ),
  //                                             color: AppColors.kWhite,
  //                                             borderRadius:
  //                                                 BorderRadius.circular(
  //                                                   10 *
  //                                                       SizeConfig
  //                                                           .widthMultiplier!,
  //                                                 ),
  //                                           ),
  //                                           child: Padding(
  //                                             padding: EdgeInsets.only(
  //                                               left:
  //                                                   11 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                               right:
  //                                                   5 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                             ),
  //                                             child: Row(
  //                                               crossAxisAlignment:
  //                                                   CrossAxisAlignment.center,
  //                                               mainAxisSize: MainAxisSize.min,
  //                                               children: [
  //                                                 Text(
  //                                                   "${acceptedRide?.tripDetails?.distance.toString() ?? ""} ${acceptedRide?.tripDetails?.distanceUnit.toString() ?? ""}",
  //                                                   style:
  //                                                       AppTextStyle
  //                                                           .text12kRed907171W500,
  //                                                 ),
  //                                                 CustomSizedBox(width: 3),
  //                                                 SizedBox(
  //                                                   height:
  //                                                       10 *
  //                                                       SizeConfig
  //                                                           .heightMultiplier!,
  //                                                   child: VerticalDivider(
  //                                                     thickness: 1,
  //                                                     color: AppColors
  //                                                         .kBlackTextColor
  //                                                         .withOpacity(0.18),
  //                                                   ),
  //                                                 ),
  //                                                 Text(
  //                                                   "${acceptedRide?.tripDetails?.duration.toString() ?? ""} ${acceptedRide?.tripDetails?.durationUnit.toString() ?? ""}",
  //                                                   style:
  //                                                       AppTextStyle
  //                                                           .text12kRed907171W500,
  //                                                 ),
  //                                                 if (acceptedRide
  //                                                             ?.tripDetails
  //                                                             ?.noOfTolls !=
  //                                                         null &&
  //                                                     acceptedRide!
  //                                                             .tripDetails!
  //                                                             .noOfTolls! >
  //                                                         0)
  //                                                   SizedBox(
  //                                                     height:
  //                                                         10 *
  //                                                         SizeConfig
  //                                                             .heightMultiplier!,
  //                                                     child: VerticalDivider(
  //                                                       thickness: 1,
  //                                                       color: AppColors
  //                                                           .kBlackTextColor
  //                                                           .withOpacity(0.18),
  //                                                     ),
  //                                                   ),
  //                                                 acceptedRide
  //                                                                 ?.tripDetails
  //                                                                 ?.noOfTolls !=
  //                                                             null &&
  //                                                         acceptedRide!
  //                                                                 .tripDetails!
  //                                                                 .noOfTolls! >
  //                                                             0
  //                                                     ? Container(
  //                                                       padding: EdgeInsets.all(
  //                                                         5 *
  //                                                             SizeConfig
  //                                                                 .widthMultiplier!,
  //                                                       ),
  //                                                       decoration: BoxDecoration(
  //                                                         color:
  //                                                             AppColors
  //                                                                 .kWhiteFFFF,
  //                                                         borderRadius:
  //                                                             BorderRadius.circular(
  //                                                               21 *
  //                                                                   SizeConfig
  //                                                                       .widthMultiplier!,
  //                                                             ),
  //                                                       ),
  //                                                       child: Row(
  //                                                         children: [
  //                                                           ImageLoader.svgPictureAssetImage(
  //                                                             imagePath:
  //                                                                 ImagePath
  //                                                                     .tollIcon,
  //                                                           ),
  //                                                           CustomSizedBox(
  //                                                             width: 5,
  //                                                           ),
  //                                                           Text(
  //                                                             "${acceptedRide.tripDetails?.noOfTolls.toString() ?? ""} tolls",
  //                                                             style:
  //                                                                 AppTextStyle
  //                                                                     .text12kRed907171W500,
  //                                                           ),
  //                                                         ],
  //                                                       ),
  //                                                     )
  //                                                     : const SizedBox.shrink(),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         CustomSizedBox(height: 10),
  //                                         Row(
  //                                           children: [
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 left:
  //                                                     9 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 right:
  //                                                     9 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 top:
  //                                                     5 *
  //                                                     SizeConfig
  //                                                         .heightMultiplier!,
  //                                                 bottom:
  //                                                     5 *
  //                                                     SizeConfig
  //                                                         .heightMultiplier!,
  //                                               ),
  //                                               decoration: BoxDecoration(
  //                                                 color: AppColors.kWhiteEAE4E4
  //                                                     .withOpacity(0.48),
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(
  //                                                       16 *
  //                                                           SizeConfig
  //                                                               .widthMultiplier!,
  //                                                     ),
  //                                               ),
  //                                               child: Row(
  //                                                 children: [
  //                                                   ImageLoader.svgPictureAssetImage(
  //                                                     imagePath:
  //                                                         ImagePath
  //                                                             .checkRadioIcon,
  //                                                   ),
  //                                                   CustomSizedBox(width: 7),
  //                                                   Text(
  //                                                     acceptedRide?.rideType ??
  //                                                         "",
  //                                                     style:
  //                                                         AppTextStyle
  //                                                             .text12black0000W500,
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             CustomSizedBox(width: 10),
  //                                             if (acceptedRide?.rideFeature !=
  //                                                 "Ride")
  //                                               Container(
  //                                                 padding: EdgeInsets.only(
  //                                                   left:
  //                                                       9 *
  //                                                       SizeConfig
  //                                                           .widthMultiplier!,
  //                                                   right:
  //                                                       9 *
  //                                                       SizeConfig
  //                                                           .widthMultiplier!,
  //                                                   top:
  //                                                       5 *
  //                                                       SizeConfig
  //                                                           .heightMultiplier!,
  //                                                   bottom:
  //                                                       5 *
  //                                                       SizeConfig
  //                                                           .heightMultiplier!,
  //                                                 ),
  //                                                 decoration: BoxDecoration(
  //                                                   color: AppColors
  //                                                       .kWhiteEAE4E4
  //                                                       .withOpacity(0.48),
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                         16 *
  //                                                             SizeConfig
  //                                                                 .widthMultiplier!,
  //                                                       ),
  //                                                 ),
  //                                                 child: Row(
  //                                                   children: [
  //                                                     ImageLoader.svgPictureAssetImage(
  //                                                       imagePath:
  //                                                           ImagePath
  //                                                               .checkRadioIcon,
  //                                                     ),
  //                                                     CustomSizedBox(width: 7),
  //                                                     Text(
  //                                                       acceptedRide
  //                                                               ?.vehicleType ??
  //                                                           "",
  //                                                       style:
  //                                                           AppTextStyle
  //                                                               .text12black0000W500,
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                               ),
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 left:
  //                                                     9 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 right:
  //                                                     9 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                                 top:
  //                                                     5 *
  //                                                     SizeConfig
  //                                                         .heightMultiplier!,
  //                                                 bottom:
  //                                                     5 *
  //                                                     SizeConfig
  //                                                         .heightMultiplier!,
  //                                               ),
  //                                               decoration: BoxDecoration(
  //                                                 color: AppColors.kWhiteEAE4E4
  //                                                     .withOpacity(0.48),
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(
  //                                                       16 *
  //                                                           SizeConfig
  //                                                               .widthMultiplier!,
  //                                                     ),
  //                                               ),
  //                                               child: Row(
  //                                                 children: [
  //                                                   ImageLoader.svgPictureAssetImage(
  //                                                     imagePath:
  //                                                         ImagePath
  //                                                             .checkRadioIcon,
  //                                                   ),
  //                                                   CustomSizedBox(width: 7),
  //                                                   Text(
  //                                                     acceptedRide
  //                                                             ?.rideVehicle ??
  //                                                         "",
  //                                                     style:
  //                                                         AppTextStyle
  //                                                             .text12black0000W500,
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         CustomSizedBox(height: 14),
  //                                         Row(
  //                                           children: [
  //                                             Text(
  //                                               "pickup_time".tr,
  //                                               style:
  //                                                   AppTextStyle
  //                                                       .text14black0000W400,
  //                                             ),
  //                                             CustomSizedBox(width: 10),
  //                                             Text(
  //                                               acceptedRide
  //                                                       ?.tripSequence?[0]
  //                                                       .pickupTime ??
  //                                                   '',
  //                                               style:
  //                                                   AppTextStyle
  //                                                       .text16black0000W700,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         CustomSizedBox(height: 14),
  //                                         Row(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             ImageLoader.svgPictureAssetImage(
  //                                               width:
  //                                                   20 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                               height:
  //                                                   20 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                               imagePath:
  //                                                   ImagePath.locationIconGreen,
  //                                             ),
  //                                             CustomSizedBox(width: 10),
  //                                             SizedBox(
  //                                               width:
  //                                                   250 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                               child: Text(
  //                                                 "${acceptedRide?.tripSequence?[0].address} (Pickup)",
  //                                                 style:
  //                                                     AppTextStyle
  //                                                         .text14black0000W400,
  //                                                 maxLines: 2,
  //                                                 overflow:
  //                                                     TextOverflow.ellipsis,
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         CustomSizedBox(height: 10),
  //                                         Row(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             ImageLoader.svgPictureAssetImage(
  //                                               width:
  //                                                   20 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                               height:
  //                                                   20 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                               imagePath:
  //                                                   ImagePath.locationIconGreen,
  //                                             ),
  //                                             CustomSizedBox(width: 10),
  //                                             SizedBox(
  //                                               width:
  //                                                   250 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                               child: Text(
  //                                                 "${acceptedRide?.tripSequence?[1].address} (Dropoff)",
  //                                                 style:
  //                                                     AppTextStyle
  //                                                         .text14black0000W400,
  //                                                 maxLines: 2,
  //                                                 overflow:
  //                                                     TextOverflow.ellipsis,
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         CustomSizedBox(height: 10),
  //                                         GestureDetector(
  //                                           onTap: () {
  //                                             try {
  //                                               Utils.launchPhoneDialer(
  //                                                 acceptedRide
  //                                                         ?.tripSequence?[0]
  //                                                         .phoneNumber ??
  //                                                     '',
  //                                               );
  //                                             } catch (e) {}
  //                                           },
  //                                           child: Container(
  //                                             padding: EdgeInsets.symmetric(
  //                                               vertical:
  //                                                   5 *
  //                                                   SizeConfig
  //                                                       .heightMultiplier!,
  //                                               horizontal:
  //                                                   10 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                             ),
  //                                             decoration: BoxDecoration(
  //                                               borderRadius:
  //                                                   BorderRadius.circular(
  //                                                     8 *
  //                                                         SizeConfig
  //                                                             .widthMultiplier!,
  //                                                   ),
  //                                               border: Border.all(
  //                                                 color:
  //                                                     AppColors.kBlackTextColor,
  //                                                 width:
  //                                                     1 *
  //                                                     SizeConfig
  //                                                         .widthMultiplier!,
  //                                               ),
  //                                             ),
  //                                             child: Row(
  //                                               mainAxisSize: MainAxisSize.min,
  //                                               children: [
  //                                                 ImageLoader.svgPictureAssetImage(
  //                                                   imagePath:
  //                                                       ImagePath.phoneNumber,
  //                                                 ),
  //                                                 Text(
  //                                                   "${acceptedRide?.tripSequence?[0].countryCode} - ${acceptedRide?.tripSequence?[0].phoneNumber}",
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         CustomSizedBox(height: 10),
  //                                         Row(
  //                                           children: [
  //                                             ImageLoader.svgPictureAssetImage(
  //                                               imagePath: ImagePath.userIcon,
  //                                               color:
  //                                                   AppColors.kBlackTextColor,
  //                                             ),
  //                                             CustomSizedBox(width: 7),
  //                                             Text(
  //                                               acceptedRide
  //                                                       ?.tripSequence?[0]
  //                                                       .firstName ??
  //                                                   "",
  //                                               style:
  //                                                   AppTextStyle
  //                                                       .text14black0000W400,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         CustomSizedBox(height: 13),
  //                                         Row(
  //                                           children: [
  //                                             BlueButton(
  //                                               width:
  //                                                   150 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                               wantMargin: false,
  //                                               height:
  //                                                   40 *
  //                                                   SizeConfig
  //                                                       .heightMultiplier!,
  //                                               title: "Accept".tr,
  //                                               isLoading:
  //                                                   state
  //                                                       .driverMutateRideStatus
  //                                                       .isLoading,
  //                                               onTap: () async {
  //                                                 selectedRideIndex = index;
  //
  //                                                 bool? getValue =
  //                                                     await mutateHireDriverRides(
  //                                                       index:
  //                                                           selectedRideIndex ??
  //                                                           0,
  //                                                       bookedFor: "book_ride",
  //                                                       rideID:
  //                                                           acceptedRide
  //                                                               ?.rideId ??
  //                                                           '',
  //                                                       rideStatus:
  //                                                           RideStatus.accepted,
  //                                                       userDeviceToken:
  //                                                           acceptedRide
  //                                                               ?.user
  //                                                               ?.deviceToken ??
  //                                                           '',
  //                                                       userAmount:
  //                                                           acceptedRide
  //                                                               ?.payment
  //                                                               ?.amount ??
  //                                                           '',
  //                                                       userCurrency:
  //                                                           acceptedRide
  //                                                               ?.payment
  //                                                               ?.currency ??
  //                                                           '',
  //                                                       userMode:
  //                                                           acceptedRide
  //                                                               ?.payment
  //                                                               ?.mode ??
  //                                                           '',
  //                                                       userPaymentStatus:
  //                                                           acceptedRide
  //                                                               ?.payment
  //                                                               ?.status ??
  //                                                           '',
  //                                                       mutationReason: '',
  //                                                     );
  //
  //                                                 if (getValue == true) {
  //                                                   await getUpcomingOnTripRideData();
  //                                                 }
  //                                               },
  //                                             ),
  //                                             CustomSizedBox(width: 10),
  //                                             CustomOutlineButton(
  //                                               width:
  //                                                   130 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                               onTap: () async {
  //                                                 cancelRideNewRideConfirmationPop(
  //                                                   context: context,
  //                                                   bookedFor: "book_ride",
  //                                                   tripId:
  //                                                       acceptedRide?.tripId ??
  //                                                       '',
  //                                                   rateID:
  //                                                       acceptedRide
  //                                                           ?.price
  //                                                           ?.id ??
  //                                                       "",
  //                                                   rideId:
  //                                                       acceptedRide?.rideId ??
  //                                                       '',
  //                                                   rideStatus:
  //                                                       RideStatus.cancel,
  //                                                   userDeviceToken:
  //                                                       acceptedRide
  //                                                           ?.user
  //                                                           ?.deviceToken ??
  //                                                       '',
  //                                                   userAmount:
  //                                                       acceptedRide
  //                                                           ?.payment
  //                                                           ?.amount ??
  //                                                       '',
  //                                                   userCurrency:
  //                                                       acceptedRide
  //                                                           ?.payment
  //                                                           ?.currency ??
  //                                                       '',
  //                                                   userMode:
  //                                                       acceptedRide
  //                                                           ?.payment
  //                                                           ?.mode ??
  //                                                       '',
  //                                                   userPaymentStatus:
  //                                                       acceptedRide
  //                                                           ?.payment
  //                                                           ?.status ??
  //                                                       '',
  //                                                   mutationReason: '',
  //                                                 );
  //                                                 // await showDialog(
  //                                                 //     context: context,
  //                                                 //     builder: (BuildContext
  //                                                 //         context) {
  //                                                 //       return AlertDialog(
  //                                                 //         backgroundColor:
  //                                                 //             AppColors
  //                                                 //                 .kWhite,
  //                                                 //         titlePadding:
  //                                                 //             EdgeInsets
  //                                                 //                 .zero,
  //                                                 //         shape: RoundedRectangleBorder(
  //                                                 //             borderRadius:
  //                                                 //                 BorderRadius.circular(10 *
  //                                                 //                     SizeConfig
  //                                                 //                         .widthMultiplier!)),
  //                                                 //         title: Column(
  //                                                 //           crossAxisAlignment:
  //                                                 //               CrossAxisAlignment
  //                                                 //                   .start,
  //                                                 //           mainAxisSize:
  //                                                 //               MainAxisSize
  //                                                 //                   .min,
  //                                                 //           children: [
  //                                                 //             CustomSizedBox(
  //                                                 //                 height: 10 *
  //                                                 //                     SizeConfig
  //                                                 //                         .heightMultiplier!),
  //                                                 //             Padding(
  //                                                 //               padding: EdgeInsets.only(
  //                                                 //                   left: 16 *
  //                                                 //                       SizeConfig.widthMultiplier!),
  //                                                 //               child: Text(
  //                                                 //                 "Do_you_want_to_cancel_this_ride"
  //                                                 //                     .tr,
  //                                                 //                 style: AppTextStyle
  //                                                 //                     .text14Black0000W400,
  //                                                 //                 textAlign:
  //                                                 //                     TextAlign
  //                                                 //                         .start,
  //                                                 //               ),
  //                                                 //             ),
  //                                                 //             SizedBox(
  //                                                 //                 height: 10 *
  //                                                 //                     SizeConfig
  //                                                 //                         .heightMultiplier!),
  //                                                 //             Row(
  //                                                 //               mainAxisAlignment:
  //                                                 //                   MainAxisAlignment
  //                                                 //                       .spaceBetween,
  //                                                 //               children: [
  //                                                 //                 CustomOutlineButton(
  //                                                 //                   borderRadius:
  //                                                 //                       5 * SizeConfig.widthMultiplier!,
  //                                                 //                   width: 90 *
  //                                                 //                       SizeConfig.widthMultiplier!,
  //                                                 //                   height: 30 *
  //                                                 //                       SizeConfig.heightMultiplier!,
  //                                                 //                   borderColor:
  //                                                 //                       AppColors.kBlackTextColor,
  //                                                 //                   titleColor:
  //                                                 //                       AppColors.kBlackTextColor,
  //                                                 //                   title: "confirm"
  //                                                 //                       .tr,
  //                                                 //                   isLoading: state
  //                                                 //                       .cancelDriverMutateRideStatus
  //                                                 //                       .isLoading,
  //                                                 //                   buttonIsEnabled:
  //                                                 //                       acceptedRide?.cancelRide ==
  //                                                 //                           true,
  //                                                 //                   onTap:
  //                                                 //                       () async {
  //                                                 //                     bool? status = await canceMutateHireDriverRides(
  //                                                 //                         bookedFor: "book_ride",
  //                                                 //                         tripId: acceptedRide?.tripId ?? '',
  //                                                 //                         rateID: acceptedRide?.price?.id ?? "",
  //                                                 //                         rideID: acceptedRide?.rideId ?? '',
  //                                                 //                         rideStatus: RideStatus.cancel,
  //                                                 //                         userDeviceToken: acceptedRide?.user?.deviceToken ?? '',
  //                                                 //                         userAmount: acceptedRide?.payment?.amount ?? '',
  //                                                 //                         userCurrency: acceptedRide?.payment?.currency ?? '',
  //                                                 //                         userMode: acceptedRide?.payment?.mode ?? '',
  //                                                 //                         userPaymentStatus: acceptedRide?.payment?.status ?? '',
  //                                                 //                         mutationReason: '');
  //                                                 //                     if (status ==
  //                                                 //                         true) {
  //                                                 //                       await getUpcomingOnTripRideData();
  //                                                 //                       AnywhereDoor.pop(context);
  //                                                 //                     }
  //                                                 //                   },
  //                                                 //                 ),
  //                                                 //                 CustomOutlineButton(
  //                                                 //                   titleColor:
  //                                                 //                       AppColors.kRed1,
  //                                                 //                   borderColor:
  //                                                 //                       AppColors.kRed1,
  //                                                 //                   borderRadius:
  //                                                 //                       5 * SizeConfig.widthMultiplier!,
  //                                                 //                   width: 90 *
  //                                                 //                       SizeConfig.widthMultiplier!,
  //                                                 //                   height: 30 *
  //                                                 //                       SizeConfig.heightMultiplier!,
  //                                                 //                   title: "cancel"
  //                                                 //                       .tr,
  //                                                 //                   onTap:
  //                                                 //                       () {
  //                                                 //                     AnywhereDoor.pop(
  //                                                 //                         context);
  //                                                 //                   },
  //                                                 //                 ),
  //                                                 //               ],
  //                                                 //             ),
  //                                                 //             SizedBox(
  //                                                 //                 height: 20 *
  //                                                 //                     SizeConfig
  //                                                 //                         .heightMultiplier!),
  //                                                 //           ],
  //                                                 //         ),
  //                                                 //       );
  //                                                 //     });
  //                                               },
  //                                               wantMargin: false,
  //                                               titleColor:
  //                                                   AppColors.kBlackTextColor,
  //                                               borderColor:
  //                                                   AppColors.kGreen00996,
  //                                               height:
  //                                                   40 *
  //                                                   SizeConfig
  //                                                       .heightMultiplier!,
  //                                               borderRadius:
  //                                                   10 *
  //                                                   SizeConfig.widthMultiplier!,
  //                                               title: "cancel".tr,
  //                                               buttonIsEnabled:
  //                                                   acceptedRide?.cancelRide ==
  //                                                   true,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           );
  //                         }),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void cancelRideUpComingConfirmationPop({
    required BuildContext context,
    required String rideId,
    required String tripId,
    required String rateID,
    required RideStatus rideStatus,
    required String mutationReason,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    String? mode,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.only(
            top: 15 * SizeConfig.heightMultiplier!,
            bottom: 20 * SizeConfig.heightMultiplier!,
            left: 15 * SizeConfig.widthMultiplier!,
            right: 15 * SizeConfig.widthMultiplier!,
          ),
          backgroundColor: AppColors.kWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10 * SizeConfig.widthMultiplier!,
            ),
          ),
          title: SizedBox(
            width: 550 * SizeConfig.widthMultiplier!,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 38 * SizeConfig.widthMultiplier!,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Are you sure you want to \n cancel  this ride",
                        style: AppTextStyle.text16kBlue0D368CW7400,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.all(
                          8 * SizeConfig.widthMultiplier!,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kWhiteE5E5E5,
                          borderRadius: BorderRadius.circular(37),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            AnywhereDoor.pop(context);
                          },
                          child: ImageLoader.svgPictureAssetImage(
                            imagePath: ImagePath.closeIcon,
                            height: 10 * SizeConfig.heightMultiplier!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomSizedBox(height: 22),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12 * SizeConfig.widthMultiplier!,
                  ),
                  child: Row(
                    children: [
                      BlocBuilder<MainHomeCubit, MainHomeState>(
                        builder: (context, state) {
                          return BlueButton(
                            borderRadius: 12 * SizeConfig.widthMultiplier!,
                            height: 46 * SizeConfig.heightMultiplier!,
                            width: 120 * SizeConfig.widthMultiplier!,
                            wantMargin: false,
                            isLoading:
                                state.cancelDriverMutateRideStatus.isLoading,
                            title: "Yes",
                            onTap: () async {
                              bool? status = await canceMutateHireDriverRides(
                                bookedFor: "book_ride",
                                tripId: tripId,
                                rateID: rateID,
                                rideID: rideId ?? '',
                                rideStatus: RideStatus.cancel,
                                userDeviceToken: userDeviceToken ?? '',
                                userAmount: userAmount ?? '',
                                userCurrency: userCurrency ?? '',
                                userMode: userMode ?? '',
                                userPaymentStatus: userPaymentStatus ?? '',
                                mutationReason: '',
                              );
                              if (status == true) {
                                await getUpcomingOnTripRideData();
                                AnywhereDoor.pop(context);
                              }
                            },
                          );
                        },
                      ),
                      const Spacer(),
                      BlueButton(
                        textColor: AppColors.kBlackTextColor,
                        buttonColor: AppColors.kRedF3E6E6,
                        borderRadius: 12 * SizeConfig.widthMultiplier!,
                        height: 46 * SizeConfig.heightMultiplier!,
                        width: 120 * SizeConfig.widthMultiplier!,
                        wantMargin: false,
                        title: "No",
                        onTap: () async {
                          AnywhereDoor.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void cancelRideNewRideConfirmationPop({
    required BuildContext context,
    required String rideId,
    required String tripId,
    required String rateID,
    required RideStatus rideStatus,
    required String mutationReason,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    String? mode,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.only(
            top: 15 * SizeConfig.heightMultiplier!,
            bottom: 20 * SizeConfig.heightMultiplier!,
            left: 15 * SizeConfig.widthMultiplier!,
            right: 15 * SizeConfig.widthMultiplier!,
          ),
          backgroundColor: AppColors.kWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10 * SizeConfig.widthMultiplier!,
            ),
          ),
          title: SizedBox(
            width: 550 * SizeConfig.widthMultiplier!,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 38 * SizeConfig.widthMultiplier!,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Are you sure you want to \n cancel  this ride",
                        style: AppTextStyle.text16kBlue0D368CW7400,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.all(
                          8 * SizeConfig.widthMultiplier!,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kWhiteE5E5E5,
                          borderRadius: BorderRadius.circular(37),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            AnywhereDoor.pop(context);
                          },
                          child: ImageLoader.svgPictureAssetImage(
                            imagePath: ImagePath.closeIcon,
                            height: 10 * SizeConfig.heightMultiplier!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomSizedBox(height: 22),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12 * SizeConfig.widthMultiplier!,
                  ),
                  child: Row(
                    children: [
                      BlocBuilder<MainHomeCubit, MainHomeState>(
                        builder: (context, state) {
                          return BlueButton(
                            borderRadius: 12 * SizeConfig.widthMultiplier!,
                            height: 46 * SizeConfig.heightMultiplier!,
                            width: 120 * SizeConfig.widthMultiplier!,
                            wantMargin: false,
                            isLoading:
                                state.cancelDriverMutateRideStatus.isLoading,
                            title: "Yes",
                            onTap: () async {
                              bool? status = await canceMutateNewDriverRides(
                                bookedFor: "book_ride",
                                tripId: tripId,
                                rateID: rateID,
                                rideID: rideId ?? '',
                                rideStatus: RideStatus.cancel,
                                userDeviceToken: userDeviceToken ?? '',
                                userAmount: userAmount ?? '',
                                userCurrency: userCurrency ?? '',
                                userMode: userMode ?? '',
                                userPaymentStatus: userPaymentStatus ?? '',
                                mutationReason: '',
                              );
                              if (status == true) {
                                await getUpcomingOnTripRideData();
                                AnywhereDoor.pop(context);
                              }
                            },
                          );
                        },
                      ),
                      const Spacer(),
                      BlueButton(
                        textColor: AppColors.kBlackTextColor,
                        buttonColor: AppColors.kRedF3E6E6,
                        borderRadius: 12 * SizeConfig.widthMultiplier!,
                        height: 46 * SizeConfig.heightMultiplier!,
                        width: 120 * SizeConfig.widthMultiplier!,
                        wantMargin: false,
                        title: "No",
                        onTap: () async {
                          AnywhereDoor.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DraggableScrollableSheet showDocumentUploadBottomSheet() {
    DraggableScrollableController accountController =
        DraggableScrollableController();
    return DraggableScrollableSheet(
      controller: accountController,
      snap: false,
      minChildSize: 0.1,
      initialChildSize: 0.1,
      maxChildSize: 0.58,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlackTextColor.withOpacity(0.20),
                blurRadius: 4, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
              ),
            ],
            color: AppColors.kWhite,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10 * SizeConfig.widthMultiplier!),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSizedBox(height: 10),
                Center(
                  child: Container(
                    width: 63 * SizeConfig.widthMultiplier!,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50 * SizeConfig.widthMultiplier!,
                      ),
                      color: AppColors.kBlackTextColor.withOpacity(0.21),
                      border: Border.all(
                        color: AppColors.kBlackTextColor.withOpacity(0.21),
                        width: 2 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                  ),
                ),
                CustomSizedBox(height: 10),
                Center(
                  child: Text(
                    "Your account is not verified",
                    style: AppTextStyle.text18black0000W600,
                  ),
                ),
                CustomSizedBox(height: 2),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Complete your profile",
                        style: AppTextStyle.text12kRedF24141W300,
                      ),
                      Center(
                        child: Container(
                          width: 120 * SizeConfig.widthMultiplier!,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50 * SizeConfig.widthMultiplier!,
                            ),
                            color: AppColors.kRedF24141,
                            border: Border.all(
                              color: AppColors.kRedF24141,
                              width: 0.4 * SizeConfig.widthMultiplier!,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomSizedBox(height: 10),
                Center(
                  child: Text(
                    "Upload the following documents",
                    style: AppTextStyle.text12Bblack0000W500,
                  ),
                ),
                CustomSizedBox(height: 10),
                Wrap(
                  children: List.generate(
                    state.getUserProfileData?.data?.missingDocs?.length ?? 0,
                    (index) {
                      final getMissingDoc =
                          state.getUserProfileData?.data?.missingDocs?[index];
                      return GestureDetector(
                        onTap: () {
                          AnywhereDoor.pushNamed(
                            context,
                            routeName: RouteName.driverAccountScreen,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!,
                            right: 20 * SizeConfig.widthMultiplier!,
                            top: 15 * SizeConfig.heightMultiplier!,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              0.0 * SizeConfig.widthMultiplier!,
                            ),
                            color: AppColors.kBlueEFF6FF,
                            border: Border.all(
                              color: Colors.transparent,
                              width: 0.4 * SizeConfig.widthMultiplier!,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    getMissingDoc ?? "",
                                    style:
                                        AppTextStyle.text14kBlackTextColorW500,
                                  ),
                                  const Spacer(),
                                  ImageLoader.svgPictureAssetImage(
                                    imagePath: ImagePath.rightArrowIcon,
                                    color: AppColors.kBlackTextColor,
                                  ),
                                ],
                              ),
                              if (index <
                                  (state
                                          .getUserProfileData
                                          ?.data
                                          ?.missingDocs
                                          ?.length)! -
                                      1)
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10 * SizeConfig.heightMultiplier!,
                                  ),
                                  child: const Divider(),
                                ),
                              CustomSizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DraggableScrollableSheet showJoiningFeePendingBottomSheet() {
    DraggableScrollableController feeController =
        DraggableScrollableController();
    return DraggableScrollableSheet(
      controller: feeController,
      snap: false,
      minChildSize: 0.47,
      initialChildSize: 0.47,
      maxChildSize: 0.48,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlackTextColor.withOpacity(0.20),
                blurRadius: 4, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
              ),
            ],
            color: AppColors.kWhite,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10 * SizeConfig.widthMultiplier!),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    emit(state.copyWith(isOnTripBottomSheetIsOpen: false));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * SizeConfig.widthMultiplier!,
                      vertical: 10 * SizeConfig.heightMultiplier!,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(
                            8 * SizeConfig.widthMultiplier!,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kWhiteE5E5E5,
                            borderRadius: BorderRadius.circular(37),
                          ),
                          child: ImageLoader.svgPictureAssetImage(
                            imagePath: ImagePath.closeIcon,
                            height: 10 * SizeConfig.heightMultiplier!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Joining fee",
                    style: AppTextStyle.text32black0000W700,
                  ),
                ),
                CustomSizedBox(height: 16),
                Center(
                  child: Text(
                    "You have to pay one time joining fee to\nenjoy our services.",
                    style: AppTextStyle.text14kBlue092765W400?.copyWith(
                      color: AppColors.kBlue092765.withOpacity(0.70),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                CustomSizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("INR", style: AppTextStyle.text40kGreen84C4B0700),
                    CustomSizedBox(width: 10),
                    Text(
                      state.getUserProfileData?.data?.joiningFee?.amount
                              .toString() ??
                          "",
                      style: AppTextStyle.text40kkBlackTextColorW700,
                    ),
                  ],
                ),
                CustomSizedBox(height: 26),
                BlueButton(
                  height: 46 * SizeConfig.heightMultiplier!,
                  width: 350 * SizeConfig.widthMultiplier!,
                  title: "Join now",
                  onTap: () async {
                    // await UpiPayment(
                    //   ///Todo Uncomment after testing
                    //   // totalAmount: 1,
                    //   totalAmount: state
                    //           .getUserProfileData?.data?.joiningFee?.amount ??
                    //       0,
                    // ).startPgTransaction().then((value) async {
                    //   if (value?.success == true) {
                    //     final Map<String, dynamic> response =
                    //         await ApiClient()
                    //             .post(ApiRoutes.statusCreate, body: {
                    //       "payment_response": value ?? "",
                    //       "user_id": UserRepository.getUserID,
                    //       "lp_id": UserRepository.getLpID,
                    //       "feature": "joining-fee",
                    //       "user": AppNames.appName,
                    //       "create_iso_time": DateTime.now().toIso8601String(),
                    //       "create_utc_time":
                    //           DateTime.now().toUtc().toIso8601String(),
                    //       "payment_type": {
                    //         "mode":
                    //             value?.data?.paymentInstrument?.type ?? "",
                    //         "status": "paid",
                    //         // "amount": 1,
                    //         "amount": state
                    //             .getUserProfileData?.data?.joiningFee?.amount
                    //             .toString(),
                    //         "currency": "INR",
                    //       },
                    //       "reason": "as joining fee",
                    //     });
                    //     if (response['status'] == "success") {
                    //       await getUserData();
                    //       emit(
                    //         state.copyWith(
                    //           joiningFeePaydone: true,
                    //         ),
                    //       );
                    //     }
                    //   }
                    // });
                    ;
                  },
                ),
                CustomSizedBox(height: 16),
                Center(
                  child: Text(
                    "By joining, you agree to the Terms of Service and Privacy Policy.",
                    style: AppTextStyle.text11kBlue0D368CW7400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DraggableScrollableSheet showJoiningDoneBottomSheet() {
    DraggableScrollableController feeController =
        DraggableScrollableController();
    return DraggableScrollableSheet(
      controller: feeController,
      snap: false,
      minChildSize: 0.33,
      initialChildSize: 0.33,
      maxChildSize: 0.34,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20 * SizeConfig.widthMultiplier!),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSizedBox(height: 30),
                Center(
                  child: Text(
                    "Congratulations",
                    style: AppTextStyle.text32black0000W700,
                  ),
                ),
                CustomSizedBox(height: 16),
                Center(
                  child: Text(
                    "You are now a Premium member of our\napplication.Enjoy our seamless services.",
                    style: AppTextStyle.text14kBlue092765W400?.copyWith(
                      color: AppColors.kBlue092765.withOpacity(0.70),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                CustomSizedBox(height: 26),
                BlueButton(
                  height: 46 * SizeConfig.heightMultiplier!,
                  width: 350 * SizeConfig.widthMultiplier!,
                  title: "Continue",
                  onTap: () async {
                    emit(state.copyWith(joiningFeePaydone: false));

                    await getUserData();
                  },
                ),
                CustomSizedBox(height: 16),
                Center(
                  child: Text(
                    "By joining, you agree to the Terms of Service and Privacy Policy.",
                    style: AppTextStyle.text11kBlue0D368CW7400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DraggableScrollableSheet showUploadDocumentStatusBottomSheet() {
    DraggableScrollableController accountPendingController =
        DraggableScrollableController();
    return DraggableScrollableSheet(
      controller: accountPendingController,
      snap: false,
      minChildSize: 0.3,
      initialChildSize: 0.3,
      maxChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlackTextColor.withOpacity(0.20),
                blurRadius: 4, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
              ),
            ],
            color: AppColors.kWhite,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10 * SizeConfig.widthMultiplier!),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSizedBox(height: 20),
                Center(
                  child: Container(
                    width: 63 * SizeConfig.widthMultiplier!,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50 * SizeConfig.widthMultiplier!,
                      ),
                      color: AppColors.kBlackTextColor.withOpacity(0.21),
                      border: Border.all(
                        color: AppColors.kBlackTextColor.withOpacity(0.21),
                        width: 2 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                  ),
                ),
                CustomSizedBox(height: 10),
                Center(
                  child: Text(
                    "Your account is under verification",
                    style: AppTextStyle.text18black0000W600,
                  ),
                ),
                CustomSizedBox(height: 2),
                Center(
                  child: ImageLoader.assetImage(
                    imagePath: ImagePath.docLoader,
                    height: 80 * SizeConfig.heightMultiplier!,
                    width: 80 * SizeConfig.widthMultiplier!,
                  ),
                ),
                CustomSizedBox(height: 14),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "This might take upto 24 hours",
                        style: AppTextStyle.text12kRedF24141W300,
                      ),
                    ],
                  ),
                ),
                CustomSizedBox(height: 14),
                GestureDetector(
                  onTap: () {
                    AnywhereDoor.pushNamed(
                      context,
                      routeName: RouteName.helpScreen,
                    );
                  },
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Chat with help team",
                          style: AppTextStyle.text12black0000W600,
                        ),
                        Container(
                          width: 110 * SizeConfig.widthMultiplier!,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50 * SizeConfig.widthMultiplier!,
                            ),
                            color: AppColors.kRedF24141,
                            border: Border.all(
                              color: AppColors.kBlackTextColor,
                              width: 0.4 * SizeConfig.widthMultiplier!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DraggableScrollableSheet showHomeScreenNoBookingBottomSheet() {
    DraggableScrollableController guestController =
        DraggableScrollableController();
    return DraggableScrollableSheet(
      controller: guestController,
      snap: false,
      minChildSize: 0.12,
      initialChildSize: 0.12,
      maxChildSize: 0.13,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlackTextColor.withOpacity(0.20),
                blurRadius: 4, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
              ),
            ],
            color: AppColors.kWhite,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10 * SizeConfig.widthMultiplier!),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(width: 50),
                    const Spacer(),
                    Center(
                      child: Container(
                        width: 63 * SizeConfig.widthMultiplier!,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50 * SizeConfig.widthMultiplier!,
                          ),
                          color: AppColors.kGreyContColor.withOpacity(0.21),
                          border: Border.all(
                            color: AppColors.kBlackTextColor.withOpacity(0.21),
                            width: 2 * SizeConfig.widthMultiplier!,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await getUpcomingOnTripRideData();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ImageLoader.svgPictureAssetImage(
                            imagePath: ImagePath.refereshIcon,
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(width: 20),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Rides",
                      style: AppTextStyle.text18black0000W600?.copyWith(
                        color: AppColors.kBlack272727,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DraggableScrollableSheet showAddOrSelectVehicleBottomSheet() {
    DraggableScrollableController guestController =
        DraggableScrollableController();
    return DraggableScrollableSheet(
      controller: guestController,
      snap: false,
      minChildSize: 0.223,
      initialChildSize: 0.223,
      maxChildSize: 0.223,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlackTextColor.withOpacity(0.20),
                blurRadius: 4, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
              ),
            ],
            color: AppColors.kWhite,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10 * SizeConfig.widthMultiplier!),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSizedBox(height: 10),
                Center(
                  child: Container(
                    width: 63 * SizeConfig.widthMultiplier!,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50 * SizeConfig.widthMultiplier!,
                      ),
                      color: AppColors.kGreyContColor.withOpacity(0.21),
                      border: Border.all(
                        color: AppColors.kBlackTextColor.withOpacity(0.21),
                        width: 2 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                  ),
                ),
                CustomSizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    AnywhereDoor.pushNamed(
                      context,
                      routeName: RouteName.addVehicleScreen,
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomSizedBox(width: 14),
                      ImageLoader.svgPictureAssetImage(
                        imagePath: ImagePath.plusIconWithBorder,
                      ),
                      CustomSizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Add Vehicle",
                            style: AppTextStyle.text14Black0000W600,
                          ),
                          Text(
                            "I have my own vehicle which to be used for work.",
                            style: AppTextStyle.text12kBlack2A2A2AW400
                                ?.copyWith(
                                  color: AppColors.kBlack2A2A2A.withOpacity(
                                    0.62,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomSizedBox(height: 7),
                Divider(
                  indent: 55 * SizeConfig.widthMultiplier!,
                  endIndent: 50 * SizeConfig.widthMultiplier!,
                ),
                CustomSizedBox(height: 19),
                GestureDetector(
                  onTap: () {
                    AnywhereDoor.pushNamed(
                      context,
                      routeName: RouteName.selectVehicleScreen,
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomSizedBox(width: 14),
                      ImageLoader.svgPictureAssetImage(
                        imagePath: ImagePath.selectCarWithBorder,
                      ),
                      CustomSizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Select Vehicle",
                            style: AppTextStyle.text14Black0000W600,
                          ),
                          Text(
                            "I need a vehicle which to be used for work.",
                            style: AppTextStyle.text12kBlack2A2A2AW400
                                ?.copyWith(
                                  color: AppColors.kBlack2A2A2A.withOpacity(
                                    0.62,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DraggableScrollableSheet showAccountBlockedBottomSheet() {
    DraggableScrollableController guestController =
        DraggableScrollableController();
    return DraggableScrollableSheet(
      controller: guestController,
      snap: false,
      minChildSize: 0.3,
      initialChildSize: 0.3,
      maxChildSize: 0.31,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlackTextColor.withOpacity(0.20),
                blurRadius: 4, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
              ),
            ],
            color: AppColors.kWhite,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10 * SizeConfig.widthMultiplier!),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSizedBox(height: 16),
                ImageLoader.svgPictureAssetImage(
                  imagePath: ImagePath.blockedAccount,
                ),
                CustomSizedBox(height: 15),
                Text(
                  "Account Blocked",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.text16black0000W600?.copyWith(
                    color: AppColors.kBlue0D368C,
                  ),
                ),
                CustomSizedBox(height: 14),
                Text(
                  "Your account has been block by the Agency, contact \nagency for more information.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.text12black0000W300?.copyWith(
                    color: AppColors.kBlue0D368C,
                  ),
                ),
                CustomSizedBox(height: 20),
                BlueButton(
                  title: "Contact Travel Agency",
                  onTap: () {
                    AnywhereDoor.pushNamed(
                      context,
                      routeName: RouteName.helpScreen,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
