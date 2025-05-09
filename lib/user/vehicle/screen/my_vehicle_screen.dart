import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/user/vehicle/bloc/add_vehicle_cubit.dart';

import '../shimmer/select_vehicle_shimmer.dart';

class DriverVehicleScreen extends StatefulWidget {
  const DriverVehicleScreen({super.key});

  @override
  State<DriverVehicleScreen> createState() => _DriverVehicleScreenState();
}

class _DriverVehicleScreenState extends State<DriverVehicleScreen> {
  late AddVehicleCubit myVehicleCubit;

  @override
  void initState() {
    myVehicleCubit = context.read();
    myVehicleCubit.getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (t) {
        AnywhereDoor.pushReplacementNamed(context,
            routeName: RouteName.homeScreen);
      },
      child: Scaffold(
        body: BlocBuilder<AddVehicleCubit, AddVehicleState>(
          builder: (context, state) {
            if (state.getProfileData.success) {
              final getData = state.getUserProfileData?.data;

              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 12 * SizeConfig.widthMultiplier!),
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
                          onTap: () {
                            AnywhereDoor.pushReplacementNamed(context,
                                routeName: RouteName.homeScreen);
                          },
                        ),
                        const Spacer(),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "My Vehicle",
                              style: AppTextStyle.text16kBlack272727W600,
                            ))
                      ],
                    ),
                    CustomSizedBox(
                      height: 20,
                    ),
                    if (getData?.vehicleType?.isNotEmpty == true)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5 * SizeConfig.heightMultiplier!,
                            horizontal: 8 * SizeConfig.widthMultiplier!),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10 * SizeConfig.heightMultiplier!,
                              horizontal: 12 * SizeConfig.widthMultiplier!),
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(
                                6 * SizeConfig.widthMultiplier!),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    AppColors.kBlackTextColor.withOpacity(0.15),
                                blurRadius: 3, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: PopupMenuButton<int>(
                                      color: AppColors.kWhite,
                                      surfaceTintColor: AppColors.kWhite,
                                      shadowColor: AppColors.kWhite,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10 *
                                                  SizeConfig.widthMultiplier!),
                                              bottomLeft: Radius.circular(10 *
                                                  SizeConfig.widthMultiplier!),
                                              bottomRight: Radius.circular(10 *
                                                  SizeConfig
                                                      .widthMultiplier!))),
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem<int>(
                                              onTap: () {
                                                myVehicleCubit
                                                    .deleteMyVehiclePop(
                                                        context: context);
                                              },
                                              child: Text(
                                                "Delete",
                                                style: AppTextStyle
                                                    .text14black0000W700,
                                              )),
                                          PopupMenuItem<int>(
                                              onTap: () {},
                                              child: Text(
                                                "Cancel",
                                                style: AppTextStyle
                                                    .text14black0000W700,
                                              )),
                                        ];
                                      },
                                      child: ImageLoader.svgPictureAssetImage(
                                        width: 20 * SizeConfig.widthMultiplier!,
                                        height:
                                            20 * SizeConfig.heightMultiplier!,
                                        imagePath: ImagePath.deleteIcon,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              CustomSizedBox(
                                height: 6,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (getData?.vehicleType?.toLowerCase() ==
                                          "maxicab" ||
                                      (getData?.vehicleType?.toLowerCase() ==
                                          "maxicab coach"))
                                    ImageLoader.assetImage(
                                      width: 50 * SizeConfig.widthMultiplier!,
                                      height: 50 * SizeConfig.heightMultiplier!,
                                      imagePath: ImagePath.maxicabcar,
                                      wantsScale: true,
                                      scale: 1.2,
                                    ),
                                  if (getData?.vehicleType?.toLowerCase() ==
                                          "sedan" ||
                                      (getData?.vehicleType?.toLowerCase() ==
                                          "prime sedan"))
                                    ImageLoader.assetImage(
                                      width: 50 * SizeConfig.widthMultiplier!,
                                      height: 50 * SizeConfig.heightMultiplier!,
                                      imagePath: ImagePath.sedancar,
                                      wantsScale: true,
                                      scale: 1.2,
                                    ),
                                  if (getData?.vehicleType?.toLowerCase() ==
                                          "suv" ||
                                      (getData?.vehicleType?.toLowerCase() ==
                                          "prime suv"))
                                    ImageLoader.assetImage(
                                      width: 50 * SizeConfig.widthMultiplier!,
                                      height: 50 * SizeConfig.heightMultiplier!,
                                      imagePath: ImagePath.suvcar,
                                      wantsScale: true,
                                      scale: 1.2,
                                    ),
                                  if (getData?.vehicleType?.toLowerCase() ==
                                      "mini")
                                    ImageLoader.assetImage(
                                      width: 50 * SizeConfig.widthMultiplier!,
                                      height: 50 * SizeConfig.heightMultiplier!,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 120 *
                                                SizeConfig.widthMultiplier!,
                                            child: Text(
                                              getData?.vehicleType
                                                      ?.capitalize() ??
                                                  "",
                                              style: AppTextStyle
                                                  .text14black0000W700,
                                            ),
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
                                                  .text14black0000W400,
                                            ),
                                          ),
                                          Text(
                                            getData?.vehicleModel ?? "",
                                            style: AppTextStyle
                                                .text14black0000W400,
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
                                                  .text14black0000W400,
                                            ),
                                          ),
                                          Text(
                                            getData?.vehicleNumber ?? "",
                                            style: AppTextStyle
                                                .text14black0000W400,
                                          ),
                                        ],
                                      ),
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
                      )
                    else
                      Column(
                        children: [
                          CustomSizedBox(
                            height: 150,
                          ),
                          Center(
                            child: Text(
                              "Add your vehicle",
                              style: AppTextStyle.text16black0000W700,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              );
            }
            return const SelectVehicleScreenShimmer();
          },
        ),
      ),
    );
  }
}
