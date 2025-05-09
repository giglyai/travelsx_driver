// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';

import '../../../login/screen/login_screen/mobile_login.dart';
import '../../../user/user_details/user_details_data.dart';
import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_styles/app_styles.dart';
import '../../constants/imagePath/image_paths.dart';
import '../../local_storage/log_in_status.dart';
import '../../local_storage/user_repository.dart';
import '../../utils/image_loader/image_loader.dart';
import '../custom_sized_box/custom_sized_box.dart';
import '../ride_back_button/ride_back_button.dart';
import '../size_config/size_config.dart';

class GiglyAppBar extends StatefulWidget implements PreferredSizeWidget {
  bool? wantBackButton;
  bool? wantTitle;
  BuildContext parentContext;
  bool? wantOtherIcons;

  String? title;

  GiglyAppBar(
      {Key? key,
      required this.parentContext,
      this.wantBackButton,
      this.wantOtherIcons,
      this.wantTitle,
      this.title})
      : super(key: key);

  @override
  _GiglyAppBarState createState() => _GiglyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(20 * SizeConfig.heightMultiplier!);
}

class _GiglyAppBarState extends State<GiglyAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.wantBackButton == false
            ? Container(
                margin: EdgeInsets.only(left: 15 * SizeConfig.widthMultiplier!),
              )
            : Padding(
                padding: EdgeInsets.only(
                  top: 10 * SizeConfig.heightMultiplier!,
                  left: 32 * SizeConfig.widthMultiplier!,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 25 * SizeConfig.imageSizeMultiplier!,
                    ),
                  ),
                ),
              ),
        widget.wantTitle == false
            ? Container(
                margin: EdgeInsets.only(left: 15 * SizeConfig.widthMultiplier!),
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 45 * SizeConfig.widthMultiplier!,
                      left: 110 * SizeConfig.widthMultiplier!),
                  child: Text(
                    widget.title ?? "",
                    style: TextStyle(
                        color: AppColors.kBlackTextColor,
                        fontSize: 16 * SizeConfig.textMultiplier!,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
      ],
    );
  }
}

