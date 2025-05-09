import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/app_styles/app_styles.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../bloc/promotion_cubit.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({Key? key}) : super(key: key);

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen>
    with SingleTickerProviderStateMixin {
  late PromotionCubit promotionCubit;
  late TabController _tabController;

  @override
  void initState() {
    promotionCubit = BlocProvider.of<PromotionCubit>(context);
    promotionCubit.fetchActivePromotion();
    // Specifies number of Tabs here
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  int? controllerTab = 0;
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // _homeCubit.updateRiderAvailabilityStatus(
        //   availabilityStatus: true,
        // );
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RideBackButton(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 50 * SizeConfig.widthMultiplier!,
                    right: 50 * SizeConfig.widthMultiplier!),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kGreyF4F3F4,
                      borderRadius: BorderRadius.only(
                        topRight:
                            Radius.circular(10 * SizeConfig.widthMultiplier!),
                        topLeft:
                            Radius.circular(10 * SizeConfig.widthMultiplier!),
                      )),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: AppColors.kBlackTextColor,
                    indicatorColor: AppColors.kBlue3D6,
                    isScrollable: false,
                    onTap: (controller) {
                      setState(() {
                        controllerTab = controller;
                      });

                      if (controller == 0) {
                        promotionCubit.fetchActivePromotion();
                      } else if (controller == 1) {
                        promotionCubit.fetchCompletedPromotion();
                      }
                    },
                    tabs: [
                      Tab(
                        child: Text(
                          "active".tr,
                          style: TextStyle(
                            color: controllerTab == 0
                                ? AppColors.kBlue3D6
                                : AppColors.kGrey433C3C.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            fontSize: 16 * SizeConfig.textMultiplier!,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "completed".tr,
                          style: TextStyle(
                            color: controllerTab == 1
                                ? AppColors.kBlue3D6.withOpacity(0.7)
                                : AppColors.kGrey433C3C.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            fontSize: 16 * SizeConfig.textMultiplier!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 26 * SizeConfig.widthMultiplier!,
              ),
              BlocBuilder<PromotionCubit, PromotionState>(
                builder: (context, state) {
                  if (state is GotActivePromotionSuccess) {
                    return Wrap(
                      children: List.generate(
                        state.activeCompletedPromotion.data?.length ?? 0,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              left: 20 * SizeConfig.widthMultiplier!,
                              right: 20 * SizeConfig.widthMultiplier!,
                              bottom: 10 * SizeConfig.heightMultiplier!),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 12 * SizeConfig.heightMultiplier!,
                                bottom: 12 * SizeConfig.heightMultiplier!,
                                left: 13 * SizeConfig.widthMultiplier!,
                                right: 13 * SizeConfig.widthMultiplier!),
                            decoration: BoxDecoration(
                                color: AppColors.kGreyF4F3F4,
                                borderRadius: BorderRadius.circular(
                                    10 * SizeConfig.widthMultiplier!)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.activeCompletedPromotion.data?[index]
                                          .title ??
                                      "",
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: AppColors.kBlackTextColor,
                                      fontSize: 16 * SizeConfig.textMultiplier!,
                                      fontWeight: FontWeight.w500),
                                ),
                                CustomSizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${state.activeCompletedPromotion.data?[index].deliveryCompletedMsg}",
                                        style: TextStyle(
                                            color: AppColors.kBlackTextColor,
                                            fontSize:
                                                14 * SizeConfig.textMultiplier!,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    Text(
                                      "${state.activeCompletedPromotion.data?[index].daysLeftMsg}",
                                      style: TextStyle(
                                          color: AppColors.kBlackTextColor,
                                          fontSize:
                                              14 * SizeConfig.textMultiplier!,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 250 * SizeConfig.widthMultiplier!,
                                      child: SfSlider(
                                        showLabels: false,
                                        showTicks: false,
                                        showDividers: false,
                                        activeColor: AppColors.kBlackTextColor,
                                        inactiveColor:
                                            AppColors.dividerwhiteE2E2,
                                        min: 0,
                                        max: state.activeCompletedPromotion
                                            .data?[index].totalDelivery
                                            ?.toDouble(),
                                        value: state.activeCompletedPromotion
                                            .data?[index].completedDelivery
                                            ?.toDouble(),
                                        onChanged: (dynamic newValue) {
                                          // setState(() {
                                          //   state.activeCompletedPromotion.data?[index]
                                          //       .completedDelivery.toDouble() = newValue;
                                          // });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is GotCompletedPromotionSuccess) {
                    return Wrap(
                      children: List.generate(
                        state.activeCompletedPromotion.data?.length ?? 0,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              left: 20 * SizeConfig.widthMultiplier!,
                              right: 20 * SizeConfig.widthMultiplier!,
                              bottom: 10 * SizeConfig.heightMultiplier!),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 12 * SizeConfig.heightMultiplier!,
                                bottom: 12 * SizeConfig.heightMultiplier!,
                                left: 13 * SizeConfig.widthMultiplier!,
                                right: 13 * SizeConfig.widthMultiplier!),
                            decoration: BoxDecoration(
                                color: AppColors.kGreyF4F3F4,
                                borderRadius: BorderRadius.circular(
                                    10 * SizeConfig.widthMultiplier!)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.activeCompletedPromotion.data?[index]
                                          .title ??
                                      "",
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: AppColors.kBlackTextColor,
                                      fontSize: 16 * SizeConfig.textMultiplier!,
                                      fontWeight: FontWeight.w500),
                                ),
                                CustomSizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${state.activeCompletedPromotion.data?[index].deliveryCompletedMsg}",
                                        style: TextStyle(
                                            color: AppColors.kBlackTextColor,
                                            fontSize:
                                                14 * SizeConfig.textMultiplier!,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    Text(
                                      "${state.activeCompletedPromotion.data?[index].daysLeftMsg}",
                                      style: TextStyle(
                                          color: AppColors.kBlackTextColor,
                                          fontSize:
                                              14 * SizeConfig.textMultiplier!,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 250 * SizeConfig.widthMultiplier!,
                                      child: SfSlider(
                                        showLabels: false,
                                        showTicks: false,
                                        showDividers: false,
                                        activeColor: AppColors.kBlackTextColor,
                                        inactiveColor:
                                            AppColors.dividerwhiteE2E2,
                                        min: 0,
                                        max: state.activeCompletedPromotion
                                            .data?[index].totalDelivery
                                            ?.toDouble(),
                                        value: state.activeCompletedPromotion
                                            .data?[index].completedDelivery
                                            ?.toDouble(),
                                        onChanged: (dynamic newValue) {
                                          // setState(() {
                                          //   state.activeCompletedPromotion.data?[index]
                                          //       .completedDelivery.toDouble() = newValue;
                                          // });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is GotPromotionEmptyState) {
                    return Center(
                        child: Text(
                      state.message,
                      style: AppTextStyle.text16black0000W600?.copyWith(
                          color: AppColors.kBlackTextColor.withOpacity(0.50)),
                    ));
                  }
                  if (state is CompletedPromotionLoading) {
                    return Center(
                      child: Lottie.asset(ImagePath.loadingAnimation,
                          height: 50 * SizeConfig.heightMultiplier!,
                          width: 300 * SizeConfig.widthMultiplier!),
                    );
                  }
                  if (state is ActivePromotionLoading) {
                    return Center(
                      child: Lottie.asset(ImagePath.loadingAnimation,
                          height: 50 * SizeConfig.heightMultiplier!,
                          width: 300 * SizeConfig.widthMultiplier!),
                    );
                  }

                  return Center(child: Text("no_data_available".tr));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
