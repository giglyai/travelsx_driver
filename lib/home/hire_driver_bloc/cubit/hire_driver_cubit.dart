import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/config/phone_pay/phone_pay_payment.dart';
import 'package:travelx_driver/home/hire_driver_bloc/entity/accepted_hire_ride.dart';
import 'package:travelx_driver/home/hire_driver_bloc/entity/get_final_ride_details.dart';
import 'package:travelx_driver/home/hire_driver_bloc/entity/upcoming_ontrip_ride_res.dart'
    as upComing;
import 'package:travelx_driver/home/hire_driver_bloc/repository/hire_driver_repository.dart';
import 'package:travelx_driver/home/hire_driver_bloc/screen/hire_driver_direction_screen.dart';
import 'package:travelx_driver/home/models/distance_matrix_model.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart'
    as ride_model;
import 'package:travelx_driver/home/widget/container_with_border/container_with_border.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/api_client/api_exception.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/pin_field.dart';
import 'package:travelx_driver/shared/widgets/usable_address_row/usable_address_row.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';

class HireState extends Equatable {
  final ApiStatus driverApiStatus;
  final List<upComing.UpcomingRide>? acceptedHireRides;
  final DistanceMatrix? distanceMatrix;
  final GetFinalRideFullDetails? getFinalRideFullDetails;
  final ApiStatus? distanceMatrixStatus;
  final ApiStatus? driverMutateRideStatus;
  final ApiStatus? cancelDriverMutateRideStatus;
  final List<ride_model.Ride> actingDriverRides;
  final ApiStatus actingDriverRideApiStatus;
  final ApiStatus upComingRideApiStatus;
  final upComing.UpcomingOntripRideRes? upComingRideData;
  final RideStatus? onGoingRideStatus;
  String? manualRideMessage;
  String? errorOtpMessage;

  final RideStatus rideStatus;
  final FieldState<TextEditingController> otp;

  HireState({
    required this.driverApiStatus,
    this.acceptedHireRides,
    required this.rideStatus,
    this.distanceMatrix,
    this.distanceMatrixStatus,
    this.driverMutateRideStatus,
    this.cancelDriverMutateRideStatus,
    required this.actingDriverRides,
    required this.actingDriverRideApiStatus,
    required this.upComingRideApiStatus,
    this.upComingRideData,
    this.onGoingRideStatus,
    this.manualRideMessage,
    this.getFinalRideFullDetails,
    this.errorOtpMessage,
    required this.otp,
  });

  static HireState init() => HireState(
        driverApiStatus: ApiStatus.init,
        acceptedHireRides: const [],
        rideStatus: RideStatus.none,
        distanceMatrix:
            DistanceMatrix(duration: '', distance: '', routePath: ''),
        distanceMatrixStatus: ApiStatus.init,
        driverMutateRideStatus: ApiStatus.init,
        cancelDriverMutateRideStatus: ApiStatus.init,
        actingDriverRides: const [],
        actingDriverRideApiStatus: ApiStatus.init,
        upComingRideApiStatus: ApiStatus.init,
        upComingRideData: upComing.UpcomingOntripRideRes(),
        onGoingRideStatus: null,
        manualRideMessage: "",
        errorOtpMessage: "",
        getFinalRideFullDetails: GetFinalRideFullDetails(),
        otp: FieldState.initial(value: TextEditingController()),
      );

  HireState copyWith({
    ApiStatus? driverApiStatus,
    List<upComing.UpcomingRide>? acceptedHireRides,
    RideStatus? rideStatus,
    DistanceMatrix? distanceMatrix,
    ApiStatus? distanceMatrixStatus,
    ApiStatus? driverMutateRideStatus,
    ApiStatus? cancelDriverMutateRideStatus,
    List<ride_model.Ride>? actingDriverRides,
    ApiStatus? actingDriverRideApiStatus,
    ApiStatus? upComingRideApiStatus,
    upComing.UpcomingOntripRideRes? upComingRideData,
    RideStatus? onGoingRideStatus,
    String? manualRideMessage,
    String? errorOtpMessage,
    GetFinalRideFullDetails? getFinalRideFullDetails,
    FieldState<TextEditingController>? otp,
  }) {
    return HireState(
      driverApiStatus: driverApiStatus ?? this.driverApiStatus,
      onGoingRideStatus: onGoingRideStatus ?? this.onGoingRideStatus,
      acceptedHireRides: acceptedHireRides ?? this.acceptedHireRides,
      rideStatus: rideStatus ?? this.rideStatus,
      distanceMatrix: distanceMatrix ?? this.distanceMatrix,
      distanceMatrixStatus: distanceMatrixStatus ?? this.distanceMatrixStatus,
      driverMutateRideStatus:
          driverMutateRideStatus ?? this.driverMutateRideStatus,
      cancelDriverMutateRideStatus:
          cancelDriverMutateRideStatus ?? this.cancelDriverMutateRideStatus,
      actingDriverRides: actingDriverRides ?? this.actingDriverRides,
      actingDriverRideApiStatus:
          actingDriverRideApiStatus ?? this.actingDriverRideApiStatus,
      upComingRideApiStatus:
          upComingRideApiStatus ?? this.upComingRideApiStatus,
      upComingRideData: upComingRideData ?? this.upComingRideData,
      manualRideMessage: manualRideMessage ?? this.manualRideMessage,
      errorOtpMessage: errorOtpMessage ?? this.errorOtpMessage,
      getFinalRideFullDetails:
          getFinalRideFullDetails ?? this.getFinalRideFullDetails,
      otp: otp ?? this.otp,
    );
  }