class HomeDrawer extends StatefulWidget {
  HomeDrawer({
    super.key,
  });

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  LogInStatus getUserData = LogInStatus();
  late HomeCubit _homeCubit;

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 15 * SizeConfig.widthMultiplier!),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RideBackButton(
                onTap: () {
                  AnywhereDoor.pop(context);
                },
                padding:
                    EdgeInsets.only(top: 45 * SizeConfig.heightMultiplier!),
              ),
              CustomSizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileRepository.getProfileIcon != ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            70 * SizeConfig.heightMultiplier!,
                          ),
                          child: ImageLoader.networkAssetImage(
                              fit: BoxFit.fill,
                              height: 60 * SizeConfig.heightMultiplier!,
                              width: 60 * SizeConfig.widthMultiplier!,
                              imagePath: ProfileRepository.getProfileIcon),
                        )
                      : ImageLoader.assetImage(
                          width: 65 * SizeConfig.widthMultiplier!,
                          height: 65 * SizeConfig.heightMultiplier!,
                          imagePath: ImagePath.profileImage),
                  SizedBox(
                    width: 10 * SizeConfig.widthMultiplier!,
                  ),
                  UserRepository.getPhoneNumber != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ProfileRepository.getFirstName != ""
                                  ? (ProfileRepository.getFirstName ??
                                      ProfileRepository.getLastName ??
                                      "")
                                  : "${UserRepository.getCountryCode ?? ""}${UserRepository.getPhoneNumber ?? ""}",
                              style: TextStyle(
                                  fontSize: 22 * SizeConfig.textMultiplier!,
                                  color: const Color(0xff1562D8),
                                  fontWeight: FontWeight.w600),
                            ),
                            CustomSizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 25 * SizeConfig.heightMultiplier!,
                                  width: 86 * SizeConfig.widthMultiplier!,
                                  decoration: BoxDecoration(
                                    color: ProfileRepository.getAccountStatus ==
                                            'Verified'
                                        ? AppColors.kGreen00996
                                            .withOpacity(0.50)
                                        : const Color(0xffF3E8E8),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ProfileRepository.getAccountStatus
                                                  ?.isNotEmpty ==
                                              true
                                          ? ProfileRepository
                                                  .getAccountStatus ??
                                              "Pending"
                                          : "Pending",
                                    ),
                                  ),
                                ),
                                CustomSizedBox(
                                  width: 5 * SizeConfig.heightMultiplier!,
                                ),
                                const Icon(
                                  Icons.star_rounded,
                                  size: 20,
                                ),
                                Text(
                                  ProfileRepository
                                              .getAccountRating?.isNotEmpty ==
                                          true
                                      ? ProfileRepository.getAccountRating ?? ""
                                      : "4.5",
                                )
                              ],
                            ),
                          ],
                        )
                      : FutureBuilder(
                          future: getUserData.getUserName(),
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data ?? "" : "Name",
                              style: TextStyle(
                                  fontSize: 22 * SizeConfig.textMultiplier!,
                                  color: const Color(0xff1562D8),
                                  fontWeight: FontWeight.w600),
                            );
                          },
                        ),
                ],
              ),
              CustomSizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 12 * SizeConfig.widthMultiplier!),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.driverAccountScreen);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(ImagePath.driverIcon),
                            CustomSizedBox(
                              width: 16,
                            ),
                            Text('document'.tr,
                                style: AppTextStyle.text24Bblack0000W600),
                          ],
                        ),
                      ),
                      CustomSizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // _homeCubit.updateRiderAvailabilityStatus(
                          //     availabilityStatus: false);  Navigator.pushNamed(context, RouteName.ProfileScreen);
                          Navigator.pushNamed(context, RouteName.profileScreen);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(ImagePath.account_icon),
                            CustomSizedBox(
                              width: 16,
                            ),
                            Text('profile'.tr,
                                style: AppTextStyle.text24Bblack0000W600),
                          ],
                        ),
                      ),
                      CustomSizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, RouteName.userTripScreen);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(ImagePath.trips_icon),
                            CustomSizedBox(
                              width: 16,
                            ),
                            Text('rides'.tr,
                                style: AppTextStyle.text24Bblack0000W600),
                          ],
                        ),
                      ),
                      // CustomSizedBox(height: 15),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     // _homeCubit.updateRiderAvailabilityStatus(
                      //     //     availabilityStatus: false);  Navigator.pushNamed(context, RouteName.ProfileScreen);
                      //     Navigator.pushNamed(
                      //         context, RouteName.vehicleInfoScreen);
                      //   },
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(ImagePath.gariIcon),
                      //       CustomSizedBox(
                      //         width: 16,
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text('vehicle'.tr,
                      //               style: AppTextStyle.text24Bblack0000W600),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      CustomSizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // _homeCubit.updateRiderAvailabilityStatus(
                          //     availabilityStatus: false);  Navigator.pushNamed(context, RouteName.ProfileScreen);
                          Navigator.pushNamed(
                              context, RouteName.driverVehicleMainScreen);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(ImagePath.gariIcon),
                            CustomSizedBox(
                              width: 16,
                            ),
                            Row(
                              children: [
                                Text("Vehicle",
                                    style: AppTextStyle.text24Bblack0000W600),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // CustomSizedBox(height: 15),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     // _homeCubit.updateRiderAvailabilityStatus(
                      //     //     availabilityStatus: false);  Navigator.pushNamed(context, RouteName.ProfileScreen);
                      //     Navigator.pushNamed(
                      //         context, RouteName.agencyListScreen);
                      //   },
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(ImagePath.gariIcon),
                      //       CustomSizedBox(
                      //         width: 16,
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text('my_agency'.tr,
                      //               style: AppTextStyle.text24Bblack0000W600),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // CustomSizedBox(height: 15),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //
                      //     Navigator.pushNamed(
                      //         context, RouteName.promotionScreen);
                      //   },
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(ImagePath.offers_icon),
                      //       CustomSizedBox(
                      //         width: 16,
                      //       ),
                      //       Text('offers'.tr,
                      //           style: AppTextStyle.text18black0000W500),
                      //     ],
                      //   ),
                      // ),
                      CustomSizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // _homeCubit.updateRiderAvailabilityStatus(
                          //     availabilityStatus: false);
                          Navigator.pushNamed(
                              context, RouteName.earningsScreen);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(ImagePath.wallet_icon),
                            CustomSizedBox(
                              width: 16,
                            ),
                            Text('earnings'.tr,
                                style: AppTextStyle.text24Bblack0000W600),
                          ],
                        ),
                      ),

                      CustomSizedBox(height: 15),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, RouteName.walletScreen);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ImagePath.wallet_icon),
                              CustomSizedBox(
                                width: 16,
                              ),
                              Text('wallet'.tr,
                                  style: AppTextStyle.text24Bblack0000W600),
                            ],
                          )),
                      // CustomSizedBox(height: 15),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     Navigator.pushNamed(context, RouteName.shareQrScreen);
                      //   },
                      //   child: Row(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           ImageLoader.svgPictureAssetImage(
                      //             width: 20 * SizeConfig.widthMultiplier!,
                      //             height: 20 * SizeConfig.heightMultiplier!,
                      //             imagePath: ImagePath.shareqr,
                      //           ),
                      //           CustomSizedBox(
                      //             width: 10,
                      //           ),
                      //           Text('Share QR',
                      //               style: AppTextStyle.text18black0000W500),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // CustomSizedBox(height: 15),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     Navigator.pushNamed(
                      //         context, RouteName.notificationsScreen);
                      //   },
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(ImagePath.notification_icon),
                      //       CustomSizedBox(
                      //         width: 16,
                      //       ),
                      //       Text('notification'.tr,
                      //           style: AppTextStyle.text18black0000W500),
                      //     ],
                      //   ),
                      // ),

                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     Navigator.pushNamed(
                      //         context, RouteName.subscriptionScreen);
                      //   },
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(ImagePath.subsicon),
                      //       CustomSizedBox(
                      //         width: 14,
                      //       ),
                      //       Text('Subscription',
                      //           style: AppTextStyle.text18black0000W500),
                      //     ],
                      //   ),
                      // ),
                      CustomSizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          getUserData.logOutUser();

                          Future.delayed(const Duration(microseconds: 50), () {
                            _homeCubit.updateRiderAvailabilityStatus(
                              availabilityStatus: false,
                            );
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MobileNumberLoginScreen()),
                                (route) => false);
                          });
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(ImagePath.logout_agent),
                            CustomSizedBox(
                              width: 14,
                            ),
                            Text('logout'.tr,
                                style: AppTextStyle.text24Bblack0000W600),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20 * SizeConfig.heightMultiplier!,
                      ),
                      Divider(
                        thickness: 1,
                        endIndent: 18 * SizeConfig.widthMultiplier!,
                        color: AppColors.kBlackTextColor.withOpacity(0.8),
                      ),
                      SizedBox(
                        height: 10 * SizeConfig.heightMultiplier!,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                            context,
                            RouteName.privacyPolicy,
                          );
                        },
                        child: Text(
                          'terms_condition'.tr,
                          style: TextStyle(
                            color: AppColors.kBlackTextColor.withOpacity(0.8),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15 * SizeConfig.heightMultiplier!,
                      ),
                      GestureDetector(
                        onTap: () {
                          AnywhereDoor.pushNamed(context,
                              routeName: RouteName.chooseLanguageScreen);
                        },
                        child: Text(
                          'choose_language'.tr,
                          style: TextStyle(
                            color: AppColors.kBlackTextColor.withOpacity(0.8),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15 * SizeConfig.heightMultiplier!,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                            context,
                            RouteName.helpScreen,
                          );
                        },
                        child: Text(
                          'help'.tr,
                          style: TextStyle(
                            color: AppColors.kBlackTextColor.withOpacity(0.8),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15 * SizeConfig.heightMultiplier!,
                      ),
                      GestureDetector(
                        onTap: () {
                          AnywhereDoor.pushNamed(context,
                              routeName: RouteName.privacyAndPolicyScreen);
                        },
                        child: Text(
                          'privacy_policy'.tr,
                          style: TextStyle(
                            color: AppColors.kBlackTextColor.withOpacity(0.8),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30 * SizeConfig.heightMultiplier!,
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  textStyle30W600() {
    return TextStyle(
      color: AppColors.kBlackTextColor,
      fontSize: 28 * SizeConfig.textMultiplier!,
      fontWeight: FontWeight.w600,
    );
  }

  sizeBoxHeight30() {
    return CustomSizedBox(height: 10 * SizeConfig.heightMultiplier!);
  }
}
