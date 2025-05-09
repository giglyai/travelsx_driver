import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/api_client/api_exception.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';
import 'package:travelx_driver/user/account/enitity/profile_model.dart';
import 'package:travelx_driver/user/account/enitity/vehiclelist_with_model/vehicle_with_model.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';
import 'package:travelx_driver/user/vehicle/data/add_vehicle_data.dart';
import 'package:travelx_driver/user/vehicle/entity/gettravel_list_data.dart';

import '../../../home/widget/container_with_border/container_with_border.dart';
import '../../../shared/widgets/text_form_field/pin_field.dart';

class AddVehicleState extends Equatable {
  final ApiStatus addVehicleApiStatus;
  final ApiStatus addManualVehicleApiStatus;
  final ApiStatus sendOtpApiStatus;
  final ApiStatus verifyOtpApiStatus;
  final FieldState<TextEditingController> otp;
  final FieldState<TextEditingController> vehicleType;
  final FieldState<TextEditingController> vehicleModel;
  final FieldState<TextEditingController> vehiclePlateNumber;
  final ApiStatus getTravelVehicleListDataApiStatus;

  GetTravelVehicleListData? getTravelVehicleListData;

  final ApiStatus getProfileData;
  GetUserProfileData? getUserProfileData;

  final FieldState<TextEditingController> addVehicleType;
  final FieldState<TextEditingController> addVehicleModel;
  final FieldState<TextEditingController> addVehiclePlateNumber;

  bool? addVehicleTypeListIsOpened;
  bool? addVehicleModelListIsOpened;
  List<VehicleData>? vehicleInformationList = [];
  List<String>? modelInformationList = [];
  final ApiStatus vehicleListModelApiStatus;

  VehicleListModel? vehicleListModel;

  AddVehicleState({
    required this.addVehicleApiStatus,
    required this.addManualVehicleApiStatus,
    required this.vehicleListModelApiStatus,
    required this.vehicleType,
    required this.vehicleModel,
    required this.vehiclePlateNumber,
    required this.getTravelVehicleListDataApiStatus,
    required this.sendOtpApiStatus,
    required this.verifyOtpApiStatus,
    required this.otp,
    this.getTravelVehicleListData,
    required this.getProfileData,
    this.getUserProfileData,
    required this.addVehicleType,
    required this.addVehicleModel,
    required this.addVehiclePlateNumber,
    this.addVehicleTypeListIsOpened,
    this.vehicleInformationList,
    this.modelInformationList,
    this.vehicleListModel,
    this.addVehicleModelListIsOpened,
  });

  static AddVehicleState init() => AddVehicleState(
        vehicleInformationList: [],
        modelInformationList: [],
        vehicleListModelApiStatus: ApiStatus.init,
        vehicleListModel: VehicleListModel(),
        addVehicleApiStatus: ApiStatus.init,
        addManualVehicleApiStatus: ApiStatus.init,
        sendOtpApiStatus: ApiStatus.init,
        verifyOtpApiStatus: ApiStatus.init,
        otp: FieldState.initial(value: TextEditingController()),
        vehicleType: FieldState.initial(value: TextEditingController()),
        vehicleModel: FieldState.initial(value: TextEditingController()),
        vehiclePlateNumber: FieldState.initial(value: TextEditingController()),
        getTravelVehicleListDataApiStatus: ApiStatus.init,
        getTravelVehicleListData: GetTravelVehicleListData(),
        getProfileData: ApiStatus.init,
        getUserProfileData: GetUserProfileData(),
        addVehicleType: FieldState.initial(value: TextEditingController()),
        addVehicleModel: FieldState.initial(value: TextEditingController()),
        addVehiclePlateNumber:
            FieldState.initial(value: TextEditingController()),
        addVehicleTypeListIsOpened: false,
        addVehicleModelListIsOpened: false,
      );

