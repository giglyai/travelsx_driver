// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';
import 'package:travelx_driver/user/account/enitity/vehiclelist_with_model/vehicle_with_model.dart';

import '../../../../shared/widgets/buttons/blue_button.dart';
import '../../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../../shared/widgets/size_config/size_config.dart';
import '../../../user_details/user_details_data.dart';
import '../../bloc/account_cubit.dart';
import '../../enitity/profile_model.dart';
import 'driver_onboarding_screen_shimmer.dart';

class VehicleInfoScreen extends StatefulWidget {
  const VehicleInfoScreen({super.key});

  @override
  State<VehicleInfoScreen> createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  late AccountCubit accountCubit;

  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController driverLicenseController = TextEditingController();

  String? categoryChoose;
  String? modelChoose;
  List<VehicleData>? data;
  List<VehicleData>? vehicleInformationList = [];
  List<String>? modelInformationList = [];
  GetUserProfileData? getUserProfileData;
  bool buttonEnabled = false;
  late HomeCubit _homeCubit;

  @override
  void initState() {
    accountCubit = BlocProvider.of<AccountCubit>(context);
    accountCubit.getVehicleData();
    accountCubit.getProfileData();

    _homeCubit = BlocProvider.of<HomeCubit>(context);

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

                ProfileRepository.instance.setVehicleCategory(
                    getUserProfileData?.data?.vehicleModel ?? "");
                ProfileRepository.instance.setVehicleModel(
                    getUserProfileData?.data?.vehicleModel ?? "");

                ProfileRepository.instance.init();
              }
            },
            builder: (context, state) {
              if (state is AccountProfileLoading ||
                  state is VehicleLoading == true) {
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

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20 * SizeConfig.widthMultiplier!,
                        right: 20 * SizeConfig.widthMultiplier!),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RideBackButton(
                          padding: EdgeInsets.only(
                              top: 45 * SizeConfig.heightMultiplier!),
                          onTap: () {
                            AnywhereDoor.pop(context);
                          },
                        ),
                        CustomSizedBox(
                          height: 10,
                        ),
                        Text('add_your_vehicle_details'.tr,
                            style: AppTextStyle.text20black0000W600),
                        CustomSizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'vehicle_type'.tr,
                              style: AppTextStyle.text16black0000W500?.copyWith(
                                  color: AppColors.kBlackTextColor
                                      .withOpacity(0.50)),
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
                                      color: AppColors.kBlackTextColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(
                                      4 * SizeConfig.widthMultiplier!)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: categoryChoose,
                                  style: AppTextStyle.text12black0000W400,
                                  hint: Text(
                                    getUserProfileData?.data?.vehicleModel
                                                ?.isNotEmpty ==
                                            true
                                        ? getUserProfileData
                                                ?.data?.vehicleModel ??
                                            ""
                                        : "select_category".tr,
                                    style: AppTextStyle.text14Black0000W400,
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
                                          Text(
                                            value.categotyName ?? "",
                                            style: AppTextStyle
                                                .text14Black0000W400,
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                  isDense: true,
                                  onChanged: (String? newSelectedCompany) {
                                    setState(() {
                                      print("");

                                      categoryChoose = newSelectedCompany;

                                      validValue();
                                    });
                                  },
                                ),
                              ),
                            ),
                            CustomSizedBox(
                              height: 16 * SizeConfig.heightMultiplier!,
                            ),
                            Text(
                              'vehicle_model'.tr,
                              style: AppTextStyle.text16black0000W500?.copyWith(
                                  color: AppColors.kBlackTextColor
                                      .withOpacity(0.50)),
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
                                      color: AppColors.kBlackTextColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(
                                      4 * SizeConfig.widthMultiplier!)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: modelChoose,
                                  style: AppTextStyle.text12black0000W400,
                                  hint: Text(
                                    getUserProfileData?.data?.vehicleName
                                                ?.isNotEmpty ==
                                            true
                                        ? getUserProfileData
                                                ?.data?.vehicleName ??
                                            ""
                                        : "select_model".tr,
                                    style: AppTextStyle.text14Black0000W400,
                                  ),
                                  items: modelInformationList
                                      ?.map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Row(
                                        children: [
                                          Text(
                                            value,
                                            style: AppTextStyle
                                                .text14Black0000W400,
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                  isDense: true,
                                  onChanged: (String? newSelectedCompany) {
                                    setState(() {
                                      modelChoose = newSelectedCompany;
                                      validValue();
                                    });
                                  },
                                ),
                              ),
                            ),
                            CustomSizedBox(
                              height: 16 * SizeConfig.heightMultiplier!,
                            ),
                            Text(
                              'vehicle_number'.tr,
                              style: AppTextStyle.text16black0000W500?.copyWith(
                                  color: AppColors.kBlackTextColor
                                      .withOpacity(0.50)),
                            ),
                            CustomSizedBox(
                              height: 12 * SizeConfig.heightMultiplier!,
                            ),
                            CustomTextFromField(
                              topPadding: 25,
                              enabledColorBorder: AppColors.kBlackTextColor,
                              textCapitalization: TextCapitalization.characters,
                              customInputFormatters: [
                                UppercaseInputFormatter()
                              ],
                              margin: EdgeInsets.zero,
                              controller: vehicleNumberController,
                              hintText: getUserProfileData
                                          ?.data?.vehicleNumber?.isNotEmpty ==
                                      true
                                  ? getUserProfileData?.data?.vehicleNumber ??
                                      ""
                                  : "enter_vehicle_number_here".tr,
                              hintTextStyle: AppTextStyle.text14Black0000W400,
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
                          height: 16 * SizeConfig.heightMultiplier!,
                        ),
                        Text(
                          'drivers_license'.tr,
                          style: AppTextStyle.text16black0000W500?.copyWith(
                              color:
                                  AppColors.kBlackTextColor.withOpacity(0.50)),
                        ),
                        CustomSizedBox(
                          height: 12 * SizeConfig.heightMultiplier!,
                        ),
                        CustomTextFromField(
                          topPadding: 25,
                          enabledColorBorder: AppColors.kBlackTextColor,
                          textCapitalization: TextCapitalization.characters,
                          customInputFormatters: [UppercaseInputFormatter()],
                          margin: EdgeInsets.zero,
                          controller: driverLicenseController,
                          hintText: getUserProfileData
                                      ?.data?.licenceNumber?.isNotEmpty ==
                                  true
                              ? getUserProfileData?.data?.licenceNumber ?? ""
                              : "enter_drivers_license_number_here".tr,
                          hintTextStyle: AppTextStyle.text14Black0000W400,
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
                  ),
                  CustomSizedBox(
                    height: 60 * SizeConfig.heightMultiplier!,
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
                        height: 43 * SizeConfig.heightMultiplier!,
                        wantMargin: false,
                        borderRadius: 4 * SizeConfig.widthMultiplier!,
                        title: 'save'.tr,
                        isLoading: state is VehicleInfoLoading,
                        buttonIsEnabled: buttonEnabled,
                        onTap: () {
                          if (driverLicenseController.text.isNotEmpty == true) {
                            accountCubit.postDriverVehicleInfo(
                                vehicleName: modelChoose,
                                vehicleCompany: modelChoose ?? "",
                                vehicleModel: categoryChoose ?? "",
                                vehicleNumber: vehicleNumberController.text,
                                licenseNumber: driverLicenseController.text);
                          } else {}

                          setState(() {});
                        },
                      );
                    },
                  )
                ],
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
