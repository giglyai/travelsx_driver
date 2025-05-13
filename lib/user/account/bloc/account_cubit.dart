import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:travelx_driver/config/phone_pay/phone_pay_payment.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/user/account/enitity/profile_backside.dart';
import 'package:travelx_driver/user/account/enitity/vehiclelist_with_model/vehicle_with_model.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';

import '../../../shared/api_client/api_exception.dart';
import '../../../shared/local_storage/user_repository.dart';
import '../enitity/profile_model.dart';
import '../enitity/upload.dart';
import '../repository/account_delete_repo.dart';
import '../repository/account_repository.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  GetUserProfileData? getUserProfileData;
  VehicleListModel? vehicleInformationList;

  Future<void> postUserData({
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    try {
      emit(AccountLoading());
      final response = await AccountRepository.postUserData(
        lpId: int.parse(UserRepository.getLpID!),
        userId: int.parse(UserRepository.getUserID!),
        user: 'travelsx-driver',
        firstName: firstName ?? "",
        lastName: lastName ?? "",
        email: email ?? "",
      );

      if (response['status'] == "success") {
        emit(AccountSuccessState(message: response['data']));
      }
    } on ApiException catch (e) {
      emit(
        AccountFailure(errorMessage: ""),
      );
    }
  }

  Future<GetUserProfileData?> getProfileData() async {
    emit(AccountProfileLoading());
    try {
      final response = await AccountRepository.getProfileData(
          lpId: UserRepository.getLpID,
          userId: UserRepository.getUserID,
          user: 'travelsx-driver',
          phoneNumber: UserRepository.getPhoneNumber ?? "",
          countryCode: UserRepository.getCountryCode ?? "");
      getUserProfileData = GetUserProfileData.fromJson(response);
      if (getUserProfileData?.data != null) {
        emit(AccountProfileSuccessState(
            getUserProfileData: getUserProfileData!));
        return getUserProfileData;
      }
    } catch (e) {
      emit(AccountProfileFailure(errorMessage: "something went wrong"));
    }
  }

  Future<VehicleListModel?> getVehicleData() async {
    emit(VehicleLoading());
    try {
      final response = await AccountRepository.getVehicleListData(
          lpId: UserRepository.getLpID,
          userId: UserRepository.getUserID,
          user: 'travelsx-driver',
          phoneNumber: UserRepository.getPhoneNumber ?? "",
          countryCode: UserRepository.getCountryCode ?? "");
      vehicleInformationList = VehicleListModel.fromJson(response);
      if (vehicleInformationList?.data != null) {
        emit(VehicleLoadingSuccessState(
            vehicleInformationList: vehicleInformationList!));
        return vehicleInformationList;
      }
    } catch (e) {
      emit(VehicleFailure(errorMessage: "something went wrong"));
    }
  }

  Future<void> uploadProfileImg({required String imagePath}) async {
    emit(ProfileUploadLoading());

    try {
      PostProfileData params = PostProfileData(
          lpId: int.tryParse(UserRepository.getLpID ?? "") ?? 0,
          userId: int.tryParse(UserRepository.getUserID ?? "") ?? 0,
          phoneNumber: UserRepository.getPhoneNumber,
          user: AppNames.appName);

      final response = await AccountRepository.uploadProfileImg(
          params: params, imagePath: imagePath);

      if (response['status'] == "success") {
        emit(ProfileUploadSuccessState(message: "Success"));
      }
    } catch (e) {
      emit(ProfileUpdateFailure(errorMessage: ""));
    }
  }

  Future<void> postDriverVehicleInfo({
    String? vehicleCompany,
    String? vehicleModel,
    String? vehicleNumber,
    String? licenseNumber,
    String? userName,
    String? vehicleName,
  }) async {
    try {
      emit(VehicleInfoLoading());
      final currentLocation = await Utils.getCurrentLocation();

      final response = await AccountRepository.postDriverVehicleInfo(
        userName: userName ?? ProfileRepository.getFirstName ?? "",
        lpId: int.parse(UserRepository.getLpID!),
        userId: int.parse(UserRepository.getUserID!),
        countryCode: UserRepository.getCountryCode ?? '',
        phoneNumber: UserRepository.getPhoneNumber ?? '',
        user: AppNames.appName,
        vehicleCompany: vehicleName ?? "",
        vehicleModel: vehicleModel ?? "",
        vehicleNumber: vehicleNumber ?? "",
        licenseNumber: licenseNumber ?? "",
      );

      if (response['status'] == "success") {
        emit(VehicleInfoSuccessState(message: response['data']));
      }
    } catch (e) {
      emit(
        VehicleInfoFailure(errorMessage: ""),
      );
    }
  }

  Future<void> postFreshDriverVehicleInfo({
    String? vehicleCompany,
    String? vehicleModel,
    String? vehicleName,
    String? vehicleNumber,
    String? licenseNumber,
    String? firstName,
    String? address,
    String? place,
    required bool activeDriver,
    DriverPosition? position,
  }) async {
    try {
      emit(VehicleInfoLoading());
      final currentLocation = await Utils.getCurrentLocation();

      final response = await AccountRepository.postFreshDriverVehicleInfo(
        actingDriver: activeDriver,
        firstName: firstName ?? "",
        lpId: int.parse(UserRepository.getLpID!),
        userId: int.parse(UserRepository.getUserID!),
        user: AppNames.appName,
        vehicleCompany: vehicleName ?? "",
        vehicleModel: vehicleModel ?? "",
        vehicleNumber: vehicleNumber ?? "",
        licenseNumber: licenseNumber ?? "",
        address: address ?? "",
        place: place ?? "",
        position: position?.latitude != null
            ? DriverPosition(
                latitude: position?.latitude ?? 0,
                longitude: position?.longitude ?? 0)
            : DriverPosition(
                latitude: currentLocation.latitude,
                longitude: currentLocation.longitude),
      );

      if (response['status'] == "success") {
        emit(VehicleInfoSuccessState(message: response['data']));
      }
    } catch (e) {
      emit(
        VehicleInfoFailure(errorMessage: ""),
      );
    }
  }

  Future<void> postBMTTravelInfo({
    String? firstName,
    String? address,
    String? place,
    String? licenseNumber,
    DriverPosition? position,
  }) async {
    try {
      emit(VehicleInfoLoading());
      final currentLocation = await Utils.getCurrentLocation();

      final response = await AccountRepository.postBMTTravelInfo(
        licenseNumber: licenseNumber ?? "",
        firstName: firstName ?? "",
        lpId: int.parse(UserRepository.getLpID!),
        userId: int.parse(UserRepository.getUserID!),
        user: AppNames.appName,
        address: address ?? "",
        place: place ?? "",
        position: position?.latitude != null
            ? DriverPosition(
                latitude: position?.latitude ?? 0,
                longitude: position?.longitude ?? 0)
            : DriverPosition(
                latitude: currentLocation.latitude,
                longitude: currentLocation.longitude),
      );

      if (response['status'] == "success") {
        AnywhereDoor.pushReplacementNamed(navigatorKey.currentState!.context,
            routeName: RouteName.homeScreen);
        emit(VehicleInfoSuccessState(message: response['data']));
      }
    } catch (e) {
      emit(
        VehicleInfoFailure(errorMessage: ""),
      );
    }
  }

  Future<void> deleteAccount() async {
    emit(AccountDeleteLoading());
    try {
      final response = await AccountRepository.deleteAccountData(
          lpId: int.parse(UserRepository.getLpID ?? ""),
          userId: int.parse(UserRepository.getUserID ?? ""),
          user: 'travelsx-driver');

      final AccountDeleteRes accountDeleteData =
          AccountDeleteRes.fromJson(response);
      if (accountDeleteData?.data != null) {
        emit(AccountDeleteSuccessState(accountDeleteRes: accountDeleteData));
      }
    } catch (e) {
      emit(AccountDeleteFailure(errorMessage: "something went wrong"));
    }
  }

  Future<void> uploadDriverDocIdImages({
    required String frontImagePath,
    required String backImagePath,
    ListOfDocuments? listOfDocuments,
  }) async {
    emit(ProfileUploadLoading());

    try {
      PostProfileData params = PostProfileData(
          lpId: int.tryParse(UserRepository.getLpID ?? "") ?? 0,
          userId: int.tryParse(UserRepository.getUserID ?? "") ?? 0,
          phoneNumber: UserRepository.getPhoneNumber,
          user: AppNames.appName);

      final response = await AccountRepository.uploadDriverId(
        listOfDocuments: listOfDocuments,
        params: params,
        frontImagePath: frontImagePath,
        backImagePath: backImagePath,
      );

      if (response['status'] == "success") {
        emit(DriverDocUploadSuccess(message: "success"));
      }
    } catch (e) {
      emit(ProfileUpdateFailure(errorMessage: ""));
    }
  }

  showJoiningBottomSheet({GetUserProfileData? getUserProfileData}) async {
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
                  height: 390 * SizeConfig.heightMultiplier!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Text("Joining fee",
                            style: AppTextStyle.text32black0000W700),
                      ),
                      CustomSizedBox(height: 16),
                      Center(
                        child: Text(
                          "You have to pay one time joining fee to\nenjoy our services.",
                          style: AppTextStyle.text14kBlue092765W400?.copyWith(
                              color: AppColors.kBlue092765.withOpacity(0.70)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CustomSizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "INR",
                            style: AppTextStyle.text40kGreen84C4B0700,
                          ),
                          CustomSizedBox(
                            width: 10,
                          ),
                          Text(
                            getUserProfileData?.data?.joiningFee?.amount
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
                        //   await UpiPayment(
                        //     ///Todo Uncomment after testing
                        //     totalAmount:
                        //         getUserProfileData?.data?.joiningFee?.amount ??
                        //             0,
                        //     // totalAmount: 1,
                        //   ).startPgTransaction().then((value) async {
                        //     if (value?.success == true) {
                        //       final Map<String, dynamic> response =
                        //           await ApiClient()
                        //               .post(ApiRoutes.statusCreate, body: {
                        //         "payment_response": value ?? "",
                        //         "user_id": UserRepository.getUserID,
                        //         "lp_id": UserRepository.getLpID,
                        //         "feature": "joining-fee",
                        //         "user": AppNames.appName,
                        //         "create_iso_time":
                        //             DateTime.now().toIso8601String(),
                        //         "create_utc_time":
                        //             DateTime.now().toUtc().toIso8601String(),
                        //         "payment_type": {
                        //           "mode":
                        //               value?.data?.paymentInstrument?.type ??
                        //                   "",
                        //           "status": "paid",
                        //           "amount": getUserProfileData
                        //               ?.data?.joiningFee?.amount,
                        //           "currency": "INR"
                        //         },
                        //         "reason": "as joining fee",
                        //       });
                        //       if (response['status'] == "success") {
                        //         showJoiningPaymentDone();
                        //       }
                        //     } else {}
                        //   });
                        //   ;
                         },
                      ),
                      CustomSizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          "By joining, you agree to the Terms of Service and Privacy Policy.",
                          style: AppTextStyle.text11kBlue0D368CW7400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  showJoiningPaymentDone() async {
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
                  height: 390 * SizeConfig.heightMultiplier!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomSizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text("Congratulations",
                            style: AppTextStyle.text32black0000W700),
                      ),
                      CustomSizedBox(height: 16),
                      Center(
                        child: Text(
                          "You are now a Premium member of our\napplication.Enjoy our seamless services.",
                          style: AppTextStyle.text14kBlue092765W400?.copyWith(
                              color: AppColors.kBlue092765.withOpacity(0.70)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CustomSizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "INR",
                            style: AppTextStyle.text40kGreen84C4B0700,
                          ),
                          CustomSizedBox(
                            width: 10,
                          ),
                          Text(
                            getUserProfileData?.data?.joiningFee?.amount
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
                        title: "Continue",
                        onTap: () async {},
                      ),
                      CustomSizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          "By joining, you agree to the Terms of Service and Privacy Policy.",
                          style: AppTextStyle.text11kBlue0D368CW7400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