  AddVehicleState copyWith({
    ApiStatus? addVehicleApiStatus,
    ApiStatus? addManualVehicleApiStatus,
    FieldState<TextEditingController>? vehicleType,
    FieldState<TextEditingController>? vehicleModel,
    FieldState<TextEditingController>? vehiclePlateNumber,
    ApiStatus? getTravelVehicleListDataApiStatus,
    GetTravelVehicleListData? getTravelVehicleListData,
    ApiStatus? getProfileData,
    GetUserProfileData? getUserProfileData,
    ApiStatus? sendOtpApiStatus,
    ApiStatus? verifyOtpApiStatus,
    FieldState<TextEditingController>? otp,
    FieldState<TextEditingController>? addVehicleType,
    FieldState<TextEditingController>? addVehicleModel,
    FieldState<TextEditingController>? addVehiclePlateNumber,
    bool? addVehicleTypeListIsOpened,
    bool? addVehicleModelListIsOpened,
    List<VehicleData>? vehicleInformationList,
    List<String>? modelInformationList,
    final ApiStatus? vehicleListModelApiStatus,
    VehicleListModel? vehicleListModel,
  }) {
    return AddVehicleState(
      addVehicleApiStatus: addVehicleApiStatus ?? this.addVehicleApiStatus,
      addManualVehicleApiStatus:
          addManualVehicleApiStatus ?? this.addManualVehicleApiStatus,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      vehiclePlateNumber: vehiclePlateNumber ?? this.vehiclePlateNumber,
      getTravelVehicleListDataApiStatus: getTravelVehicleListDataApiStatus ??
          this.getTravelVehicleListDataApiStatus,
      getTravelVehicleListData:
          getTravelVehicleListData ?? this.getTravelVehicleListData,
      getProfileData: getProfileData ?? this.getProfileData,
      getUserProfileData: getUserProfileData ?? this.getUserProfileData,
      sendOtpApiStatus: sendOtpApiStatus ?? this.sendOtpApiStatus,
      verifyOtpApiStatus: verifyOtpApiStatus ?? this.verifyOtpApiStatus,
      otp: otp ?? this.otp,
      addVehicleType: addVehicleType ?? this.addVehicleType,
      addVehicleModel: addVehicleModel ?? this.addVehicleModel,
      addVehiclePlateNumber:
          addVehiclePlateNumber ?? this.addVehiclePlateNumber,
      addVehicleTypeListIsOpened:
          addVehicleTypeListIsOpened ?? this.addVehicleTypeListIsOpened,
      vehicleInformationList:
          vehicleInformationList ?? this.vehicleInformationList,
      modelInformationList: modelInformationList ?? this.modelInformationList,
      vehicleListModelApiStatus:
          vehicleListModelApiStatus ?? this.vehicleListModelApiStatus,
      vehicleListModel: vehicleListModel ?? this.vehicleListModel,
      addVehicleModelListIsOpened:
          addVehicleModelListIsOpened ?? this.addVehicleModelListIsOpened,
    );
  }

  @override
  List<Object?> get props => [
        addVehicleApiStatus,
        addManualVehicleApiStatus,
        vehicleType,
        vehicleModel,
        vehiclePlateNumber,
        getTravelVehicleListDataApiStatus,
        getTravelVehicleListData,
        getProfileData,
        getUserProfileData,
        sendOtpApiStatus,
        verifyOtpApiStatus,
        otp,
        addVehicleType,
        addVehicleModel,
        addVehiclePlateNumber,
        addVehicleTypeListIsOpened,
        vehicleInformationList,
        modelInformationList,
        vehicleListModelApiStatus,
        vehicleListModel,
        addVehicleModelListIsOpened,
      ];
}

class AddVehicleCubit extends Cubit<AddVehicleState> {
  AddVehicleCubit() : super(AddVehicleState.init());

  void onAddVehicleTypeControllerChanged({required String name}) {
    emit(
      state.copyWith(
        addVehicleType: state.addVehicleType.copyWith(
            error: '', value: TextEditingController(text: name.toString())),
      ),
    );
  }

  void onAddVehicleModelControllerChanged({required String name}) {
    emit(
      state.copyWith(
        addVehicleModel: state.addVehicleModel.copyWith(
            error: '', value: TextEditingController(text: name.toString())),
      ),
    );
  }

  void onModelInformationListChanged({List<String>? modelInformationList}) {
    emit(
      state.copyWith(
        modelInformationList: modelInformationList,
      ),
    );
  }

