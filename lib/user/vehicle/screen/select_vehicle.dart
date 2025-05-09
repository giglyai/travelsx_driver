import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/widgets/container_with_border/container_with_border.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/user/vehicle/bloc/add_vehicle_cubit.dart';

import '../shimmer/select_vehicle_shimmer.dart';

class SelectVehicleScreen extends StatefulWidget {
  const SelectVehicleScreen({super.key});

  @override
  State<SelectVehicleScreen> createState() => _SelectVehicleScreenState();
}

class _SelectVehicleScreenState extends State<SelectVehicleScreen> {
  late AddVehicleCubit selectVehicleCubit;

  int? selectedIndex;

  @override
  void initState() {
    selectVehicleCubit = context.read();
    selectVehicleCubit.getTravelCarList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddVehicleCubit, AddVehicleState>(
        builder: (context, state) {
          if (state.getTravelVehicleListDataApiStatus.success) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 12 * SizeConfig.widthMultiplier!),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CustomSizedBox(
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RideBackButton(
                          padding: EdgeInsets.zero,
                        ),
                        const Spacer(),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Select Vehicle",
                              style: AppTextStyle.text16kBlack272727W600,
                            )),
                      ],
                    ),
                    CustomSizedBox(
                      height: 20,
                    ),
                    Wrap(
                      children: List.generate(
                          state.getTravelVehicleListData?.data?.allVehicles
                                  ?.length ??
                              0, (index) {
                        final data = state.getTravelVehicleListData?.data
                            ?.allVehicles?[index];

                        return GestureDetector(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.heightMultiplier!,
                                horizontal: 8 * SizeConfig.widthMultiplier!),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10 * SizeConfig.heightMultiplier!,
                                  horizontal: 12 * SizeConfig.widthMultiplier!),
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? AppColors.kGreyF4F4
                                    : AppColors.kWhite,
                                borderRadius: BorderRadius.circular(
                                    6 * SizeConfig.widthMultiplier!),
                                border: Border.all(
                                    color: selectedIndex == index
                                        ? AppColors.kBlue3D6
                                        : Colors.transparent,
                                    width: 1.5 * SizeConfig.widthMultiplier!),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.15),
                                    blurRadius: 3, // soften the shadow
                                    spreadRadius: 1.0, //extend the shadow
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  CustomSizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (data?.vehicleModel?.toLowerCase() ==
                                              "maxicab" ||
                                          (data?.vehicleModel?.toLowerCase() ==
                                              "maxicab coach"))
                                        ImageLoader.assetImage(
                                          width:
                                              50 * SizeConfig.widthMultiplier!,
                                          height:
                                              50 * SizeConfig.heightMultiplier!,
                                          imagePath: ImagePath.maxicabcar,
                                          wantsScale: true,
                                          scale: 1.2,
                                        ),
                                      if (data?.vehicleModel?.toLowerCase() ==
                                              "sedan" ||
                                          (data?.vehicleModel?.toLowerCase() ==
                                              "prime sedan"))
                                        ImageLoader.assetImage(
                                          width:
                                              50 * SizeConfig.widthMultiplier!,
                                          height:
                                              50 * SizeConfig.heightMultiplier!,
                                          imagePath: ImagePath.sedancar,
                                          wantsScale: true,
                                          scale: 1.2,
                                        ),
                                      if (data?.vehicleModel?.toLowerCase() ==
                                              "suv" ||
                                          (data?.vehicleModel?.toLowerCase() ==
                                              "prime suv"))
                                        ImageLoader.assetImage(
                                          width:
                                              50 * SizeConfig.widthMultiplier!,
                                          height:
                                              50 * SizeConfig.heightMultiplier!,
                                          imagePath: ImagePath.suvcar,
                                          wantsScale: true,
                                          scale: 1.2,
                                        ),
                                      if (data?.vehicleModel?.toLowerCase() ==
                                          "mini")
                                        ImageLoader.assetImage(
                                          width:
                                              50 * SizeConfig.widthMultiplier!,
                                          height:
                                              50 * SizeConfig.heightMultiplier!,
                                          imagePath: ImagePath.minicar,
                                          wantsScale: true,
                                          scale: 1.2,
                                        ),
                                      CustomSizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 120 *
                                                    SizeConfig.widthMultiplier!,
                                                child: Text(
                                                  "Vehicle Type",
                                                  style: AppTextStyle
                                                      .text12black0000W400,
                                                ),
                                              ),
                                              Text(
                                                data?.vehicleModel ?? "",
                                                style: AppTextStyle
                                                    .text12black0000W400,
                                              ),
                                            ],
                                          ),
                                          CustomSizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 120 *
                                                    SizeConfig.widthMultiplier!,
                                                child: Text(
                                                  "Model",
                                                  style: AppTextStyle
                                                      .text12black0000W400,
                                                ),
                                              ),
                                              Text(
                                                data?.vehicleType ?? "",
                                                style: AppTextStyle
                                                    .text12black0000W400,
                                              ),
                                            ],
                                          ),
                                          CustomSizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 120 *
                                                    SizeConfig.widthMultiplier!,
                                                child: Text(
                                                  "Vehicle Number",
                                                  style: AppTextStyle
                                                      .text12black0000W400,
                                                ),
                                              ),
                                              Text(
                                                data?.vehicleNumber ?? "",
                                                style: AppTextStyle
                                                    .text12black0000W400,
                                              ),
                                            ],
                                          ),
                                          CustomSizedBox(
                                            height: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              selectedIndex = index;
                                              selectVehicleCubit
                                                  .onVehicleTypeChanged(
                                                      data?.vehicleType);
                                              selectVehicleCubit
                                                  .onVehicleModelChanged(
                                                      data?.vehicleModel);
                                              selectVehicleCubit
                                                  .onVehiclePlateNumberChanged(
                                                      data?.vehicleNumber);
                                              selectVehicleCubit
                                                  .confirmSelectVehiclePopUp(
                                                      context: context);
                                              setState(() {});
                                            },
                                            child: ContainerWithBorder(
                                              width: 216 *
                                                  SizeConfig.widthMultiplier!,
                                              height: 22 *
                                                  SizeConfig.heightMultiplier!,
                                              containerColor:
                                                  AppColors.kRedF3E6E6,
                                              borderColor: AppColors.kRedF3E6E6,
                                              borderRadius: 9 *
                                                  SizeConfig.widthMultiplier!,
                                              wantPadding: true,
                                              child: Center(
                                                child: Text(
                                                  "Select",
                                                  style: AppTextStyle
                                                      .text15black0000W500,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  CustomSizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.getTravelVehicleListDataApiStatus.failure) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 12 * SizeConfig.widthMultiplier!),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CustomSizedBox(
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RideBackButton(
                          padding: EdgeInsets.zero,
                        ),
                        const Spacer(),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Select Vehicle",
                              style: AppTextStyle.text16black0000W500,
                            )),
                      ],
                    ),
                    CustomSizedBox(height: 100,),
                    Text("No Data Available")
                  ],
                ),
              ),
            );
          }

          return const SelectVehicleScreenShimmer();
        },
      ),
    );
  }
}
