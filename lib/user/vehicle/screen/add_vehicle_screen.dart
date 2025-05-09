import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/cutom_drop_down/custom_drop_down.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';
import 'package:travelx_driver/user/vehicle/bloc/add_vehicle_cubit.dart';
import 'package:travelx_driver/user/vehicle/shimmer/select_vehicle_shimmer.dart';

import '../../account/screen/vehicle/driver_onboarding_screen.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  late AddVehicleCubit addVehicleCubit;

  @override
  void initState() {
    addVehicleCubit = context.read();
    addVehicleCubit.flushVehicleData();
    addVehicleCubit.getVehicleListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<AddVehicleCubit, AddVehicleState>(
          builder: (context, state) {
            if (state.vehicleListModelApiStatus.success) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSizedBox(
                        width: 10,
                      ),
                      RideBackButton(
                        padding: EdgeInsets.zero,
                      ),
                      const Spacer(),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Add Vehicle",
                            style: AppTextStyle.text16black0000W600,
                          )),
                      const Spacer(),
                    ],
                  ),
                  CustomSizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16 * SizeConfig.widthMultiplier!),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Add your vehicle",
                          style: AppTextStyle.text20black0000W500,
                        ),
                        CustomSizedBox(
                          height: 10,
                        ),
                        Text(
                          "Add your vehicle details.",
                          style: AppTextStyle.text14Black0000W300,
                        ),
                        CustomSizedBox(
                          height: 23,
                        ),
                        Text(
                          "Vehicle type",
                          style: AppTextStyle.text14black0000W400,
                        ),
                        CustomSizedBox(
                          height: 5,
                        ),
                        CustomDropDown(
                          borderColor: state.addVehicleType.errorColor,
                          controller: state.addVehicleType.value,
                          onTapToHideAndShowDropDown: () {
                            addVehicleCubit.toggleAddVehicleTypeListIsOpened();
                          },
                          dropDownListIsOpened:
                              state.addVehicleTypeListIsOpened,
                          getListUI: Wrap(
                            children: List.generate(
                                state.vehicleInformationList?.length ?? 0,
                                (index) {
                              final data = state.vehicleInformationList?[index];
                              return GestureDetector(
                                onTap: () {
                                  addVehicleCubit
                                      .onAddVehicleTypeChanges(false);

                                  addVehicleCubit.onModelInformationListChanged(
                                      modelInformationList:
                                          data?.vehicleModels);
                                  addVehicleCubit
                                      .onAddVehicleTypeControllerChanged(
                                    name: state.vehicleInformationList?[index]
                                            .categotyName ??
                                        "",
                                  );
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          10 * SizeConfig.widthMultiplier!,
                                      vertical:
                                          10 * SizeConfig.heightMultiplier!,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.kGreyFAF9F9,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          data?.categotyName ?? "",
                                          style: AppTextStyle
                                              .text14kblack333333W600,
                                        ),
                                        Spacer(),
                                        Text("")
                                      ],
                                    )),
                              );
                            }),
                          ),
                        ),
                        CustomSizedBox(
                          height: 20,
                        ),
                        Text(
                          "Vehicle Model",
                          style: AppTextStyle.text14black0000W400,
                        ),
                        CustomSizedBox(
                          height: 5,
                        ),
                        CustomDropDown(
                          borderColor: state.addVehicleModel.errorColor,
                          controller: state.addVehicleModel.value,
                          onTapToHideAndShowDropDown: () {
                            addVehicleCubit.toggleAddVehicleModelListIsOpened();
                          },
                          dropDownListIsOpened:
                              state.addVehicleModelListIsOpened,
                          getListUI: Wrap(
                            children: List.generate(
                                state.modelInformationList?.length ?? 0,
                                (index) {
                              final data = state.modelInformationList?[index];
                              return GestureDetector(
                                onTap: () {
                                  addVehicleCubit
                                      .onAddVehicleModelChanges(false);

                                  addVehicleCubit
                                      .onAddVehicleModelControllerChanged(
                                    name: state.modelInformationList?[index] ??
                                        "",
                                  );
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          10 * SizeConfig.widthMultiplier!,
                                      vertical:
                                          10 * SizeConfig.heightMultiplier!,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.kGreyFAF9F9,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          data ?? "",
                                          style: AppTextStyle
                                              .text14kblack333333W600,
                                        ),
                                        const Spacer(),
                                        const Text("")
                                      ],
                                    )),
                              );
                            }),
                          ),
                        ),
                        CustomSizedBox(
                          height: 20,
                        ),
                        Text(
                          "Vehicle Number",
                          style: AppTextStyle.text14black0000W400,
                        ),
                        CustomSizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0 * SizeConfig.widthMultiplier!),
                          child: CustomTextFromField(
                            textCapitalization: TextCapitalization.characters,
                            customInputFormatters: [UppercaseInputFormatter()],
                            margin: EdgeInsets.zero,
                            controller: state.addVehiclePlateNumber.value,
                            errorText: state.addVehiclePlateNumber.error,
                            onChanged:
                                addVehicleCubit.onAddVehiclePlateNumberChanged,
                            topPadding: 20 * SizeConfig.heightMultiplier!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomSizedBox(
                    height: 50,
                  ),
                  BlueButton(
                    buttonIsEnabled: addVehicleCubit.isAddVehicleIsValid,
                    isLoading: state.addManualVehicleApiStatus.isLoading,
                    onTap: addVehicleCubit.addVehicleDetails,
                  ),
                  CustomSizedBox(
                    height: 50,
                  ),
                ],
              );
            }

            if (state.vehicleListModelApiStatus.failure) {
              return const Text("Something went wrong");
            }
            return const SelectVehicleScreenShimmer();
          },
        ),
      ),
    );
  }
}