  void onAddVehicleTypeChanges(bool? value) {
    emit(
      state.copyWith(addVehicleTypeListIsOpened: value),
    );
  }

  void onAddVehicleModelChanges(bool? value) {
    emit(
      state.copyWith(addVehicleModelListIsOpened: value),
    );
  }

  toggleAddVehicleTypeListIsOpened() {
    if (state.addVehicleTypeListIsOpened == false) {
      emit(state.copyWith(addVehicleTypeListIsOpened: true));
    } else {
      emit(state.copyWith(addVehicleTypeListIsOpened: false));
    }
  }

  toggleAddVehicleModelListIsOpened() {
    if (state.addVehicleModelListIsOpened == false) {
      emit(state.copyWith(addVehicleModelListIsOpened: true));
    } else {
      emit(state.copyWith(addVehicleModelListIsOpened: false));
    }
  }

  void onVehicleTypeChanged(String? value) {
    emit(
      state.copyWith(
        vehicleType: state.vehicleType
            .copyWith(error: '', value: TextEditingController(text: value)),
      ),
    );
  }

  void onVehicleModelChanged(String? value) {
    emit(
      state.copyWith(
        vehicleModel: state.vehicleModel
            .copyWith(error: '', value: TextEditingController(text: value)),
      ),
    );
  }

  void onVehiclePlateNumberChanged(String? value) {
    emit(
      state.copyWith(
        vehiclePlateNumber: state.vehiclePlateNumber
            .copyWith(error: '', value: TextEditingController(text: value)),
      ),
    );
  }

  void onAddVehiclePlateNumberChanged(String? value) {
    emit(
      state.copyWith(
        addVehiclePlateNumber: state.addVehiclePlateNumber.copyWith(
          error: '',
        ),
      ),
    );
  }

  void onAddVehicleTypeChanged(String? value) {
    emit(
      state.copyWith(
        addVehicleType: state.addVehicleType.copyWith(
          error: '',
        ),
      ),
    );
  }

  void onAddVehicleModelChanged(String? value) {
    emit(
      state.copyWith(
        addVehicleModel: state.addVehicleModel.copyWith(
          error: '',
        ),
      ),
    );
  }

  bool get isAddVehicleIsValid {
    final isVehicleTypeValid =
        state.addVehicleType.value.text.trim().isNotEmpty;
    final isVehicleModelValid =
        state.addVehicleModel.value.text.trim().isNotEmpty;
    final isVehiclePlateNumberValid =
        state.addVehiclePlateNumber.value.text.trim().isNotEmpty;
    if (isVehicleTypeValid == false) {
      emit(
        state.copyWith(
          addVehicleType:
              state.addVehicleType.copyWith(errorColor: AppColors.kredDF0000),
        ),
      );
    } else {
      emit(
        state.copyWith(
          addVehicleType:
              state.addVehicleType.copyWith(errorColor: AppColors.kBlue3D6),
        ),
      );
    }

    if (isVehicleModelValid == false) {
      emit(
        state.copyWith(
          addVehicleModel:
              state.addVehicleModel.copyWith(errorColor: AppColors.kredDF0000),
        ),
      );
    } else {
      emit(
        state.copyWith(
          addVehicleModel:
              state.addVehicleModel.copyWith(errorColor: AppColors.kBlue3D6),
        ),
      );
    }
    if (isVehiclePlateNumberValid == false) {
      emit(
        state.copyWith(
          addVehiclePlateNumber: state.addVehiclePlateNumber
              .copyWith(error: 'Vehicle number is required'),
        ),
      );
    } else {
      emit(
        state.copyWith(
          addVehiclePlateNumber: state.addVehiclePlateNumber
              .copyWith(errorColor: AppColors.kBlue3D6),
        ),
      );
    }

    return isVehicleTypeValid &&
        isVehicleModelValid &&
        isVehiclePlateNumberValid;
  }