  @override
  List<Object?> get props => [
        driverApiStatus,
        acceptedHireRides,
        rideStatus,
        distanceMatrix,
        distanceMatrixStatus,
        driverMutateRideStatus,
        cancelDriverMutateRideStatus,
        actingDriverRides,
        actingDriverRideApiStatus,
        upComingRideApiStatus,
        upComingRideData,
        onGoingRideStatus,
        manualRideMessage,
        getFinalRideFullDetails,
        otp,
        errorOtpMessage,
      ];
}

class HireDriverCubit extends Cubit<HireState> {
  HireDriverCubit() : super(HireState.init());

  void changeErrorMessage({String? value}) {
    emit(state.copyWith(errorOtpMessage: value));
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
    bool isFromHomeScreen = false,
  }) async {
    try {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.loading,
        ),
      );
      User rideUser = User(deviceToken: userDeviceToken ?? "");
      Payment payment = Payment(
          amount: userAmount,
          mode: userMode,
          status: userPaymentStatus,
          currency: userCurrency);

      final currentLocation = await Utils.getCurrentLocation();
      final response = await HireRepository.hireDriverMutateRide(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: "driver-ride",
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        position: DriverPosition(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude),
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
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.failure,
          ),
        );
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
        if (isFromHomeScreen == true) {
          // getUpcomingOnTripRideData();
          goToRideStatusRoute(state.rideStatus, index!);
          final rides =
              List<upComing.UpcomingRide>.from(state.acceptedHireRides ?? []);
          rides.removeWhere((element) => element.rideId == rideID);
          emit(
            state.copyWith(
              acceptedHireRides: rides,
            ),
          );
        }

        return true;
      }
    } catch (e) {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.failure,
        ),
      );
    }
  }

  Future<bool?> mutateAcceptRides({
    required String rideID,
    required RideStatus rideStatus,
    required String mutationReason,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    int? index,
    bool isFromHomeScreen = false,
    DriverRideType? isRideOrDriver = DriverRideType.ride,
    ride_model.RideCommn? rideCommn,
  }) async {
    try {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.loading,
        ),
      );

      User rideUser = User(deviceToken: userDeviceToken ?? "");
      Payment payment = Payment(
          amount: userAmount,
          mode: userMode,
          status: userPaymentStatus,
          currency: userCurrency);

      final currentLocation = await Utils.getCurrentLocation();
      final response = await HireRepository.acceptDriverMutateRide(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: "driver-ride",
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        position: DriverPosition(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude),
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
        rideCommn: rideCommn,
      );

      if (response['status'] == "error") {
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.failure,
          ),
        );
        rideAcceptedByOtherDriver(
          context: navigatorKey.currentState!.context,
          message: response['message'],
        );
      } else {
        // await postUserCurrentLocation();
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.success,
            rideStatus: rideStatus,
          ),
        );
        return true;
      }
    } catch (e) {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.failure,
        ),
      );
    }
  }

  Future<bool?> onGoingTripMutateRide({
    required String rideID,
    required String mutationReason,
    String? userDeviceToken,
    String? countyCode,
    String? phoneNumber,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    String? mode,
    int? startDist,
    int? endDist,
    int? index,
    bool isFromHomeScreen = false,
    DriverRideType? isRideOrDriver = DriverRideType.ride,
    bool? isFromFinalBottomsheet,
  }) async {
    final status = state.onGoingRideStatus;
    final nextStatus = RideStatus.fromString(status.toValue);

    try {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.loading,
        ),
      );

      User rideUser = User(deviceToken: userDeviceToken ?? "");
      Payment payment = Payment(
        amount: userAmount,
        mode: userMode,
        status: userPaymentStatus,
        currency: userCurrency,
      );
      final currentLocation = await Utils.getCurrentLocation();
      final response = await HireRepository.hireDriverMutateRide(
        startDist: startDist ?? 0,
        endDist: endDist ?? 0,
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: AppNames.appName,
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        position: DriverPosition(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude),
        deviceToken: UserRepository.getDeviceToken ?? '',
        rideID: rideID,
        rideStatus: isFromFinalBottomsheet == true
            ? RideStatus.delivered.getRideStatusString
            : nextStatus.getRideStatusString,
        mutationReason: mutationReason,
        firstName: ProfileRepository.getFirstName ?? '',
        vehicleModel: ProfileRepository.getVehicleModel ?? '',
        vehicleName: ProfileRepository.getVehicleName ?? '',
        vehicleNumber: ProfileRepository.getVehicleNumber ?? '',
        userData: rideUser,
        payment: payment,
      );

      if (response['status'] == 'success') {
        if (response['message'] == "Trip STARTED successfully") {
          showVerifyOtp(
              rideID: rideID ?? "",
              startDist: startDist ?? 0,
              endDist: endDist ?? 0,
              userAmount: userAmount,
              userCurrency: userCurrency,
              userDeviceToken: userDeviceToken,
              userMode: userMode,
              userPaymentStatus: userPaymentStatus);
        } else if (isFromFinalBottomsheet == true) {
          emit(
            state.copyWith(
              driverMutateRideStatus: ApiStatus.success,
            ),
          );
        } else {
          emit(
            state.copyWith(
              driverMutateRideStatus: ApiStatus.success,
              onGoingRideStatus: nextStatus,
            ),
          );
        }

        return true;
      } else {
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.failure,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.failure,
        ),
      );
    }
  }

  Future<bool?> completedMutateRide({
    required String rideID,
    required String mutationReason,
    String? userDeviceToken,
    String? countyCode,
    String? phoneNumber,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    String? mode,
    int? startDist,
    int? endDist,
    int? index,
    bool isFromHomeScreen = false,
    DriverRideType? isRideOrDriver = DriverRideType.ride,
    bool? isFromFinalBottomsheet,
  }) async {
    try {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.loading,
        ),
      );

      User rideUser = User(deviceToken: userDeviceToken ?? "");
      Payment payment = Payment(
        amount: userAmount,
        mode: userMode,
        status: userPaymentStatus,
        currency: userCurrency,
      );
      final currentLocation = await Utils.getCurrentLocation();
      final response = await HireRepository.hireDriverMutateRide(
        startDist: startDist ?? 0,
        endDist: endDist ?? 0,
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: AppNames.appName,
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        position: DriverPosition(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude),
        deviceToken: UserRepository.getDeviceToken ?? '',
        rideID: rideID,
        rideStatus: RideStatus.delivered.getRideStatusString,
        mutationReason: mutationReason,
        firstName: ProfileRepository.getFirstName ?? '',
        vehicleModel: ProfileRepository.getVehicleModel ?? '',
        vehicleName: ProfileRepository.getVehicleName ?? '',
        vehicleNumber: ProfileRepository.getVehicleNumber ?? '',
        userData: rideUser,
        payment: payment,
      );

      if (response['status'] == 'success') {
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.success,
          ),
        );
        return true;
      } else {
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.failure,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.failure,
        ),
      );
    }
  }

  bool get isOTPTypeValid {
    final isOTPTypeValid = state.otp.value.text.trim().isNotEmpty;

    if (isOTPTypeValid == true) {
      emit(
        state.copyWith(
          otp: state.otp.copyWith(errorColor: AppColors.kredDF0000),
        ),
      );
    } else {
      emit(
        state.copyWith(
          otp: state.otp.copyWith(errorColor: AppColors.kBlue3D6),
        ),
      );
    }

    return isOTPTypeValid;
  }

  showVerifyOtp({
    required String rideID,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    int? startDist,
    int? endDist,
  }) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.black.withOpacity(0.7),
        context: navigatorKey.currentState!.context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
            return PopScope(
              canPop: true,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(15 * SizeConfig.widthMultiplier!),
                          topRight: Radius.circular(
                              15 * SizeConfig.widthMultiplier!))),
                  height: 240 * SizeConfig.heightMultiplier!,
                  child: BlocBuilder<HireDriverCubit, HireState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomSizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30 * SizeConfig.widthMultiplier!),
                                child: Text(
                                  'Verify OTP',
                                  style: AppTextStyle.text20black0000W600,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  AnywhereDoor.pushNamed(context,
                                      routeName: RouteName.helpScreen);
                                },
                                child: Container(
                                  width: 101 * SizeConfig.widthMultiplier!,
                                  height: 32 * SizeConfig.heightMultiplier!,
                                  decoration: BoxDecoration(
                                    color: AppColors.kWhite,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.15),
                                        blurRadius: 3, // soften the shadow
                                        spreadRadius: 1.0, //extend the shadow
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        42 * SizeConfig.widthMultiplier!),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Help",
                                        style: AppTextStyle.text16black0000W400,
                                      ),
                                      CustomSizedBox(
                                        width: 4,
                                      ),
                                      ImageLoader.svgPictureAssetImage(
                                          imagePath: ImagePath.helpIcon),
                                    ],
                                  ),
                                ),
                              ),
                              CustomSizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          CustomSizedBox(
                            height: 23,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20 * SizeConfig.widthMultiplier!),
                            child: CustomPinTextField(
                              pinController: state.otp.value,
                              obscureText: false,
                              wantPadding: true,
                              fontSize: 30 * SizeConfig.textMultiplier!,
                              fieldHeight: 60 * SizeConfig.heightMultiplier!,
                              fieldWidth: 60 * SizeConfig.widthMultiplier!,
                              onCompleted: (v) async {
                                isOTPTypeValid;
                                bool? get = await verifyRideOtp(
                                  otp: int.tryParse(v) ?? 0,
                                  rideID: rideID,
                                  userDeviceToken: userDeviceToken,
                                  userAmount: userAmount,
                                  userCurrency: userCurrency,
                                  userMode: userMode,
                                  userPaymentStatus: userPaymentStatus,
                                );
                                if (get == false) {
                                  setState1(() {
                                    v = "";
                                    changeErrorMessage(value: "Try Again");
                                    state.otp.value.clear();
                                  });
                                }
                                // await travelVerifyVehicleOtp();
                              },
                              pinMaxLength: 4,
                            ),
                          ),
                          if (state.errorOtpMessage?.isNotEmpty == true)
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 30 * SizeConfig.widthMultiplier!),
                              child: Text(state.errorOtpMessage ?? "",
                                  style: AppTextStyle.text12kRedF24141W300),
                            ),
                          CustomSizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30 * SizeConfig.widthMultiplier!),
                            child: Text(
                              "We have sent a otp to the passenger .",
                              style: AppTextStyle.text12black0000W400?.copyWith(
                                color: AppColors.kTransparent.withOpacity(.40),
                              ),
                            ),
                          ),
                          // CustomSizedBox(
                          //   height: 20,
                          // ),
                          // BlueButton(
                          //   isLoading: state.driverMutateRideStatus.isLoading,
                          //   buttonIsEnabled: isOTPTypeValid,
                          //   onTap: () async {
                          //
                          //   },
                          // ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          });
        });
  }

  Future<bool?> verifyRideOtp({
    required String rideID,
    required int otp,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    int? startDist,
    int? endDist,
  }) async {
    try {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.loading,
        ),
      );
      User rideUser = User(deviceToken: userDeviceToken ?? "");
      Payment payment = Payment(
        amount: userAmount,
        mode: userMode,
        status: userPaymentStatus,
        currency: userCurrency,
      );
      final currentLocation = await Utils.getCurrentLocation();
      final response = await HireRepository.verifyRideOtp(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        rideID: rideID,
        otp: otp,
        startDist: startDist ?? 0,
        endDist: endDist ?? 0,
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        position: DriverPosition(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude),
        deviceToken: UserRepository.getDeviceToken ?? '',
        mutationReason: "",
        firstName: ProfileRepository.getFirstName ?? '',
        vehicleModel: ProfileRepository.getVehicleModel ?? '',
        vehicleName: ProfileRepository.getVehicleName ?? '',
        vehicleNumber: ProfileRepository.getVehicleNumber ?? '',
        userData: rideUser,
        payment: payment,
      );

      if (response['status'] == "success") {
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.success,
            onGoingRideStatus: RideStatus.arrivedAtPickup,
          ),
        );
        AnywhereDoor.pop(navigatorKey.currentState!.context);
        return true;
      } else if (response['status'] == "error") {
        flushData();
        isOTPTypeValid;
        changeErrorMessage(value: response['data']);
        emit(
          state.copyWith(
            errorOtpMessage: response['data'],
            otp: FieldState.initial(value: TextEditingController(text: "")),
          ),
        );

        return false;
      }
    } catch (e) {
      isOTPTypeValid;
      emit(
        state.copyWith(
          otp: FieldState.initial(value: TextEditingController()),
          errorOtpMessage: "Try Again",
          driverMutateRideStatus: ApiStatus.failure,
        ),
      );
    }
  }

  flushData() {
    emit(
      state.copyWith(
        errorOtpMessage: "",
        otp: FieldState.initial(value: TextEditingController()),
      ),
    );
  }

  Future<bool?> startMeterPost({
    required String rideID,
    required String mutationReason,
    int? startDist,
  }) async {
    // final status = state.onGoingRideStatus;
    // final nextStatus = RideStatus.fromString(status.toValue);

    try {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.loading,
        ),
      );
      final response = await HireRepository.startMeterPost(
        startDist: startDist ?? 0,
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        rideID: rideID,
        startTime: DateTime.now().toIso8601String(),
      );

      if (response['status'] == "error") {
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.failure,
          ),
        );
      } else {
        // await postUserCurrentLocation();
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.success,
            // onGoingRideStatus: nextStatus,
          ),
        );
        return true;
      }
    } catch (e) {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.failure,
        ),
      );
    }
  }

  Future<bool?> endMeterPost({
    required String rideID,
    required String mutationReason,
    int? endDist,
  }) async {
    // final status = state.onGoingRideStatus;
    // final nextStatus = RideStatus.fromString(status.toValue);

    try {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.loading,
        ),
      );
      final response = await HireRepository.endMeterPost(
        endDist: endDist ?? 0,
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        rideID: rideID,
        endTime: DateTime.now().toIso8601String(),
      );

      if (response['status'] == "error") {
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.failure,
          ),
        );
      } else {
        // await postUserCurrentLocation();
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.success,
            // onGoingRideStatus: nextStatus,
          ),
        );
        return true;
      }
    } catch (e) {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.failure,
        ),
      );
    }
  }

  Future<bool?> getFinalRideDetails({
    required String rideID,
    required String mutationReason,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    String? mode,
  }) async {
    // final status = state.onGoingRideStatus;
    // final nextStatus = RideStatus.fromString(status.toValue);
    try {
      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.loading,
        ),
      );
      final response = await HireRepository.getRideFinalDetails(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        rideID: rideID,
      );
      if (response['status'] == "error") {
        updateRideStatus(RideStatus.pickedUp);

        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.failure,
          ),
        );
      } else {
        // await postUserCurrentLocation();
        final getFinalRideFullDetails =
            GetFinalRideFullDetails.fromJson(response);
        emit(
          state.copyWith(
            driverMutateRideStatus: ApiStatus.success,
            // onGoingRideStatus: nextStatus,
          ),
        );
        await showFinalDetailsBottomSheet(
          getFinalRideFullDetails: getFinalRideFullDetails,
          mutationReason: '',
          userDeviceToken: userDeviceToken,
          userAmount: userAmount,
          userCurrency: userCurrency,
          userMode: userMode,
          userPaymentStatus: userPaymentStatus,
          rideID: rideID,
        );
        return true;
      }
    } catch (e) {
      updateRideStatus(RideStatus.pickedUp);

      emit(
        state.copyWith(
          driverMutateRideStatus: ApiStatus.failure,
        ),
      );
    }
  }

  void updateRideStatus(RideStatus status) {
    emit(state.copyWith(onGoingRideStatus: status));
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
      emit(
        state.copyWith(
          cancelDriverMutateRideStatus: ApiStatus.loading,
        ),
      );

      User rideUser = User(deviceToken: userDeviceToken ?? "");
      Payment payment = Payment(
          amount: userAmount,
          mode: userMode,
          status: userPaymentStatus,
          currency: userCurrency);

      final currentLocation = await Utils.getCurrentLocation();
      final response = await HireRepository.hireDriverMutateRide(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: "driver-ride",
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        position: DriverPosition(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude),
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
        final rides =
            List<upComing.UpcomingRide>.from(state.acceptedHireRides ?? []);

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
      emit(
        state.copyWith(
          cancelDriverMutateRideStatus: ApiStatus.failure,
        ),
      );
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
            ride: state.upComingRideData?.data?.ontripRide?.firstOrNull ??
                upComing.OntripRide.fromJson(state
                        .upComingRideData?.data?.upcomingRide?[index]
                        .toJson() ??
                    {}),
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

  Future<void> getDistanceMatrix({
    required bool onRoute,
    required DriverPosition sourceLatLng,
    required DriverPosition destinationLatLng,
  }) async {
    try {
      final response = await HireRepository.getDistanceMetrix(
        onRoute: onRoute,
        sourceLatLng: sourceLatLng,
        destinationLatLng: destinationLatLng,
      );
      final distanceMatrix = DistanceMatrix.fromJson(response['data']);

      emit(
        state.copyWith(
            distanceMatrixStatus: ApiStatus.success,
            distanceMatrix: distanceMatrix),
      );
    } on ApiException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getUpcomingOnTripRideData() async {
    try {
      emit(
        state.copyWith(
          upComingRideApiStatus: ApiStatus.loading,
        ),
      );
      final response = await HireRepository.getUpcomingOnTripRideData(
        lpId: UserRepository.getLpID ?? '',
        userId: UserRepository.getUserID ?? '',
        user: 'driver-ride',
      );
      final upcomingOntripRideRes =
          upComing.UpcomingOntripRideRes.fromJson(response);

      if (upcomingOntripRideRes.data?.upcomingRide?.isNotEmpty == true &&
          upcomingOntripRideRes.data?.ontripRide?.isEmpty == true) {
        emit(
          state.copyWith(
            upComingRideApiStatus: ApiStatus.success,
            upComingRideData: upcomingOntripRideRes,
          ),
        );
      } else if (upcomingOntripRideRes.data?.ontripRide?.isNotEmpty == true) {
        Navigator.pushReplacementNamed(
          navigatorKey.currentState!.context,
          arguments: HireDriverRideDirectionsScreenParams(
            ride: upcomingOntripRideRes.data!.ontripRide![0],
          ),
          RouteName.hireDriverRideDirectionsScreen,
        );
      } else {
        emit(
          state.copyWith(
            upComingRideApiStatus: ApiStatus.success,
            upComingRideData: upcomingOntripRideRes,
          ),
        );
      }
    } on ApiException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchManualRides(
      {String? searchRadius, String? rideType, required String feature}) async {
    try {
      emit(
        state.copyWith(
          actingDriverRideApiStatus: ApiStatus.loading,
        ),
      );
      final currentPosition = await Utils.getCurrentLocation();
      final response = await HireRepository.fetchManualRides(
          accountStatus: ProfileRepository.getAccountStatus ?? "",
          lpId: UserRepository.getLpID ?? "",
          userId: UserRepository.getUserID ?? "",
          user: 'driver-ride',
          countryCode: UserRepository.getCountryCode ?? "",
          currentPosition: currentPosition,
          searchRadius: int.tryParse(searchRadius ?? "100") ?? 100,
          unit: "miles",
          profile: UserRepository.getProfile ?? "",
          url: ApiRoutes.getManualRides,
          vechileType: ProfileRepository.getVehicleModel ?? "",
          rideType: rideType ?? "",
          feature: feature);
      if (response['status'] == "success") {
        final getDataValue = (response['data']);
        if (getDataValue is String) {
          emit(
            state.copyWith(
              actingDriverRideApiStatus: ApiStatus.empty,
              manualRideMessage: getDataValue,
            ),
          );
        } else {
          final manualRide = ride_model.rideFromJson(response['data']);
          if (manualRide.isNotEmpty == true) {
            emit(
              state.copyWith(
                  actingDriverRideApiStatus: ApiStatus.success,
                  actingDriverRides: manualRide),
            );
          } else {
            emit(
              state.copyWith(
                actingDriverRideApiStatus: ApiStatus.empty,
                manualRideMessage: "No ride available at this moment",
              ),
            );
          }
        }
      }
    } catch (e) {
      print("yaaaaaaaar${e.toString()}");
      state.copyWith(
        actingDriverRideApiStatus: ApiStatus.failure,
      );
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
                            Expanded(
                              child: Text(
                                message ?? "something went wrong..",
                                style: AppTextStyle.text16kWhiteW600,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            CustomSizedBox(
                              width: 16,
                            ),
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
        });
  }

  showAddMoneyBottomSheet(
      {required int totalAmount,
      required int walletAmount,
      required String desc,
      required String radiusManualRide,
      required String rideType,
      required String feature}) async {
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
              builder: (BuildContext context, StateSetter setState1) {
            return PopScope(
              canPop: false,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(15 * SizeConfig.widthMultiplier!),
                          topRight: Radius.circular(
                              15 * SizeConfig.widthMultiplier!))),
                  height: 330 * SizeConfig.heightMultiplier!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AnywhereDoor.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20 * SizeConfig.widthMultiplier!,
                              vertical: 10 * SizeConfig.heightMultiplier!),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                    8 * SizeConfig.widthMultiplier!),
                                decoration: BoxDecoration(
                                    color: AppColors.kWhiteE5E5E5,
                                    borderRadius: BorderRadius.circular(37)),
                                child: ImageLoader.svgPictureAssetImage(
                                    imagePath: ImagePath.closeIcon,
                                    height: 10 * SizeConfig.heightMultiplier!),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "wallets".tr,
                          style: TextStyle(
                            color: AppColors.kBlackTextColor.withOpacity(0.70),
                            fontSize: 20 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20 * SizeConfig.heightMultiplier!,
                      ),
                      Center(
                        child: Text(
                          "your_balance".tr,
                          style: TextStyle(
                            color: AppColors.kBlackTextColor.withOpacity(0.60),
                            fontSize: 16 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "inr".tr,
                            style: AppTextStyle.text40kGreen84C4B0700,
                          ),
                          CustomSizedBox(
                            width: 10,
                          ),
                          Text(
                            walletAmount.toString(),
                            style: AppTextStyle.text40kkBlackTextColorW700,
                          ),
                        ],
                      ),
                      CustomSizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10 * SizeConfig.widthMultiplier!,
                            vertical: 6 * SizeConfig.widthMultiplier!),
                        decoration: BoxDecoration(
                            color: AppColors.kWhiteF8F8F8,
                            borderRadius: BorderRadius.circular(
                                8 * SizeConfig.widthMultiplier!)),
                        child: Text(
                          desc,
                          style: AppTextStyle.text16black0000W400,
                        ),
                      ),
                      const Spacer(),
                      CustomSizedBox(
                        height: 10,
                      ),
                      BlueButton(
                        title: "add_money".tr,
                        onTap: () async {
                          // await UpiPayment(
                          //   ///Todo Uncomment after testing
                          //   totalAmount: totalAmount,
                          //   // totalAmount: 1,
                          // ).startPgTransaction().then((value) async {
                          //   if (value?.success == true) {
                          //     final Map<String, dynamic> response =
                          //         await ApiClient()
                          //             .post(ApiRoutes.statusCreate, body: {
                          //       "payment_response": value ?? "",
                          //       "user_id": UserRepository.getUserID,
                          //       "lp_id": UserRepository.getLpID,
                          //       "feature": "credit-money",
                          //       "user": "driver-ride",
                          //       "reason": "new ride",
                          //       "create_iso_time":
                          //           DateTime.now().toIso8601String(),
                          //       "create_utc_time":
                          //           DateTime.now().toUtc().toIso8601String(),
                          //       "payment_type": {
                          //         "mode":
                          //             value?.data?.paymentInstrument?.type ??
                          //                 "",
                          //         "status": "paid",
                          //         "amount": totalAmount,
                          //         "currency": "INR"
                          //       }
                          //     });
                          //     if (response['status'] == "success") {
                          //       fetchManualRides(
                          //           searchRadius: radiusManualRide,
                          //           rideType: rideType,
                          //           feature: feature);
                          //       AnywhereDoor.pop(context);
                          //     }
                          //   } else {
                          //     fetchManualRides(
                          //         searchRadius: radiusManualRide,
                          //         rideType: rideType,
                          //         feature: feature);
                          //     AnywhereDoor.pop(context);
                          //   }
                          //});
                          ;
                        },
                      ),
                      CustomSizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  showEnterMeterBottomSheet({
    required bool onRoute,
    required DriverPosition sourceLatLng,
    required DriverPosition destinationLatLng,
    required String rideID,
    required String mutationReason,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    String? mode,
    int? index,
    bool isFromHomeScreen = false,
    DriverRideType? isRideOrDriver = DriverRideType.ride,
  }) async {
    TextEditingController startDist = TextEditingController();
    await showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.black.withOpacity(0.7),
        context: navigatorKey.currentState!.context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
            return PopScope(
              canPop: false,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(15 * SizeConfig.widthMultiplier!),
                          topRight: Radius.circular(
                              15 * SizeConfig.widthMultiplier!))),
                  height: 250 * SizeConfig.heightMultiplier!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomSizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20 * SizeConfig.widthMultiplier!),
                              child: Text(
                                "Enter your meter number",
                                style: AppTextStyle.text16black0000W600
                                    ?.copyWith(color: AppColors.kBlue0D368C),
                              ),
                            ),
                            CustomSizedBox(
                              width: 5,
                            ),
                            ContainerWithBorder(
                              containerColor: AppColors.kGreyF0F0F0,
                              child: Text(
                                "Start Point",
                                style: AppTextStyle.text10black0000500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!),
                        child: Text(
                          "Enter Meter number for calculating the distance",
                          style: AppTextStyle.text12black0000W300,
                        ),
                      ),
                      CustomSizedBox(
                        height: 14,
                      ),
                      CustomTextFromField(
                        controller: startDist,
                        hintText: "Enter meter number",
                        keyboardType: TextInputType.number,
                        hintTextStyle: AppTextStyle.text24Bblack0000W600
                            ?.copyWith(
                                color: AppColors.kBlackTextColor
                                    .withOpacity(0.40)),
                        textStyle: AppTextStyle.text30kBlackTextColorW700
                            .copyWith(letterSpacing: 1),
                        topPadding: 30 * SizeConfig.heightMultiplier!,
                        margin: EdgeInsets.symmetric(
                            horizontal: 20 * SizeConfig.widthMultiplier!),
                      ),
                      CustomSizedBox(
                        height: 12,
                      ),
                      BlocBuilder<HireDriverCubit, HireState>(
                        builder: (context, state) {
                          return BlueButton(
                            isLoading: state.driverMutateRideStatus.isLoading,
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              final isSuccess = await startMeterPost(
                                mutationReason: '',
                                rideID: rideID,
                                startDist: int.tryParse(startDist.text),
                              );
                              if (isSuccess == true) {
                                await getDistanceMatrix(
                                    onRoute: false,
                                    sourceLatLng: sourceLatLng,
                                    destinationLatLng: destinationLatLng);
                                // updateRideStatus(RideStatus.arrivedAtPickup);
                                // await onGoingTripMutateRide(
                                //   mutationReason: '',
                                //   userDeviceToken: userDeviceToken,
                                //   userAmount: userAmount,
                                //   userCurrency: userCurrency,
                                //   userMode: userMode,
                                //   userPaymentStatus: userPaymentStatus,
                                //   rideID: rideID,
                                // );
                                AnywhereDoor.pop(context);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  showEnterReachedMeterBottomSheet({
    required bool onRoute,
    required DriverPosition sourceLatLng,
    required DriverPosition destinationLatLng,
    required String rideID,
    required String mutationReason,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    String? mode,
    int? index,
    bool isFromHomeScreen = false,
    DriverRideType? isRideOrDriver = DriverRideType.ride,
  }) async {
    TextEditingController endDist = TextEditingController();
    await showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.black.withOpacity(0.7),
        context: navigatorKey.currentState!.context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
            return PopScope(
              canPop: false,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(15 * SizeConfig.widthMultiplier!),
                          topRight: Radius.circular(
                              15 * SizeConfig.widthMultiplier!))),
                  height: 250 * SizeConfig.heightMultiplier!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomSizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Enter your meter number",
                              style: AppTextStyle.text16black0000W600
                                  ?.copyWith(color: AppColors.kBlue0D368C),
                            ),
                            CustomSizedBox(
                              width: 5,
                            ),
                            ContainerWithBorder(
                              containerColor: AppColors.kGreyF0F0F0,
                              child: Text(
                                "Start Point",
                                style: AppTextStyle.text10black0000500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!),
                        child: Text(
                          "Enter Meter number for calculating the distance",
                          style: AppTextStyle.text12black0000W300,
                        ),
                      ),
                      CustomSizedBox(
                        height: 14,
                      ),
                      CustomTextFromField(
                        controller: endDist,
                        hintText: "Enter meter number",
                        keyboardType: TextInputType.number,
                        hintTextStyle: AppTextStyle.text24Bblack0000W600
                            ?.copyWith(
                                color: AppColors.kBlackTextColor
                                    .withOpacity(0.40)),
                        textStyle: AppTextStyle.text30kBlackTextColorW700
                            .copyWith(letterSpacing: 1),
                        topPadding: 30 * SizeConfig.heightMultiplier!,
                        margin: EdgeInsets.symmetric(
                            horizontal: 20 * SizeConfig.widthMultiplier!),
                      ),
                      CustomSizedBox(
                        height: 12,
                      ),
                      BlocBuilder<HireDriverCubit, HireState>(
                        builder: (context, state) {
                          return BlueButton(
                            isLoading: state.driverMutateRideStatus.isLoading,
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              final isSuccess = await endMeterPost(
                                mutationReason: '',
                                rideID: rideID,
                                endDist: int.tryParse(endDist.text),
                              );
                              if (isSuccess == true) {
                                // updateRideStatus(RideStatus.arrivedAtPickup);
                                // await onGoingTripMutateRide(
                                //   mutationReason: '',
                                //   userDeviceToken: userDeviceToken,
                                //   userAmount: userAmount,
                                //   userCurrency: userCurrency,
                                //   userMode: userMode,
                                //   userPaymentStatus: userPaymentStatus,
                                //   rideID: rideID,
                                // );
                                AnywhereDoor.pop(context);
                                await getFinalRideDetails(
                                  rideID: rideID,
                                  mutationReason: '',
                                  userDeviceToken: userDeviceToken,
                                  userAmount: userAmount,
                                  userCurrency: userCurrency,
                                  userMode: userMode,
                                  userPaymentStatus: userPaymentStatus,
                                );
                              } else {
                                updateRideStatus(RideStatus.pickedUp);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  showFinalDetailsBottomSheet({
    GetFinalRideFullDetails? getFinalRideFullDetails,
    required String rideID,
    required String mutationReason,
    String? userDeviceToken,
    String? userAmount,
    String? userCurrency,
    String? userMode,
    String? userPaymentStatus,
    String? bookedFor,
    String? mode,
  }) async {
    bool isLoading = false;
    await showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: Colors.black.withOpacity(0.7),
        enableDrag: false,
        context: navigatorKey.currentState!.context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
            return PopScope(
              canPop: false,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(15 * SizeConfig.widthMultiplier!),
                          topRight: Radius.circular(
                              15 * SizeConfig.widthMultiplier!))),
                  height: 470 * SizeConfig.heightMultiplier!,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14 * SizeConfig.widthMultiplier!),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomSizedBox(
                          height: 14,
                        ),
                        Center(
                          child: ContainerWithBorder(
                            borderRadius: 12 * SizeConfig.widthMultiplier!,
                            wantPadding: true,
                            borderColor: AppColors.kBlue3D6,
                            borderWidth: 1 * SizeConfig.widthMultiplier!,
                            containerColor: AppColors.kBlueF4F3FF,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 8.0 * SizeConfig.heightMultiplier!,
                                  bottom: 8 * SizeConfig.heightMultiplier!,
                                  left: 20 * SizeConfig.widthMultiplier!,
                                  right: 20 * SizeConfig.widthMultiplier!),
                              child: Text(
                                "Collect Payment",
                                style: AppTextStyle.text16black0000W600
                                    ?.copyWith(color: AppColors.kBlack272727),
                              ),
                            ),
                          ),
                        ),
                        CustomSizedBox(
                            height: 14 * SizeConfig.heightMultiplier!),
                        Text(
                          getFinalRideFullDetails?.data?.totalTime ?? "",
                          style: AppTextStyle.text14Black0000W600,
                        ),
                        CustomSizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text(
                              "${getFinalRideFullDetails?.data?.name ?? ""} will pay",
                              style: AppTextStyle.text14black0000W500,
                            ),
                            const Spacer(),
                            Text(
                              "${getFinalRideFullDetails?.data?.totalFee ?? ""} ${getFinalRideFullDetails?.data?.currency ?? ""}",
                              style: AppTextStyle.text16black0000W600,
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            ImageLoader.svgPictureAssetImage(
                                imagePath: ImagePath.rideUser),
                            CustomSizedBox(
                              width: 10,
                            ),
                            Text(
                              getFinalRideFullDetails?.data?.name ?? "",
                              style: AppTextStyle.text14black0000W500,
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            ImageLoader.svgPictureAssetImage(
                                imagePath: ImagePath.rideTotalDistance),
                            CustomSizedBox(
                              width: 10,
                            ),
                            Text(
                              "Total Distance",
                              style: AppTextStyle.text14black0000W500,
                            ),
                            CustomSizedBox(
                              width: 12,
                            ),
                            ContainerWithBorder(
                              wantPadding: true,
                              containerColor: AppColors.kBlueF4F3FF,
                              borderColor: AppColors.kBlueF4F3FF,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10 * SizeConfig.widthMultiplier!,
                                ),
                                child: Text(
                                  "${getFinalRideFullDetails?.data?.totalDistance ?? ""}",
                                  style: AppTextStyle.text14black0000W600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            ImageLoader.svgPictureAssetImage(
                                imagePath: ImagePath.rideTotalTime),
                            CustomSizedBox(
                              width: 10,
                            ),
                            Text(
                              "Total Time",
                              style: AppTextStyle.text14black0000W500,
                            ),
                            CustomSizedBox(
                              width: 12,
                            ),
                            ContainerWithBorder(
                              wantPadding: true,
                              containerColor: AppColors.kBlueF4F3FF,
                              borderColor: AppColors.kBlueF4F3FF,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10 * SizeConfig.widthMultiplier!,
                                ),
                                child: Text(
                                  getFinalRideFullDetails?.data?.totalTime ??
                                      "",
                                  style: AppTextStyle.text14black0000W600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          height: 14,
                        ),
                        UsableSingleAddressRow(
                          padding: EdgeInsets.zero,
                          pickupAddress:
                              getFinalRideFullDetails?.data?.pickup ?? "",
                          dropUpAddress:
                              getFinalRideFullDetails?.data?.dropoff ?? "",
                        ),
                        CustomSizedBox(
                          height: 12,
                        ),
                        BlocBuilder<HireDriverCubit, HireState>(
                          builder: (context, state) {
                            return BlueButton(
                              wantMargin: false,
                              isLoading:
                                  state.driverMutateRideStatus.isLoading ||
                                      isLoading == true,
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                // updateRideStatus(RideStatus.delivered);
                                bool? isSuccess = await completedMutateRide(
                                  isFromFinalBottomsheet: true,
                                  mutationReason: '',
                                  userDeviceToken: userDeviceToken,
                                  userAmount: userAmount,
                                  userCurrency: userCurrency,
                                  userMode: userMode,
                                  userPaymentStatus: userPaymentStatus,
                                  rideID: rideID,
                                );
                                if (isSuccess == true) {
                                  isLoading = true;
                                  updateRideStatus(RideStatus.delivered);
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    AnywhereDoor.pushReplacementNamed(
                                        navigatorKey.currentState!.context,
                                        routeName: RouteName.homeScreen);
                                    setState1(() {
                                      // Here you can write your code for open new view
                                    });
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
}
