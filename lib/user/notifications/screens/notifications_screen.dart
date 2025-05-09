import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/app_styles/app_styles.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/widgets/empty_data_screens/notification_empty.dart';
import '../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../bloc/notification_cubit.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late NotificationCubit notificationCubit;
  late TabController _tabController;

  @override
  void initState() {
    notificationCubit = BlocProvider.of<NotificationCubit>(context);
    notificationCubit.getRecentNotification();
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RideBackButton(
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: Text(
                "notifications".tr,
                style: AppTextStyle.text20kBlackTextColorW700.copyWith(
                    color: AppColors.kBlackTextColor.withOpacity(0.70)),
              ),
            ),
            SizedBox(
              height: 15 * SizeConfig.widthMultiplier!,
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
                  onTap: (controller) async {
                    setState(() {
                      controllerTab = controller;
                    });

                    if (controller == 0) {
                      await notificationCubit.getRecentNotification();
                    } else if (controller == 1) {
                      await notificationCubit.getAllNotification();
                    }
                  },
                  tabs: [
                    Tab(
                      child: Text(
                        "recent".tr,
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
                        "all".tr,
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
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state is RecentNotificationSuccess) {
                  return Wrap(
                    children: List.generate(
                      state.notificationsModel.data?.length ?? 0,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        6 * SizeConfig.widthMultiplier!),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.bGreyF9F8F8),
                                    child: Icon(
                                      Icons.notifications,
                                      size: 20 * SizeConfig.widthMultiplier!,
                                      color: AppColors.kBlackTextColor
                                          .withOpacity(0.30),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 11 * SizeConfig.widthMultiplier!,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.notificationsModel.data?[index]
                                                  .content ??
                                              "",
                                          style: TextStyle(
                                              color: AppColors.kBlack090000,
                                              fontSize: 14 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                            height: 6 *
                                                SizeConfig.heightMultiplier!),
                                        Text(
                                          state.notificationsModel.data?[index]
                                                  .createdTime ??
                                              "",
                                          style: TextStyle(
                                              color: AppColors.kBlack090000
                                                  .withOpacity(0.5),
                                              fontSize: 14 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
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

                if (state is GetAllNotificationSuccess) {
                  return Wrap(
                    children: List.generate(
                      state.notificationsModel.data?.length ?? 0,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        6 * SizeConfig.widthMultiplier!),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.bGreyF9F8F8),
                                    child: Icon(
                                      Icons.notifications,
                                      size: 20 * SizeConfig.widthMultiplier!,
                                      color: AppColors.kBlackTextColor
                                          .withOpacity(0.30),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 11 * SizeConfig.widthMultiplier!,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.notificationsModel.data?[index]
                                                  .content ??
                                              "",
                                          style: TextStyle(
                                              color: AppColors.kBlack090000,
                                              fontSize: 14 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                            height: 6 *
                                                SizeConfig.heightMultiplier!),
                                        Text(
                                          state.notificationsModel.data?[index]
                                                  .createdTime ??
                                              "",
                                          style: TextStyle(
                                              color: AppColors.kBlack090000
                                                  .withOpacity(0.5),
                                              fontSize: 14 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
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

                if (state is NotificationEmptyState) {
                  return Center(
                    child: NotificationEmpty(
                      message: state.emptyMessage,
                    ),
                  );
                }
                if (state is GetAllNotificationLoading) {
                  return Center(
                    child: Lottie.asset(ImagePath.loadingAnimation,
                        height: 50 * SizeConfig.heightMultiplier!,
                        width: 300 * SizeConfig.widthMultiplier!),
                  );
                }
                if (state is RecentNotificationLoading) {
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
    );
  }
}