  Future<void> postVehicleData() async {
    emit(
      state.copyWith(
        addVehicleApiStatus: ApiStatus.loading,
      ),
    );
    try {
      final response = await AddVehicleData.postVehicleData(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        firstName: ProfileRepository.getFirstName ?? "",
        countryCode: UserRepository.getCountryCode ?? "",
        phoneNumber: UserRepository.getPhoneNumber ?? "",
        vehicleType: state.vehicleType.value.text,
        vehicleModel: state.vehicleModel.value.text,
        vehicleNumber: state.vehiclePlateNumber.value.text,
      );

      if (response['status'] == "success") {
        flushAddVehicleData();
        emit(
          state.copyWith(addVehicleApiStatus: ApiStatus.success),
        );
        AnywhereDoor.pop(navigatorKey.currentState!.context);
        Future.delayed(const Duration(milliseconds: 500), () async {
          await congratsBottomSheet();
        });
      }
    } on ApiException catch (e) {
      emit(state.copyWith(addVehicleApiStatus: ApiStatus.failure));
    } catch (e) {
      emit(state.copyWith(addVehicleApiStatus: ApiStatus.failure));
    }
  }

  Future<void> addVehicleDetails() async {
    emit(
      state.copyWith(
        addManualVehicleApiStatus: ApiStatus.loading,
      ),
    );
    try {
      final response = await AddVehicleData.addVehicleDetails(
        lpId: int.tryParse(
              UserRepository.getLpID ?? "",
            ) ??
            0,
        userId: int.tryParse(
              UserRepository.getUserID ?? "",
            ) ??
            0,
        userName: ProfileRepository.getFirstName ?? "",
        countryCode: UserRepository.getCountryCode ?? "",
        phoneNumber: UserRepository.getPhoneNumber ?? "",
        vehicleType: state.addVehicleType.value.text,
        vehicleModel: state.addVehicleModel.value.text,
        vehicleNumber: state.addVehiclePlateNumber.value.text,
      );

      if (response['status'] == "success") {
        flushVehicleData();
        emit(
          state.copyWith(addManualVehicleApiStatus: ApiStatus.success),
        );

        AnywhereDoor.pushNamed(navigatorKey.currentState!.context,
            routeName: RouteName.driverVehicleMainScreen);
      }
    } on ApiException catch (e) {
      emit(state.copyWith(addManualVehicleApiStatus: ApiStatus.failure));
    } catch (e) {
      emit(state.copyWith(addManualVehicleApiStatus: ApiStatus.failure));
    }
  }

  Future<void> getTravelCarList() async {
    emit(
      state.copyWith(
        getTravelVehicleListDataApiStatus: ApiStatus.loading,
      ),
    );
    try {
      final response = await AddVehicleData.getTravelCarList(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
      );

      if (response['status'] == "success") {
        final getData = GetTravelVehicleListData.fromJson(response);

        if (getData.data?.allVehicles?.isNotEmpty == true) {
          emit(
            state.copyWith(
                getTravelVehicleListData: getData,
                getTravelVehicleListDataApiStatus: ApiStatus.success),
          );
        } else {
          emit(
            state.copyWith(getTravelVehicleListDataApiStatus: ApiStatus.empty),
          );
        }
      }
    } on ApiException catch (e) {
      emit(
          state.copyWith(getTravelVehicleListDataApiStatus: ApiStatus.failure));
    } catch (e) {
      emit(
          state.copyWith(getTravelVehicleListDataApiStatus: ApiStatus.failure));
    }
  }

  Future<void> getVehicleListData() async {
    emit(
      state.copyWith(
        vehicleListModelApiStatus: ApiStatus.loading,
      ),
    );
    try {
      final response = await AddVehicleData.getVehicleListData(
          lpId: UserRepository.getLpID,
          userId: UserRepository.getUserID,
          phoneNumber: UserRepository.getPhoneNumber ?? "",
          countryCode: UserRepository.getCountryCode ?? "");

      if (response['status'] == "success") {
        final getData = VehicleListModel.fromJson(response);

        emit(
          state.copyWith(
              vehicleListModel: getData,
              vehicleInformationList: getData.data,
              vehicleListModelApiStatus: ApiStatus.success),
        );
      }
    } on ApiException catch (e) {
      emit(state.copyWith(vehicleListModelApiStatus: ApiStatus.failure));
    } catch (e) {
      emit(state.copyWith(vehicleListModelApiStatus: ApiStatus.failure));
    }
  }

