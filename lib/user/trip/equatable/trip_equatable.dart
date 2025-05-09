import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/home/revamp/entity/ride_matrix.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/enums/common_enums.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/user/trip/repository/trip_repository.dart';

class TripEquatableState extends Equatable {
  final ApiStatus getAllTripDataApiStatus;
  GetAllTripsData? getAllTripsData;
  List<TripAllData>? tripAllData;
  final TripStatus selectedFilter;
  final ApiStatus getTravelDriversApiStatus;
  final ApiStatus assignRideApiStatus;
  final ApiStatus cancelRideApiStatus;
  int? driverUserID;
  int? driverLpId;
  String? rideId;
  String? deviceToken;
  String? vehicleType;
  List<int>? getTotalValue;

  TripEquatableState({
    required this.getAllTripDataApiStatus,
    this.getAllTripsData,
    this.tripAllData,
    required this.selectedFilter,
    required this.getTravelDriversApiStatus,
    required this.assignRideApiStatus,
    required this.cancelRideApiStatus,
    this.driverLpId,
    this.driverUserID,
    this.rideId,
    this.deviceToken,
    this.vehicleType,
    this.getTotalValue,
  });

  static TripEquatableState init() => TripEquatableState(
        getAllTripDataApiStatus: ApiStatus.init,
        assignRideApiStatus: ApiStatus.init,
        getAllTripsData: GetAllTripsData(),
        tripAllData: [],
        selectedFilter: TripStatus.all,
        getTravelDriversApiStatus: ApiStatus.init,
        cancelRideApiStatus: ApiStatus.init,
        driverUserID: 0,
        driverLpId: 0,
        rideId: "",
        deviceToken: "",
        vehicleType: "",
        getTotalValue: [],
      );

  TripEquatableState copyWith({
    ApiStatus? getAllTripDataApiStatus,
    GetAllTripsData? getAllTripsData,
    List<TripAllData>? tripAllData,
    TripStatus? selectedFilter,
    ApiStatus? getTravelDriversApiStatus,
    ApiStatus? assignRideApiStatus,
    ApiStatus? cancelRideApiStatus,
    int? driverUserID,
    int? driverLpId,
    String? rideId,
    String? deviceToken,
    String? vehicleType,
    List<int>? getTotalValue,
  }) {
    return TripEquatableState(
      getAllTripDataApiStatus:
          getAllTripDataApiStatus ?? this.getAllTripDataApiStatus,
      getAllTripsData: getAllTripsData ?? this.getAllTripsData,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      tripAllData: tripAllData ?? this.tripAllData,
      getTravelDriversApiStatus:
          getTravelDriversApiStatus ?? this.getTravelDriversApiStatus,
      assignRideApiStatus: assignRideApiStatus ?? this.assignRideApiStatus,
      cancelRideApiStatus: cancelRideApiStatus ?? this.cancelRideApiStatus,
      driverUserID: driverUserID ?? this.driverUserID,
      driverLpId: driverLpId ?? this.driverLpId,
      rideId: rideId ?? this.rideId,
      deviceToken: deviceToken ?? this.deviceToken,
      vehicleType: vehicleType ?? this.vehicleType,
      getTotalValue: getTotalValue ?? this.getTotalValue,
    );
  }

  @override
  List<Object?> get props => [
        getAllTripDataApiStatus,
        getAllTripsData,
        selectedFilter,
        tripAllData,
        getTravelDriversApiStatus,
        assignRideApiStatus,
        driverUserID,
        driverLpId,
        rideId,
        deviceToken,
        vehicleType,
        cancelRideApiStatus,
        getTotalValue,
      ];
}

class TripEquatableCubit extends Cubit<TripEquatableState> {
  TripEquatableCubit() : super(TripEquatableState.init()) {}

