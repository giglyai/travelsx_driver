// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';
import 'package:travelx_driver/user/account/enitity/vehiclelist_with_model/vehicle_with_model.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';

import '../../../../shared/widgets/buttons/blue_button.dart';
import '../../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../../shared/widgets/size_config/size_config.dart';
import '../../bloc/account_cubit.dart';
import '../../enitity/profile_model.dart';
import 'driver_onboarding_screen_shimmer.dart';

class DriverOnBoardingVehicleInfoScreen extends StatefulWidget {
  DriverOnBoardingVehicleInfoScreen(
      {super.key, this.name, this.address, this.placeShortName, this.position});

  String? name;
  String? address;
  String? placeShortName;

  DriverPosition? position;

  @override
  State<DriverOnBoardingVehicleInfoScreen> createState() =>
      _DriverOnBoardingVehicleInfoScreenState();
}

class _DriverOnBoardingVehicleInfoScreenState
    extends State<DriverOnBoardingVehicleInfoScreen> {
  late AccountCubit accountCubit;

  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController driverLicenseController = TextEditingController();

  String? categoryChoose;
  String? modelChoose;

  Position? _currentPosition;
  List<VehicleData>? data;
  List<VehicleData>? vehicleInformationList = [];
  List<String>? modelInformationList = [];
  GetUserProfileData? getUserProfileData;

  bool buttonEnabled = false;

  bool wantAddressField = false;

  @override
  void initState() {
    accountCubit = BlocProvider.of<AccountCubit>(context);
    accountCubit.getVehicleData();
    accountCubit.getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(
          top: 8.0 * SizeConfig.heightMultiplier!,
        ),
        child: SingleChildScrollView(
          child: BlocConsumer<AccountCubit, AccountState>(
            listener: (context, state) {
              if (state is VehicleLoadingSuccessState) {
                data = state.vehicleInformationList.data;
                vehicleInformationList = data;
              }

              if (state is AccountProfileSuccessState) {
                getUserProfileData = state.getUserProfileData;
                ProfileRepository.instance.setVehicleModel(
                    getUserProfileData?.data?.vehicleModel ?? "");
              }
            },
            builder: (context, state) {
              if (state is AccountProfileLoading || state is VehicleLoading) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.0 * SizeConfig.widthMultiplier!),
                  child: Column(
                    children: [
                      CustomSizedBox(
                        height: 90,
                      ),
                      DriverOnboardingScreenShimmer(),
                    ],
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.only(
                    left: 20 * SizeConfig.widthMultiplier!,
                    right: 20 * SizeConfig.widthMultiplier!),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RideBackButton(
                      padding: EdgeInsets.only(top: 40),
                    ),
                    CustomSizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('add_your_vehicle_details'.tr,
                            style: AppTextStyle.text20black0000W600),
                        CustomSizedBox(
                          height: 10,
                        ),
                        Text(
                          'vehicle_type'.tr,
                          style: AppTextStyle.text16black0000W500?.copyWith(
                              color: AppColors.kBlackTextColor
                                  .withOpacity(0.50)),
                        ),
                        CustomSizedBox(
                          height: 10 * SizeConfig.heightMultiplier!,
                        ),
                        Container(
                          height: 45 * SizeConfig.heightMultiplier!,
                          padding: EdgeInsets.only(
                              left: 5 * SizeConfig.widthMultiplier!),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.kBlackTextColor
                                      .withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(
                                  4 * SizeConfig.widthMultiplier!)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: categoryChoose,
                              style: AppTextStyle.text12black0000W400,
                              hint: Text(
                                getUserProfileData?.data?.vehicleCompany
                                            ?.isNotEmpty ==
                                        true
                                    ? getUserProfileData
                                            ?.data?.vehicleCompany ??
                                        ""
                                    : "select_category".tr,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontFamily: "verdana_regular",
                                ),
                              ),
                              items: vehicleInformationList
                                  ?.map<DropdownMenuItem<String>>(
                                      (VehicleData value) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    modelChoose = null;
                                    setState(() {
                                      modelInformationList =
                                          value.vehicleModels;
                                    });
                                  },
                                  value: value.categotyName,
                                  child: Row(
                                    children: [
                                      Text(value.categotyName ?? ""),
                                    ],
                                  ),
                                );
                              }).toList(),
                              isExpanded: true,
                              isDense: true,
                              onChanged: (String? newSelectedModel) {
                                setState(() {
                                  print("");

                                  categoryChoose = newSelectedModel;

                                  validValue();
                                });
                              },
                            ),
                          ),
                        ),
                        CustomSizedBox(
                          height: 10 * SizeConfig.heightMultiplier!,
                        ),
                        Text(
                          'vehicle_model'.tr,
                          style: AppTextStyle.text14black0000W500?.copyWith(
                              color:
                                  AppColors.kBlackTextColor.withOpacity(0.50)),
                        ),
                        CustomSizedBox(
                          height: 12 * SizeConfig.heightMultiplier!,
                        ),
                        Container(
                          height: 45 * SizeConfig.heightMultiplier!,
                          padding: EdgeInsets.only(
                              left: 5 * SizeConfig.widthMultiplier!),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.kBlackTextColor
                                      .withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(
                                  4 * SizeConfig.widthMultiplier!)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: modelChoose,
                              style: AppTextStyle.text12black0000W400,
                              hint: Text(
                                getUserProfileData
                                            ?.data?.vehicleModel?.isNotEmpty ==
                                        true
                                    ? getUserProfileData?.data?.vehicleModel ??
                                        ""
                                    : "select_model".tr,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontFamily: "verdana_regular",
                                ),
                              ),
                              items: modelInformationList
                                  ?.map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                              isExpanded: true,
                              isDense: true,
                              onChanged: (String? newSelectedModelName) {
                                setState(() {
                                  modelChoose = newSelectedModelName;
                                  validValue();
                                });
                              },
                            ),
                          ),
                        ),
                        CustomSizedBox(
                          height: 10 * SizeConfig.heightMultiplier!,
                        ),
                        Text(
                          'vehicle_number'.tr,
                          style: AppTextStyle.text14black0000W500?.copyWith(
                              color:
                                  AppColors.kBlackTextColor.withOpacity(0.50)),
                        ),
                        CustomSizedBox(
                          height: 12 * SizeConfig.heightMultiplier!,
                        ),
                        CustomTextFromField(
                          topPadding: 20 * SizeConfig.heightMultiplier!,
                          textCapitalization: TextCapitalization.characters,
                          customInputFormatters: [UppercaseInputFormatter()],
                          margin: EdgeInsets.zero,
                          controller: vehicleNumberController,
                          hintText: getUserProfileData
                                      ?.data?.vehicleNumber?.isNotEmpty ==
                                  true
                              ? getUserProfileData?.data?.vehicleNumber ?? ""
                              : "enter_vehicle_number_here".tr,
                          onFieldSubmitted: (v) {
                            setState(() {});
                            validValue();
                          },
                          onChanged: (v) {
                            setState(() {});
                            validValue();
                          },
                        ),
                      ],
                    ),
                    CustomSizedBox(
                      height: 10 * SizeConfig.heightMultiplier!,
                    ),
                    Text(
                      'drivers_license'.tr,
                      style: AppTextStyle.text14black0000W500?.copyWith(
                          color: AppColors.kBlackTextColor.withOpacity(0.50)),
                    ),
                    CustomSizedBox(
                      height: 12 * SizeConfig.heightMultiplier!,
                    ),
                    CustomTextFromField(
                      topPadding: 20 * SizeConfig.heightMultiplier!,
                      textCapitalization: TextCapitalization.characters,
                      customInputFormatters: [UppercaseInputFormatter()],
                      margin: EdgeInsets.zero,
                      controller: driverLicenseController,
                      hintText:
                          getUserProfileData?.data?.licenceNumber?.isNotEmpty ==
                                  true
                              ? getUserProfileData?.data?.licenceNumber ?? ""
                              : "enter_drivers_license_number_here".tr,
                      onFieldSubmitted: (v) {
                        setState(() {});
                        validValue();
                      },
                      onChanged: (v) {
                        setState(() {});
                        validValue();
                      },
                    ),
                    CustomSizedBox(
                      height: 25 * SizeConfig.heightMultiplier!,
                    ),
                    BlocConsumer<AccountCubit, AccountState>(
                      listener: (context, state) {
                        if (state is VehicleInfoSuccessState) {
                          accountCubit.getProfileData();
                          accountCubit.getVehicleData();

                          AnywhereDoor.pushReplacementNamed(context,
                              routeName: RouteName.homeScreen);
                        }
                      },
                      builder: (context, state) {
                        return BlueButton(
                          buttonColor: AppColors.kBlue3D6,
                          width: 201 * SizeConfig.widthMultiplier!,
                          height: 43 * SizeConfig.heightMultiplier!,
                          wantMargin: false,
                          borderRadius: 4 * SizeConfig.widthMultiplier!,
                          title: 'save'.tr,
                          isLoading: state is VehicleInfoLoading,
                          buttonIsEnabled: buttonEnabled,
                          onTap: () {
                            accountCubit.postFreshDriverVehicleInfo(
                                activeDriver: false,
                                place: widget.placeShortName,
                                address: widget.address,
                                firstName: widget.name,
                                vehicleModel: categoryChoose,
                                vehicleName: modelChoose,
                                vehicleNumber: vehicleNumberController.text,
                                licenseNumber: driverLicenseController.text,
                                position: widget.position);
                          },
                        );
                      },
                    ),
                    CustomSizedBox(
                      height: 50 * SizeConfig.heightMultiplier!,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  validValue() {
    if (categoryChoose?.isNotEmpty == true &&
        modelChoose?.isNotEmpty == true &&
        vehicleNumberController.text.isNotEmpty == true &&
        driverLicenseController.text.isNotEmpty == true) {
      setState(() {
        buttonEnabled = true;
      });
    }
  }
}

class UppercaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    var result = newValue.text.toUpperCase();

    return newValue.copyWith(
      text: result,
    );
  }
}