  Future<void> sendOtp() async {
    emit(
      state.copyWith(
        sendOtpApiStatus: ApiStatus.loading,
      ),
    );
    try {
      final response = await AddVehicleData.sendOtp(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: AppNames.appName,
      );
      if (response['status'] == "success") {
        emit(state.copyWith(sendOtpApiStatus: ApiStatus.success));
        AnywhereDoor.pop(navigatorKey.currentState!.context);
        Future.delayed(const Duration(milliseconds: 500), () async {
          await showVerifyOtp();
        });
      }
    } on ApiException catch (e) {
      emit(state.copyWith(sendOtpApiStatus: ApiStatus.failure));
    } catch (e) {
      emit(state.copyWith(sendOtpApiStatus: ApiStatus.failure));
    }
  }

  Future<void> travelVerifyVehicleOtp() async {
    emit(
      state.copyWith(
        verifyOtpApiStatus: ApiStatus.loading,
      ),
    );
    try {
      final response = await AddVehicleData.travelVerifyVehicleOtp(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: AppNames.appName,
        otp: state.otp.value.text,
      );
      if (response['status'] == "success") {
        emit(
          state.copyWith(verifyOtpApiStatus: ApiStatus.success),
        );

        await postVehicleData();
        emit(
          state.copyWith(
            otp: FieldState.initial(value: TextEditingController()),
          ),
        );
      } else {
        emit(
          state.copyWith(
            otp: FieldState.initial(value: TextEditingController()),
          ),
        );
      }
    } on ApiException catch (e) {
      emit(state.copyWith(verifyOtpApiStatus: ApiStatus.failure));
    } catch (e) {
      emit(state.copyWith(verifyOtpApiStatus: ApiStatus.failure));
    }
  }

