import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:travelx_driver/home/models/app_version_res.dart';
import 'package:travelx_driver/home/models/distance_matrix_model.dart';
import 'package:travelx_driver/home/models/driver_status.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/home/models/post_userdata_params.dart';
import 'package:travelx_driver/home/models/promotion_model.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart'
    as ride_model;
import 'package:travelx_driver/home/models/trip_metrix_model.dart';
import 'package:travelx_driver/home/repository/home_repository.dart';
import 'package:travelx_driver/home/screen/ride.dart';
import 'package:travelx_driver/home/widget/cancel_trip_dialog/cancel_trip_dialog.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/api_client/api_exception.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';

import '../../shared/local_storage/log_in_status.dart';
import '../../shared/local_storage/user_repository.dart';
import '../../user/account/enitity/profile_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  bool _isRiderAvailable = false;
  bool mutateRideLoading = false;
  DriverStatus driverStatus = DriverStatus.online;
  bool isManualSearchLoading = false;
  Timer? _currentLocationTimer;
  GetDriverStatus? getDriverStatus;
  RideStatus rideStatus = RideStatus.none;
  int? status;
  String? getLpId;
  String? getUserId;
  String? deviceId;
  String? vehicleType;
  String? firstName;
  String? countryCode;
  String? phoneNumber;

  List<AgencyList>? agencyList;

  void emitState(HomeState state) {
    emit(state);
  }

  Future<void> updateRiderAvailabilityStatus({
    required bool availabilityStatus,
  }) async {
    try {
      emit(RiderToggleLoadingState());
      final response = await HomeRepository.toggleDriverStatus(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        onlineStatus: availabilityStatus,
        deviceToken: UserRepository.getDeviceToken ?? "",
        phoneNumber: UserRepository.getPhoneNumber ?? "",
        user: AppNames.appName,
        rideStatus: true,
      );
      if (response.isNotEmpty) {
        if (response['status'] == 'success') {
          _isRiderAvailable = availabilityStatus;
          if (_isRiderAvailable == true) {
            driverStatus = DriverStatus.online;
          } else {
            driverStatus = DriverStatus.offline;
          }

          emit(UpdateRiderAvailability(isRiderAvailable: _isRiderAvailable));
        } else {
          emit(UpdateRiderAvailability(isRiderAvailable: true));
        }
      }
    } catch (e) {
      emit(UpdateRiderAvailability(isRiderAvailable: true));
    }
  }

  Future<void> updateUserDetails({
    required String profile,
    required bool availabilityStatus,
  }) async {
    try {
      final response = await HomeRepository.toggleDriverDetails(
        phoneNumber: UserRepository.getPhoneNumber ?? "",
        rideStatus: profile == 'ride' ? true : false,
        deliveryStatus: profile == 'delivery' ? true : false,
        onlineStatus: availabilityStatus,
      );
      if (response['status'] == 'success') {
        emit(SuccessUpdateProfile(message: response['data'].toString()));
      }
    } on ApiException catch (e) {
      emit(FailureUpdateProfile(errorMessage: e.errorMessage ?? ""));
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void selectRide(int selectedRideIndex) {
    emit(GetSelectedRide(selectedRideIndex: selectedRideIndex));
  }

  Future<void> fetchRide(String rideId, bool isActingDriverRide) async {
    try {
      emit(GotRideSuccess([]));
      emit(RidesLoading());
      String actingDriverRide;

      if (isActingDriverRide) {
        actingDriverRide = "true";
      } else {
        actingDriverRide =
            ProfileRepository.getActingDriver?.toLowerCase() ?? "";
      }
      final currentPosition = await Utils.getCurrentLocation();
      final response = await HomeRepository.fetchRide(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        countryCode: UserRepository.getCountryCode ?? "",
        currentPosition: currentPosition,
        unit: "kms",
        url: ApiRoutes.getRide,
        vehicleType: ProfileRepository.getVehicleModel?.toLowerCase() ?? "",
        accountStatus: ProfileRepository.getAccountStatus ?? "",
        rideId: rideId,
        actingDriverRide: actingDriverRide,
      );
      if (response['status'] == "success") {
        // final rides = List<acting_driver.ActingRide>.from(
        //     response['data'].map((x) => acting_driver.ActingRide.fromJson(x)));
        final rides = ride_model.rideFromJson(response['data']);

        if (rides.isNotEmpty) {
          // AnywhereDoor.pushNamed(navigatorKey.currentContext!,
          //     routeName: RouteName.homeScreen,
          //     arguments: NewHomeScreen(activeRide: rides.firstOrNull));
          AnywhereDoor.pushNamed(
            navigatorKey.currentContext!,
            routeName: RouteName.rideScreen,
            arguments: RidesScreen(rides: rides),
          );
        } else {
          emit(RidesEmptyData());
        }
      }
    } on ApiException catch (e) {
      emit(GotRidesFailure(e.message));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> emitEnableButton() async {
    emit(ConfirmButtonEnable(isEnable: true));
  }

  Future<void> fetchRides() async {
    try {
      emit(GotRideSuccess([]));
      emit(RidesLoading());
      final currentPosition = await Utils.getCurrentLocation();
      final response = await HomeRepository.fetchRides(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        countryCode: UserRepository.getCountryCode ?? "",
        currentPosition: currentPosition,
        searchRadius: 100,
        unit: "miles",
        profile: UserRepository.getProfile ?? "",
        accountStatus: ProfileRepository.getAccountStatus ?? "",
        url: ApiRoutes.getRides,
        vechileType: ProfileRepository.getVehicleModel?.toLowerCase() ?? "",
      );

      if (response['status'] == "success") {
        final rides = ride_model.rideFromJson(response['data']);

        if (rides.isNotEmpty) {
          AnywhereDoor.pushNamed(
            navigatorKey.currentContext!,
            routeName: RouteName.rideScreen,
            arguments: RidesScreen(rides: rides),
          );
        } else {
          emit(RidesEmptyData());
        }
      }
    } on ApiException catch (e) {
      emit(GotRidesFailure(e.message));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchManualRides({
    String? searchRadius,
    String? rideType,
    String? vehicleType,
    required String feature,
  }) async {
    try {
      emit(ManualRidesLoadingData());
      final currentPosition = await Utils.getCurrentLocation();
      final response = await HomeRepository.fetchManualRides(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: 'travelsx-driver',
        countryCode: UserRepository.getCountryCode ?? "",
        currentPosition: currentPosition,
        searchRadius: int.tryParse(searchRadius ?? "100") ?? 100,
        unit: "miles",
        profile: UserRepository.getProfile ?? "",
        accountStatus: ProfileRepository.getAccountStatus ?? "",
        url: ApiRoutes.getManualRides,
        vechileType: vehicleType ?? "",
        rideType: rideType ?? "",
        feature: feature,
      );

      if (response['status'] == "success") {
        final manualRide = ride_model.rideFromJson(response['data']);

        if (manualRide.isNotEmpty == true) {
          emit(GotManualRideSuccess(manualRide));
        } else {
          emit(ManualRidesEmptyData());
        }
      }
    } catch (e) {
      emit(ManualGotRidesFailure("Something went wrong"));
    }
  }

  Future<void> fetchAutoAssignedRides({
    String? searchRadius,
    String? rideType,
  }) async {
    try {
      final currentPosition = await Utils.getCurrentLocation();
      final response = await HomeRepository.fetchManualRides(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: 'travelsx-driver',
        countryCode: UserRepository.getCountryCode ?? "",
        currentPosition: currentPosition,
        searchRadius: int.tryParse(searchRadius ?? "100") ?? 100,
        unit: "miles",
        profile: UserRepository.getProfile ?? "",
        accountStatus: ProfileRepository.getAccountStatus ?? "",
        url: ApiRoutes.getManualRides,
        vechileType: ProfileRepository.getVehicleModel?.toLowerCase() ?? "",
        rideType: rideType ?? "",
        feature: "book_ride",
      );
      if (response['status'] == "success") {
        final rides = ride_model.rideFromJson(response['data']);
        if (rides.isNotEmpty) {
          AnywhereDoor.pushNamed(
            navigatorKey.currentContext!,
            routeName: RouteName.rideScreen,
            arguments: RidesScreen(rides: rides),
          );
        } else {
          emit(RidesEmptyData());
        }
      }
    } catch (e) {
      emit(ManualGotRidesFailure("Something went wrong"));
    }
  }

  Future<void> getPromotions() async {
    try {
      emit(PromotionsLoading());
      final currentPosition = await Utils.getCurrentLocation();
      final response = await HomeRepository.getPromotionsData(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        currentPosition: currentPosition,
        offSet: 0,
        limit: 20,
      );
      if (response['status'] == "success") {
        final promotions = PromotionModel.fromJson(response);
        if (promotions.data != null) {
          emit(PromotionsSuccess(promotions));
        }
      }
    } on ApiException catch (e) {
      emit(PromotionsFailure(e.message));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchTripMetrics() async {
    emit(TripMetricsLoading());
    try {
      final response = await HomeRepository.getTripsMetrics(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
      );

      if (response['status'] == "success") {
        final tripMetrics = TripMetrics.fromJson(response);

        if (tripMetrics.data != null) {
          emit(TripMetricsSuccess(tripMetrics));
        }
      }
    } on ApiException catch (e) {
      emit(TripMetricsFailure(e.message));
    }
  }

  Future<void> getId() async {
    LogInStatus logInStatus = LogInStatus();

    getLpId = await logInStatus.getDriverLpId();
    getUserId = await logInStatus.getUserID();
    firstName = await logInStatus.getUserProfileFirstName();
    countryCode = await logInStatus.getCountryCode();
    phoneNumber = await logInStatus.getUserPhoneNumber();
    agencyList = await logInStatus.getAgencyList();

    vehicleType = await logInStatus.getUserVehicleModel();

    deviceId = await logInStatus.getDeviceTokenDetails();
  }

  Future<void> initiateCurrentLocationTimer({int? onTripStatus}) async {
    if (_currentLocationTimer?.isActive ?? false) {
      _currentLocationTimer?.cancel();
    }
    _currentLocationTimer = Timer.periodic(const Duration(minutes: 10), (
      _,
    ) async {
      await postUserCurrentLocation();
    });
  }

  Future<void> postUserCurrentLocation({
    int? userStatus,
    String? source,
  }) async {
    await getId();
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final currentLocation = await Utils.getCurrentLocation();
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      String osName = Platform.operatingSystem;
      Device device;
      DriverPosition currentPosition = DriverPosition(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      );

      if (driverStatus == DriverStatus.onTrip) {
        status = 2;
      } else if (driverStatus == DriverStatus.online) {
        status = 1;
      } else if (driverStatus == DriverStatus.offline) {
        status = 0;
      }

      User user = User(
        userId: int.parse(getUserId ?? ""),
        name: UserRepository.getFirstName,
        countryCode: UserRepository.getCountryCode,
        phoneNumber: UserRepository.getPhoneNumber,
        userStatus: userStatus ?? status,
        position: currentPosition,
      );

      if (deviceInfo is AndroidDeviceInfo) {
        device = Device(
          name: deviceInfo.model,
          os: 'Android',
          osVersion: deviceInfo.version.release,
        );
      } else if (deviceInfo is IosDeviceInfo) {
        device = Device(
          name: deviceInfo.name ?? "",
          os: 'iOS',
          osVersion: deviceInfo.systemVersion ?? "",
        );
      } else {
        // Handle other device types or provide a default value
        device = Device(name: 'Unknown', os: 'Unknown', osVersion: "0");
      }

      App app = App(name: packageInfo.appName, version: packageInfo.version);

      PostUserDataParams params = PostUserDataParams(
        lpId: int.parse(getLpId ?? ""),
        user: user,
        source: source ?? "",
        deviceToken: deviceId,
        device: device,
        app: app,
        vehicleType: vehicleType,
        createIsoTime: DateTime.now().toIso8601String(),
      );
      final response = await HomeRepository.postUserData(params);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getRidesFullRoute({
    required String deliveryId,
    required int selectedRideIndex,
    required DriverPosition driverPosition,
  }) async {
    try {
      emit(GetRidesFullRouteLoading());

      final response = await HomeRepository.getTripFullRoute(
        url: ApiRoutes.getRidesFullRoute,
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        deliveryId: deliveryId,
        position: driverPosition,
      );
      String? routePath;
      if (response['data'].isNotEmpty) {
        List data = response['data'];
        routePath =
            data.firstWhere(
              (element) => element['type'] == 'full_route',
            )['route_path'];
      }
      emit(
        GetRidesFullRouteSuccess(
          routePath: routePath ?? '',
          selectedRideIndex: selectedRideIndex,
        ),
      );
    } on DioError catch (e) {
      emit(GetRidesFullRouteFailed());
    } catch (e) {
      emit(GetRidesFullRouteFailed());
    }
  }

  Future<bool?> mutateRides({
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
  }) async {
    emit(MutateOnTripsLoading());
    try {
      if (rideStatus == RideStatus.ontrip) {
        driverStatus = DriverStatus.onTrip;
      }

      ride_model.User rideUser = ride_model.User(
        deviceToken: userDeviceToken ?? "",
      );

      ride_model.Payment payment = ride_model.Payment(
        amount: userAmount,
        mode: userMode,
        status: userPaymentStatus,
        currency: userCurrency,
      );

      final currentLocation = await Utils.getCurrentLocation();
      final response = await HomeRepository.mutateRideStatus(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: AppNames.appName,
        firstName: ProfileRepository.getFirstName ?? '',
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        position: DriverPosition(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        ),
        deviceToken: UserRepository.getDeviceToken ?? '',
        vehicleModel: ProfileRepository.getVehicleModel ?? '',
        vehicleName: ProfileRepository.getVehicleName ?? '',
        vehicleNumber: ProfileRepository.getVehicleNumber ?? '',
        rideID: rideID,
        rideStatus: rideStatus.getRideStatusString,
        mutationReason: mutationReason,
        userData: rideUser,
        payment: payment,
        bookedFor: bookedFor,
      );

      if (response['status'] == "error") {
        emit(AcceptedByOtherDriver());
      } else {
        if (rideStatus == RideStatus.cancel) {
          driverStatus = DriverStatus.online;
        } else if (rideStatus == RideStatus.delivered) {
          driverStatus = DriverStatus.online;
        } else if (rideStatus == RideStatus.declined) {
          driverStatus = DriverStatus.online;
        } else {
          driverStatus = DriverStatus.onTrip;
        }

        await postUserCurrentLocation();

        log(jsonEncode(response));
        if (rideStatus == RideStatus.ontrip) {
          emit(MutateOnTripsSuccess());
        } else {
          emit(MutateRideSuccess(rideStatus));
        }
        return true;
      }
    } catch (e) {
      emit(MutateRideFailure());
    }
  }

  Future<void> mutateHireDriverRides({
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
  }) async {
    emit(MutateOnHireTripsLoading());
    try {
      if (rideStatus == RideStatus.ontrip) {
        driverStatus = DriverStatus.onTrip;
      }

      ride_model.User rideUser = ride_model.User(
        deviceToken: userDeviceToken ?? "",
      );

      ride_model.Payment payment = ride_model.Payment(
        amount: userAmount,
        mode: userMode,
        status: userPaymentStatus,
        currency: userCurrency,
      );

      final currentLocation = await Utils.getCurrentLocation();
      final response = await HomeRepository.mutateRideStatus(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: AppNames.appName,
        firstName: ProfileRepository.getFirstName ?? '',
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
        bookedFor: bookedFor,
      );

      if (response['status'] == "error") {
        emit(AcceptedHireByOtherDriver());
      } else {
        if (rideStatus == RideStatus.cancel) {
          driverStatus = DriverStatus.online;
        } else if (rideStatus == RideStatus.delivered) {
          driverStatus = DriverStatus.online;
        } else if (rideStatus == RideStatus.declined) {
          driverStatus = DriverStatus.online;
        } else {
          driverStatus = DriverStatus.onTrip;
        }

        await postUserCurrentLocation();

        log(jsonEncode(response));
        if (rideStatus == RideStatus.ontrip) {
          emit(MutateOnHireTripsSuccess());
        } else {
          emit(MutateHireRideSuccess(rideStatus));
        }
      }
    } catch (e) {
      emit(MutateHireRideFailure());
    }
  }

  void showCancelRideDialog(
    BuildContext context, {
    required String tripId,
    required String rideID,
    required String rateID,
    required RideStatus rideStatus,
    required Function() onSubmit,
    required Function() onCancel,
  }) {
    //pauseResumeRideTimer(true);

    CustomBottomSheet().customBottomSheet(
      context: context,
      onSubmit: (cancelReason) async {
        final bool? result = await mutateRides(
          tripId: tripId,
          rideID: rideID,
          rateID: rateID,
          rideStatus: rideStatus,
          mutationReason: cancelReason ?? "",
        );

        if (result == true) {
          onSubmit();
        }

        // pauseResumeRideTimer(false);
      },
      onCancel: () {
        // pauseResumeRideTimer(false);
        onCancel();
      },
    );
  }

  /// Retrieves upcoming and ongoing rides for the current driver.
  ///
  /// Handles both API-specific exceptions (ApiException) and general exceptions.
  // Future<UpcomingOntripRideRes?> getUpcomingAndOntripRide() async {
  //   try {
  //     // Fetch data from the repository
  //     final response = await HomeRepository.getUpcomingOnTripRideData(
  //       lpId: UserRepository.getLpID ?? '',
  //       userId: UserRepository.getUserID ?? '',
  //       user: 'travelsx-driver',
  //     );
  //
  //     // Ensure the 'data' key exists in the response
  //     if (!response.containsKey('data')) {
  //       throw FormatException('Invalid response format: Missing "data" key');
  //     }
  //
  //     // Parse and return the response data
  //     final upcomingOntripRideRes =
  //         UpcomingOntripRideRes.fromJson(response['data']);
  //     return upcomingOntripRideRes;
  //   } on ApiException catch (e) {
  //     // Handle API exceptions (e.g., network errors, authorization issues)
  //     log('ApiException: ${e.message}'); // Log error details for debugging
  //   } on FormatException catch (e) {
  //     // Handle cases where the response format is unexpected
  //     log('FormatException: ${e.message}');
  //   } catch (e) {
  //     // Handle any other unexpected exceptions
  //     log('Unexpected error: ${e.toString()}');
  //   }
  //
  //   // Return null if an error occurred
  //   return null;
  // }

  Future<void> getDistanceMatrix({
    required bool onRoute,
    required DriverPosition sourceLatLng,
    required DriverPosition destinationLatLng,
  }) async {
    try {
      final response = await HomeRepository.getDistanceMetrix(
        onRoute: onRoute,
        sourceLatLng: sourceLatLng,
        destinationLatLng: destinationLatLng,
      );
      final distanceMatrix = DistanceMatrix.fromJson(response['data']);
      emit(GetDistanceMatrixSuccess(distanceMatrix: distanceMatrix));
    } on ApiException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateDriverRate({
    required RideType rideType,
    required String baseDistance,
    required String baseRate,
    required String perUnitRate,
  }) async {
    try {
      emit(DriverBlocLoading());
      final response = await HomeRepository.updateDriverRate(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        countryCode: UserRepository.getCountryCode ?? "",
        rideType: rideType.getRideTypeString,
        vehicleType: '',
        baseDistance: baseDistance,
        baseRate: baseRate,
        perUnitRate: perUnitRate,
        currency: 'INR',
      );

      if (response['status'] == 'success') {
        emit(DriverBlocSuccess(message: response['message']));
      }
    } on ApiException catch (e) {
      emit(DriverBlocFailure());
    }
  }
}