  Future<void> getSingleTripData(
      {String? dateFilter, TripStatus? status}) async {
    emit(
      state.copyWith(
        getAllTripDataApiStatus: ApiStatus.loading,
      ),
    );
    try {
      final response = await TripRepository.getTripData(
        lpId: UserRepository.getLpID,
        userId: UserRepository.getUserID,
        dateFilter: dateFilter ?? "Today",
      );
      if (response['data'] is String) {
        emit(
          state.copyWith(
            getAllTripDataApiStatus: ApiStatus.empty,
          ),
        );
      } else {
        final getAllTripData = GetAllTripsData.fromJson(response);

        if (status == TripStatus.all) {
          emit(
            state.copyWith(
              getAllTripsData: getAllTripData,
              tripAllData: getAllTripData.data?.all,
              selectedFilter: status,
              getAllTripDataApiStatus: ApiStatus.success,
            ),
          );
        } else if (status == TripStatus.assigned) {
          emit(
            state.copyWith(
              getAllTripsData: getAllTripData,
              tripAllData: getAllTripData.data?.assigned,
              selectedFilter: status,
              getAllTripDataApiStatus: ApiStatus.success,
            ),
          );
        } else if (status == TripStatus.completed) {
          emit(
            state.copyWith(
              getAllTripsData: getAllTripData,
              tripAllData: getAllTripData.data?.completed,
              selectedFilter: status,
              getAllTripDataApiStatus: ApiStatus.success,
            ),
          );
        } else if (status == TripStatus.cancelled) {
          emit(
            state.copyWith(
              getAllTripsData: getAllTripData,
              tripAllData: getAllTripData.data?.cancelled,
              selectedFilter: status,
              getAllTripDataApiStatus: ApiStatus.success,
            ),
          );
        }

        emit(
          state.copyWith(
            getTotalValue: [
              state.getAllTripsData?.data?.all?.length ?? 0,
              state.getAllTripsData?.data?.assigned?.length ?? 0,
              state.getAllTripsData?.data?.completed?.length ?? 0,
              state.getAllTripsData?.data?.cancelled?.length ?? 0,
            ],
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          getAllTripDataApiStatus: ApiStatus.failure,
        ),
      );
    }
  }

  void changeOrderFilter(TripStatus status) {
    if (status == TripStatus.all) {
      emit(state.copyWith(
        tripAllData: state.getAllTripsData?.data?.all,
        selectedFilter: status,
        getAllTripDataApiStatus: ApiStatus.success,
      ));
    } else if (status == TripStatus.assigned) {
      emit(state.copyWith(
        tripAllData: state.getAllTripsData?.data?.assigned,
        selectedFilter: status,
        getAllTripDataApiStatus: ApiStatus.success,
      ));
    } else if (status == TripStatus.completed) {
      emit(state.copyWith(
        tripAllData: state.getAllTripsData?.data?.completed,
        selectedFilter: status,
        getAllTripDataApiStatus: ApiStatus.success,
      ));
    } else if (status == TripStatus.cancelled) {
      emit(state.copyWith(
        tripAllData: state.getAllTripsData?.data?.cancelled,
        selectedFilter: status,
        getAllTripDataApiStatus: ApiStatus.success,
      ));
    }

    // getSingleTripData(status: status);
  }

  void initialValueTripScreen() {
    emit(state.copyWith(
      selectedFilter: TripStatus.all,
    ));
  }

  Future<void> cancelRide({
    required String rideID,
    TripStatus? status,
  }) async {
    emit(state.copyWith(cancelRideApiStatus: ApiStatus.loading));
    try {
      final response = await TripRepository.cancelRide(
        lpId: int.tryParse(UserRepository.getLpID ?? "") ?? 0,
        userId: int.tryParse(UserRepository.getUserID ?? "") ?? 0,
        rideID: rideID,
      );

      if (response['status'] == "success") {
        emit(state.copyWith(cancelRideApiStatus: ApiStatus.success));
        AnywhereDoor.pop(navigatorKey.currentState!.context);
        getSingleTripData(status: status);
      } else {
        emit(state.copyWith(cancelRideApiStatus: ApiStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(cancelRideApiStatus: ApiStatus.failure));
    }
  }

  void cancelRideConfirmationPop({
    required BuildContext context,
    required String rideId,
    required TripStatus status,
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
                right: 15 * SizeConfig.widthMultiplier!),
            backgroundColor: AppColors.kWhite,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10 * SizeConfig.widthMultiplier!)),
            title: SizedBox(
              width: 550 * SizeConfig.widthMultiplier!,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 38 * SizeConfig.widthMultiplier!),
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
                          padding:
                              EdgeInsets.all(8 * SizeConfig.widthMultiplier!),
                          decoration: BoxDecoration(
                              color: AppColors.kWhiteE5E5E5,
                              borderRadius: BorderRadius.circular(37)),
                          child: GestureDetector(
                            onTap: () {
                              AnywhereDoor.pop(context);
                            },
                            child: ImageLoader.svgPictureAssetImage(
                                imagePath: ImagePath.closeIcon,
                                height: 10 * SizeConfig.heightMultiplier!),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomSizedBox(height: 22),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 12 * SizeConfig.widthMultiplier!),
                    child: Row(
                      children: [
                        BlocBuilder<TripEquatableCubit, TripEquatableState>(
                          builder: (context, state) {
                            return BlueButton(
                              borderRadius: 12 * SizeConfig.widthMultiplier!,
                              height: 46 * SizeConfig.heightMultiplier!,
                              width: 120 * SizeConfig.widthMultiplier!,
                              wantMargin: false,
                              isLoading: state.cancelRideApiStatus.isLoading,
                              title: "Yes",
                              onTap: () async {
                                await cancelRide(
                                    rideID: rideId, status: status);
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
        });
  }
}