  Future<void> getUserData() async {
    try {
      emit(
        state.copyWith(
          getProfileData: ApiStatus.loading,
        ),
      );

      final response = await AddVehicleData.getProfileData(
        lpId: UserRepository.getLpID ?? '',
        userId: UserRepository.getUserID ?? '',
      );

      if (response['status'] == "success") {
        final getUserProfileData = GetUserProfileData.fromJson(response);

        emit(
          state.copyWith(
            getProfileData: ApiStatus.success,
            getUserProfileData: getUserProfileData,
          ),
        );
      }
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          getProfileData: ApiStatus.failure,
        ),
      );
    }
  }

  void confirmSelectVehiclePopUp({
    required BuildContext context,
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
                          "Are you sure you want to \nselect this vehicle",
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
                        BlocBuilder<AddVehicleCubit, AddVehicleState>(
                          builder: (context, state) {
                            return BlueButton(
                              borderRadius: 12 * SizeConfig.widthMultiplier!,
                              height: 46 * SizeConfig.heightMultiplier!,
                              width: 120 * SizeConfig.widthMultiplier!,
                              wantMargin: false,
                              isLoading: state.sendOtpApiStatus.isLoading,
                              title: "Yes",
                              onTap: () async {
                                await sendOtp();
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

  void deleteMyVehiclePop({
    required BuildContext context,
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
                          "Are you sure you want to \ndelete this vehicle",
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
                        BlocBuilder<AddVehicleCubit, AddVehicleState>(
                          builder: (context, state) {
                            return BlueButton(
                              borderRadius: 12 * SizeConfig.widthMultiplier!,
                              height: 46 * SizeConfig.heightMultiplier!,
                              width: 120 * SizeConfig.widthMultiplier!,
                              wantMargin: false,
                              isLoading:
                                  state.addManualVehicleApiStatus.isLoading,
                              title: "Yes",
                              onTap: () async {
                                await addVehicleDetails();
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

  showVerifyOtp() async {
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
                  height: 250 * SizeConfig.heightMultiplier!,
                  child: BlocBuilder<AddVehicleCubit, AddVehicleState>(
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
                                    left: 20 * SizeConfig.widthMultiplier!),
                                child: Text(
                                  'Verify OTP',
                                  style: AppTextStyle.text20black0000W400,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  AnywhereDoor.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(
                                      8 * SizeConfig.widthMultiplier!),
                                  decoration: BoxDecoration(
                                      color: AppColors.kWhiteE5E5E5,
                                      borderRadius: BorderRadius.circular(37)),
                                  child: ImageLoader.svgPictureAssetImage(
                                      imagePath: ImagePath.closeIcon,
                                      height:
                                          10 * SizeConfig.heightMultiplier!),
                                ),
                              ),
                              CustomSizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          CustomSizedBox(
                            height: 23,
                          ),
                          CustomPinTextField(
                            pinController: state.otp.value,
                            obscureText: false,
                            onCompleted: (v) async {
                              await travelVerifyVehicleOtp();
                            },
                            pinMaxLength: 6,
                          ),
                          CustomSizedBox(
                            height: 10,
                          ),
                          state.sendOtpApiStatus.isLoading
                              ? ImageLoader.assetImage(
                                  imagePath: ImagePath.loaderImage,
                                  width: 80 * SizeConfig.widthMultiplier!,
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: 20 * SizeConfig.widthMultiplier!),
                                  child: ContainerWithBorder(
                                    borderColor: AppColors.kRedDF0000,
                                    containerColor: AppColors.kWhite,
                                    borderRadius:
                                        6 * SizeConfig.widthMultiplier!,
                                    child: GestureDetector(
                                      onTap: () {
                                        sendOtp();
                                      },
                                      child: Text("Resend OTP ",
                                          style: AppTextStyle
                                              .text12Bblack0000W500),
                                    ),
                                  ),
                                ),
                          CustomSizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20 * SizeConfig.widthMultiplier!),
                            child: Text(
                              "We have sent a otp to your registered mobile number.",
                              style: AppTextStyle.text12black0000W400?.copyWith(
                                  color:
                                      AppColors.kBlack2A2A2A.withOpacity(0.62)),
                            ),
                          )
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

  congratsBottomSheet() async {
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
              canPop: true,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(16 * SizeConfig.widthMultiplier!),
                      topRight:
                          Radius.circular(16 * SizeConfig.widthMultiplier!),
                    ),
                  ),
                  height: 173 * SizeConfig.heightMultiplier!,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 21 * SizeConfig.widthMultiplier!,
                          right: 22 * SizeConfig.widthMultiplier!),
                      child: Column(
                        children: [
                          CustomSizedBox(height: 22),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 95 * SizeConfig.widthMultiplier!),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Congratulation",
                                  style: AppTextStyle.text20black0000W400,
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.all(
                                      8 * SizeConfig.widthMultiplier!),
                                  decoration: BoxDecoration(
                                      color: AppColors.kWhiteE5E5E5,
                                      borderRadius: BorderRadius.circular(37)),
                                  child: GestureDetector(
                                    onTap: () {
                                      AnywhereDoor.pop(context);
                                    },
                                    child: ImageLoader.svgPictureAssetImage(
                                        imagePath: ImagePath.closeIcon,
                                        height:
                                            10 * SizeConfig.heightMultiplier!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomSizedBox(height: 12),
                          Center(
                            child: Text(
                              "Car has been selected successfully",
                              style: AppTextStyle.text16black0000W400
                                  ?.copyWith(color: AppColors.kRedBA3043),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CustomSizedBox(height: 22),
                          BlueButton(
                            borderRadius: 3 * SizeConfig.widthMultiplier!,
                            wantMargin: false,
                            title: "Home",
                            onTap: () async {
                              AnywhereDoor.pushReplacementNamed(context,
                                  routeName: RouteName.homeScreen);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  void flushAddVehicleData() {
    emit(
      state.copyWith(
        vehicleType: FieldState.initial(value: TextEditingController()),
        vehicleModel: FieldState.initial(value: TextEditingController()),
        vehiclePlateNumber: FieldState.initial(value: TextEditingController()),
      ),
    );
  }

  void flushVehicleData() {
    emit(
      state.copyWith(
        addVehicleType: FieldState.initial(value: TextEditingController()),
        addVehicleModel: FieldState.initial(value: TextEditingController()),
        addVehiclePlateNumber:
            FieldState.initial(value: TextEditingController()),
      ),
    );
  }
}
