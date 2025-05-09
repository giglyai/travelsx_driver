import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travelx_driver/home/revamp/bloc/main_home_cubit.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/revamp/imagePath/new_imagePath.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/cutom_drop_down/inventory_drop/inventory_drop_down.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/user/account/enitity/profile_model.dart';

import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../entity/dlvy_biz_overview_entity.dart';

class HomeWidgets {
  /// Floating Action Button Logic
  static Widget floatingActionButton({
    required BuildContext context,
    required MainHomeCubit mainHomeCubit,
    required DraggableScrollableController newOrderController,
    required MainHomeState state,
  }) {
    if (state.upComingRideData?.data?.upcomingRide?.isNotEmpty == true ||
        state.upComingRideData?.data?.newRide?.isNotEmpty == true &&
            state.isOnTripBottomSheetIsOpen == true) {
      return mainHomeCubit.showAcceptedRideBottomSheet();
    } else if (state.getUserProfileData != null &&
        state.getUserProfileData!.data != null &&
        state.getUserProfileData!.data!.missingDocs?.isNotEmpty == true &&
        state.isOnTripBottomSheetIsOpen == true) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        child: mainHomeCubit.showDocumentUploadBottomSheet(),
      );
    } else if (state.getUserProfileData != null &&
        state.getUserProfileData!.data != null &&
        state.getUserProfileData!.data!.accountStatus == 'pending' &&
        state.isOnTripBottomSheetIsOpen == true) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        child: mainHomeCubit.showAccountNotVerifiedStatusBottomSheet(),
      );
    }
    return const SizedBox.shrink(); // Hide if no bottom sheet is needed
  }

  /// Top Menu Icon
  static Widget topBarMenuIcon({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24 * SizeConfig.widthMultiplier!,
        top: 10 * SizeConfig.heightMultiplier!,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteName.homeDrawer);
        },
        child: Container(
          padding: EdgeInsets.all(10 * SizeConfig.widthMultiplier!),
          decoration: BoxDecoration(
            color: AppColors.kGreen4DA461,
            borderRadius: BorderRadius.circular(
              37 * SizeConfig.widthMultiplier!,
            ),
          ),
          child: Icon(Icons.menu, color: Colors.white),
        ),
      ),
    );
  }

  /// Online/Offline Switch
  static Widget onlineOfflineSwitch({
    required Function(bool) onToggle,
    required bool value,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10 * SizeConfig.heightMultiplier!,
        right: 20 * SizeConfig.widthMultiplier!,
      ),
      child: FlutterSwitch(
        showOnOff: true,
        value: value,
        width: 92 * SizeConfig.widthMultiplier!,
        height: 32 * SizeConfig.heightMultiplier!,
        activeColor: AppColors.kGreen4DA461,
        inactiveColor: AppColors.kRedA65757,
        activeText: 'Online',
        inactiveText: 'Offline',
        valueFontSize: 14 * SizeConfig.textMultiplier!,
        onToggle: onToggle,
      ),
    );
  }

  /// Business Overview Section
  static Widget businessOverview({
    required BuildContext context,
    DriverHomeData? getHomeData,
    String? firstName,
    required Function(String?) onChanged,
    required String selectedDate,
    required List<String> earningActivityList,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15 * SizeConfig.widthMultiplier!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(firstName ?? "", style: AppTextStyle.text24black0000W400),
          CustomSizedBox(height: 10),
          CustomSizedBox(height: 15),
          Text("Business Overview", style: AppTextStyle.text14black0000W500),
          CustomSizedBox(height: 2),
          Text(
            "Get all the information of your business",
            style: AppTextStyle.text12kGrey909093W400,
          ),
          CustomSizedBox(height: 15),
          HomeScreenDropDown(
            items: earningActivityList,
            selectedItem: selectedDate,
            onChanged: onChanged,
          ),
          CustomSizedBox(height: 20),
          revenueSection(
            currency: getHomeData?.revenue?.currency,
            amount: getHomeData?.revenue?.amount.toString(),
          ),
          CustomSizedBox(height: 10),
        ],
      ),
    );
  }

  /// Order Details Section
  static Widget orderDetails({
    required BuildContext context,
    DriverHomeData? getHomeData,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * SizeConfig.widthMultiplier!,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              orderDetailsCard(
                count: getHomeData?.all,
                title: "All",
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => OrderReadyScreen(
                  //               fromHome: true,
                  //               orderStatus: OrderStatus.all,
                  //             )));
                },
              ),
              orderDetailsCard(
                title: "Assigned",
                count: getHomeData?.acceptedCount,
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => OrderReadyScreen(
                  //               fromHome: true,
                  //               orderStatus: OrderStatus.acceptedOrder,
                  //             )));
                },
              ),
            ],
          ),
          CustomSizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              orderDetailsCard(
                title: "Completed",
                count: getHomeData?.completedCount,
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => OrderReadyScreen(
                  //               fromHome: true,
                  //               orderStatus: OrderStatus.delivered,
                  //             )));
                },
              ),
              orderDetailsCard(
                title: "Cancelled",
                count: getHomeData?.cancelledCount,
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => OrderReadyScreen(
                  //               fromHome: true,
                  //               orderStatus: OrderStatus.cancel,
                  //             )));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Missing Documents Banner
  static Widget missingDocumentsBanner({
    GetUserProfileData? profileData,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(color: AppColors.kPinkFFF3F0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15 * SizeConfig.widthMultiplier!,
          vertical: 10 * SizeConfig.heightMultiplier!,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageLoader.svgPictureAssetImage(
                  imagePath: NewImagePath.errorWarning,
                  width: 24 * SizeConfig.widthMultiplier!,
                  height: 24 * SizeConfig.heightMultiplier!,
                ),
                CustomSizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Missing Documents (${profileData?.data?.missingDocs?.length})",
                      style: AppTextStyle.text12black0000W400,
                    ),
                    CustomSizedBox(height: 2),
                    Text(
                      "Complete your profile",
                      style: AppTextStyle.text10black0000W300,
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5 * SizeConfig.heightMultiplier!,
              ),
              child: BlueButton(
                wantMargin: false,
                borderColor: AppColors.kGreenF4B5A4,
                borderRadius: 8 * SizeConfig.widthMultiplier!,
                buttonColor: AppColors.darkGreen59BF70,
                width: 88 * SizeConfig.widthMultiplier!,
                height: 26 * SizeConfig.heightMultiplier!,
                title: "Add Now",
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Missing Vehicle Banner
  static Widget missingVehicleBanner({
    GetUserProfileData? profileData,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(color: AppColors.kPinkFFF3F0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15 * SizeConfig.widthMultiplier!,
          vertical: 10 * SizeConfig.heightMultiplier!,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageLoader.svgPictureAssetImage(
                  imagePath: NewImagePath.errorWarning,
                  width: 24 * SizeConfig.widthMultiplier!,
                  height: 24 * SizeConfig.heightMultiplier!,
                ),
                CustomSizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Vehicle",
                      style: AppTextStyle.text12black0000W400,
                    ),
                    CustomSizedBox(height: 2),
                    Text(
                      "Complete your profile",
                      style: AppTextStyle.text10black0000W300,
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5 * SizeConfig.heightMultiplier!,
              ),
              child: BlueButton(
                wantMargin: false,
                borderColor: AppColors.kGreenF4B5A4,
                borderRadius: 8 * SizeConfig.widthMultiplier!,
                buttonColor: AppColors.darkGreen59BF70,
                width: 80 * SizeConfig.widthMultiplier!,
                height: 26 * SizeConfig.heightMultiplier!,
                title: "Add Now",
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget revenueSection({String? currency, String? amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(5 * SizeConfig.widthMultiplier!),
              decoration: BoxDecoration(
                color: AppColors.kLightBlueF6F6F6,
                borderRadius: BorderRadius.circular(
                  37 * SizeConfig.widthMultiplier!,
                ),
              ),
              child: ImageLoader.svgPictureAssetImage(
                imagePath: NewImagePath.moneyIcon,
                width: 20 * SizeConfig.widthMultiplier!,
                height: 20 * SizeConfig.heightMultiplier!,
                color: AppColors.kGreen4DA461,
              ),
            ),
            CustomSizedBox(width: 8),
            Text("Total Revenue", style: AppTextStyle.text20black0000W500),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount.toString(),
              style: AppTextStyle.text35kkBlue053688W700?.copyWith(height: 1),
              textAlign: TextAlign.center,
            ),
            Text(
              currency ?? "",
              style: AppTextStyle.text14kkBlue053688W300?.copyWith(height: 1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  static orderDetailsCard({
    String? title,
    int? count,
    VoidCallback? onTap,
    bool isDeviceIpad = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 158 * SizeConfig.widthMultiplier!,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5 * SizeConfig.widthMultiplier!),
          color: AppColors.kLightFFEFEF,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 12 * SizeConfig.widthMultiplier!,
            top: 8 * SizeConfig.widthMultiplier!,
            bottom: 5 * SizeConfig.heightMultiplier!,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    style: AppTextStyle.text14kBlue4476D9W500?.copyWith(
                      color: AppColors.kBlackTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize:
                          isDeviceIpad
                              ? 15 * SizeConfig.textMultiplier!
                              : 12 * SizeConfig.textMultiplier!,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(6 * SizeConfig.widthMultiplier!),
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(
                        6 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                    child: ImageLoader.svgPictureAssetImage(
                      imagePath: NewImagePath.rightArrowIcon,
                      height: 18 * SizeConfig.heightMultiplier!,
                      width: 18 * SizeConfig.heightMultiplier!,
                    ),
                  ),
                  CustomSizedBox(width: 8),
                ],
              ),
              Text(
                "${count ?? 0.toString()}",
                style: AppTextStyle.text14kBlue4476D9W500?.copyWith(
                  color: AppColors.kGrey909093,
                  fontWeight: FontWeight.w500,
                  fontSize:
                      isDeviceIpad
                          ? 20 * SizeConfig.textMultiplier!
                          : 30 * SizeConfig.textMultiplier!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget noNewOrder({required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(color: AppColors.kPinkFFF3F0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15 * SizeConfig.widthMultiplier!,
          vertical: 10 * SizeConfig.heightMultiplier!,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ImageLoader.svgPictureAssetImage(
                    imagePath: NewImagePath.shoppingCartIcon,
                    width: 25 * SizeConfig.widthMultiplier!,
                    height: 25 * SizeConfig.heightMultiplier!,
                  ),
                ),
                CustomSizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Waiting for orders",
                      style: AppTextStyle.text12black0000W400,
                    ),
                    CustomSizedBox(height: 2),
                    Text(
                      "we’ll notify you when you get an order!",
                      style: AppTextStyle.text10black0000W300,
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ImageLoader.svgPictureAssetImage(
                        color: AppColors.kBlackTextColor,
                        imagePath: NewImagePath.refreshIcons,
                        width: 30 * SizeConfig.widthMultiplier!,
                        height: 30 * SizeConfig.heightMultiplier!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget noData({
    required BuildContext context,
    required Function(bool) onToggle,
    required bool value,
  }) {
    return Column(
      children: [
        CustomSizedBox(height: 50),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteName.homeDrawer);
          },
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 28 * SizeConfig.widthMultiplier!,
                top: 20 * SizeConfig.heightMultiplier!,
              ),
              child: Row(
                children: [
                  ImageLoader.svgPictureAssetImage(
                    imagePath: NewImagePath.menuIcon,
                    width: 40 * SizeConfig.imageSizeMultiplier!,
                  ),
                  CustomSizedBox(width: 85),
                  FlutterSwitch(
                    showOnOff: true,
                    value: value,
                    width: 92,
                    height: 32,
                    activeTextFontWeight: FontWeight.w400,
                    activeColor: Colors.green,
                    inactiveColor: AppColors.kRedA65757,
                    activeToggleColor: Colors.white,
                    inactiveToggleColor: AppColors.kRed4E18,
                    activeText: 'Online',
                    inactiveText: 'Offline',
                    activeTextColor: AppColors.kWhiteFFFF,
                    inactiveTextColor: AppColors.kRed4E18,
                    onToggle: onToggle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget newDriverHomeShimmer() {
    Color containerColor = Colors.grey.withOpacity(0.3);
    Color baseColor = Colors.grey.withOpacity(0.25);
    Color highlightColor = Colors.white.withOpacity(0.6);
    return Padding(
      padding: EdgeInsets.only(bottom: 190 * SizeConfig.heightMultiplier!),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(color: AppColors.kWhite),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.widthMultiplier! * 26,
                  right: SizeConfig.widthMultiplier! * 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10 * SizeConfig.heightMultiplier!,
                      ),
                      child: Shimmer.fromColors(
                        highlightColor: highlightColor,
                        baseColor: baseColor,
                        child: Container(
                          width: SizeConfig.widthMultiplier! * 328,
                          height: SizeConfig.heightMultiplier! * 40,
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(
                              100 * SizeConfig.widthMultiplier!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10 * SizeConfig.heightMultiplier!,
                      ),
                      child: Shimmer.fromColors(
                        highlightColor: highlightColor,
                        baseColor: baseColor,
                        child: Container(
                          width: SizeConfig.widthMultiplier! * 328,
                          height: SizeConfig.heightMultiplier! * 74,
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(
                              16 * SizeConfig.widthMultiplier!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10 * SizeConfig.heightMultiplier!,
                      ),
                      child: Shimmer.fromColors(
                        highlightColor: highlightColor,
                        baseColor: baseColor,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: SizeConfig.widthMultiplier! * 161,
                                  height: SizeConfig.heightMultiplier! * 122,
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(
                                      13 * SizeConfig.widthMultiplier!,
                                    ),
                                  ),
                                ),
                                CustomSizedBox(width: 5),
                                Container(
                                  width: SizeConfig.widthMultiplier! * 161,
                                  height: SizeConfig.heightMultiplier! * 122,
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(
                                      13 * SizeConfig.widthMultiplier!,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CustomSizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: SizeConfig.widthMultiplier! * 161,
                                  height: SizeConfig.heightMultiplier! * 122,
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(
                                      13 * SizeConfig.widthMultiplier!,
                                    ),
                                  ),
                                ),
                                CustomSizedBox(width: 5),
                                Container(
                                  width: SizeConfig.widthMultiplier! * 161,
                                  height: SizeConfig.heightMultiplier! * 122,
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(
                                      13 * SizeConfig.widthMultiplier!,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
