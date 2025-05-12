// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelx_driver/login/screen/mobile_login_screen.dart';

import '../../../../shared/constants/app_colors/app_colors.dart';
import '../../../../shared/constants/app_styles/app_styles.dart';
import '../../../../shared/constants/imagePath/image_paths.dart';
import '../../../../shared/local_storage/log_in_status.dart';
import '../../../../shared/local_storage/user_repository.dart';
import '../../../../shared/routes/navigator.dart';
import '../../../../shared/utils/image_loader/image_loader.dart';
import '../../../../shared/widgets/buttons/blue_button.dart';
import '../../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../../shared/widgets/outline_button/outline_button.dart';
import '../../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../../shared/widgets/size_config/size_config.dart';
import '../../../user_details/user_details_data.dart';
import '../../bloc/account_cubit.dart';
import '../../enitity/profile_model.dart';
import 'profile_screen_shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AccountCubit accountCubit;
  late HomeCubit _homeCubit;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  GetUserProfileData? getUserProfileData;
  LogInStatus logInStatus = LogInStatus();

  final ImagePicker picker = ImagePicker();

  String? cameraImagePath;

  String? galleryImagePath;

  captureFrontImage() async {
    final XFile? image =
        await picker.pickImage(imageQuality: 10, source: ImageSource.camera);

    if (image?.path.isNotEmpty == true) {
      setState(() {
        cameraImagePath = image?.path;
      });
    }
  }

  Future<void> uploadFrontFile() async {
    final XFile? result =
        await picker.pickImage(imageQuality: 10, source: ImageSource.gallery);
    if (result != null) {
      if (result.path.isNotEmpty == true) {
        setState(() {
          galleryImagePath = result.path;
        });
      }
    }
  }

  @override
  void initState() {
    accountCubit = BlocProvider.of<AccountCubit>(context);
    _homeCubit = BlocProvider.of<HomeCubit>(context);
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
              if (state is AccountSuccessState) {
                accountCubit.getProfileData();
              }

              if (state is AccountProfileSuccessState) {
                getUserProfileData = state.getUserProfileData;

                if (getUserProfileData?.data != null) {
                  ProfileRepository.instance.setUserFirstName(
                      getUserProfileData?.data?.firstName ?? "");
                  ProfileRepository.instance.setUserLastName(
                      getUserProfileData?.data?.lastName ?? "");
                  ProfileRepository.instance
                      .setUserEmail(getUserProfileData?.data?.email ?? "");
                  ProfileRepository.instance.setUserProfileIcon(
                      getUserProfileData?.data?.profileImage ?? "");
                  ProfileRepository.instance.setUserProfileAccountStatus(
                      getUserProfileData?.data?.accountStatus ?? "");
                  ProfileRepository.instance.setUserProfileAccountRating(
                      getUserProfileData?.data?.accountRating ?? "");
                  ProfileRepository.instance.init();
                }
              }
              if (state is ProfileUploadSuccessState) {
                cameraImagePath = null;

                galleryImagePath = null;

                accountCubit.getProfileData();
              }
            },
            builder: (context, state) {
              if (state is AccountProfileLoading) {
                return ProfileScreenShimmer();
              }
              // if (state is AccountFailure) {
              //   accountCubit.getProfileData();
              // }
              // if (state is AccountProfileFailure) {
              //   accountCubit.getProfileData();
              // }

              if (state is AccountProfileSuccessState) {
                return getUserProfileData?.data?.profileImage?.isNotEmpty ==
                        true
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 22 * SizeConfig.widthMultiplier!),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RideBackButton(
                                  padding: EdgeInsets.only(
                                    top: 45 * SizeConfig.heightMultiplier!,
                                  ),
                                  onTap: () {
                                    AnywhereDoor.pop(context);
                                  },
                                ),
                                CustomSizedBox(
                                  height: 20 * SizeConfig.heightMultiplier!,
                                ),
                                Text(
                                  'edit_account'.tr,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800),
                                ),
                                CustomSizedBox(
                                  height: 20 * SizeConfig.heightMultiplier!,
                                ),

                                if (getUserProfileData
                                        ?.data?.profileImage?.isNotEmpty ==
                                    true)
                                  GestureDetector(
                                      onTap: () {
                                        uploadImagePopUp(context: context);
                                      },
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            80 * SizeConfig.heightMultiplier!,
                                          ),
                                          child: (cameraImagePath?.isNotEmpty ==
                                                      true ||
                                                  galleryImagePath
                                                          ?.isNotEmpty ==
                                                      true)
                                              ? Image.file(
                                                  fit: BoxFit.fill,
                                                  height: 80 *
                                                      SizeConfig
                                                          .heightMultiplier!,
                                                  width: 80 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                  File(cameraImagePath ??
                                                      galleryImagePath ??
                                                      ""),
                                                )
                                              : Image.network(
                                                  getUserProfileData?.data
                                                          ?.profileImage ??
                                                      "",
                                                  fit: BoxFit.fill,
                                                  height: 80 *
                                                      SizeConfig
                                                          .heightMultiplier!,
                                                  width: 80 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                )))
                                else
                                  GestureDetector(
                                    onTap: () {
                                      uploadImagePopUp(context: context);
                                    },
                                    child: ImageLoader.assetImage(
                                        width: 80 * SizeConfig.widthMultiplier!,
                                        height:
                                            80 * SizeConfig.heightMultiplier!,
                                        imagePath: ImagePath.profileImage),
                                  ),

                                SizedBox.shrink(),
                                CustomSizedBox(
                                  height: 10,
                                ),

                                CustomSizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                                Divider(),
                                CustomSizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),

                                CustomSizedBox(
                                  height: 8.5 * SizeConfig.heightMultiplier!,
                                ),
                                Text(
                                  'first_name'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextFormField(
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                    hintText:
                                        getUserProfileData?.data?.firstName ??
                                            "",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                CustomSizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                                Text(
                                  'last_name'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextFormField(
                                  controller: lastNameController,
                                  decoration: InputDecoration(
                                    hintText:
                                        getUserProfileData?.data?.lastName ??
                                            "",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                CustomSizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                                // Text(
                                //   '',
                                //   style: GoogleFonts.roboto(
                                //     fontSize: 16 * SizeConfig.textMultiplier!,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                                Text(
                                  'email'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  validator: (String? value) =>
                                      EmailValidator.validate(value!)
                                          ? null
                                          : "enter_valid_email".tr,
                                  decoration: InputDecoration(
                                      hintText:
                                          getUserProfileData?.data?.email ?? "",
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                CustomSizedBox(
                                  height: 20 * SizeConfig.heightMultiplier!,
                                ),
                                Text(
                                  'phone_number'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                CustomSizedBox(
                                  height: 5 * SizeConfig.heightMultiplier!,
                                ),
                                Row(
                                  children: [
                                    ImageLoader.svgPictureAssetImage(
                                        imagePath: ImagePath.flagicon),
                                    CustomSizedBox(
                                      width: 8 * SizeConfig.heightMultiplier!,
                                    ),
                                    Text(
                                      '+91',
                                      style: TextStyle(
                                          fontSize:
                                              16 * SizeConfig.textMultiplier!,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // Text(
                                    //   UserRepository.getCountryCode ?? "",
                                    //   style: TextStyle(
                                    //       fontSize: 16 * SizeConfig.textMultiplier!,
                                    //       color: Colors.black,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
                                    CustomSizedBox(
                                      width: 4 * SizeConfig.widthMultiplier!,
                                    ),
                                    Text(
                                      UserRepository.getPhoneNumber ?? "",
                                      style: TextStyle(
                                          fontSize:
                                              16 * SizeConfig.textMultiplier!,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                CustomSizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          CustomSizedBox(
                            height: 80.0 * SizeConfig.heightMultiplier!,
                          ),
                          BlueButton(
                            wantMargin: true,
                            title: 'save'.tr,
                            isLoading: state is AccountLoading,
                            onTap: () async {
                              if (cameraImagePath?.isNotEmpty == true ||
                                  galleryImagePath?.isNotEmpty == true) {
                                await accountCubit.uploadProfileImg(
                                    imagePath: cameraImagePath ??
                                        galleryImagePath ??
                                        "");

                                accountCubit.postUserData(
                                    firstName: firstNameController
                                                .text.isNotEmpty ==
                                            true
                                        ? firstNameController.text
                                        : getUserProfileData?.data?.firstName,
                                    lastName: lastNameController
                                                .text.isNotEmpty ==
                                            true
                                        ? lastNameController.text
                                        : getUserProfileData?.data?.lastName,
                                    email:
                                        emailController.text.isNotEmpty == true
                                            ? emailController.text
                                            : getUserProfileData?.data?.email);
                              } else {
                                accountCubit.postUserData(
                                    firstName: firstNameController
                                                .text.isNotEmpty ==
                                            true
                                        ? firstNameController.text
                                        : getUserProfileData?.data?.firstName,
                                    lastName: lastNameController
                                                .text.isNotEmpty ==
                                            true
                                        ? lastNameController.text
                                        : getUserProfileData?.data?.lastName,
                                    email:
                                        emailController.text.isNotEmpty == true
                                            ? emailController.text
                                            : getUserProfileData?.data?.email);
                              }
                            },
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 22 * SizeConfig.widthMultiplier!),
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
                                  height: 20 * SizeConfig.heightMultiplier!,
                                ),
                                Text(
                                  'edit_account'.tr,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800),
                                ),
                                CustomSizedBox(
                                  height: 20 * SizeConfig.heightMultiplier!,
                                ),

                                if (cameraImagePath?.isNotEmpty == true ||
                                    galleryImagePath?.isNotEmpty == true)
                                  GestureDetector(
                                      onTap: () {
                                        uploadImagePopUp(context: context);
                                      },
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            80 * SizeConfig.heightMultiplier!,
                                          ),
                                          child: Image.file(
                                            fit: BoxFit.fill,
                                            height: 80 *
                                                SizeConfig.heightMultiplier!,
                                            width: 80 *
                                                SizeConfig.widthMultiplier!,
                                            File(cameraImagePath ??
                                                galleryImagePath ??
                                                ""),
                                          )))
                                else
                                  GestureDetector(
                                    onTap: () {
                                      uploadImagePopUp(context: context);
                                    },
                                    child: ImageLoader.assetImage(
                                        width: 80 * SizeConfig.widthMultiplier!,
                                        height:
                                            80 * SizeConfig.heightMultiplier!,
                                        imagePath: ImagePath.profileImage),
                                  ),

                                SizedBox.shrink(),
                                CustomSizedBox(
                                  height: 10,
                                ),

                                CustomSizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                                Divider(),
                                CustomSizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),

                                CustomSizedBox(
                                  height: 8.5 * SizeConfig.heightMultiplier!,
                                ),
                                Text(
                                  'first_name'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextFormField(
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                    hintText:
                                        getUserProfileData?.data?.firstName ??
                                            "",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                CustomSizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                                Text(
                                  'last_name'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextFormField(
                                  controller: lastNameController,
                                  decoration: InputDecoration(
                                    hintText:
                                        getUserProfileData?.data?.lastName ??
                                            "",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                CustomSizedBox(
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                                // Text(
                                //   '',
                                //   style: GoogleFonts.roboto(
                                //     fontSize: 16 * SizeConfig.textMultiplier!,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                                Text(
                                  'email'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  validator: (String? value) =>
                                      EmailValidator.validate(value!)
                                          ? null
                                          : "enter_valid_email".tr,
                                  decoration: InputDecoration(
                                      hintText:
                                          getUserProfileData?.data?.email ?? "",
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                CustomSizedBox(
                                  height: 20 * SizeConfig.heightMultiplier!,
                                ),
                                Text(
                                  'phone_number'.tr,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                CustomSizedBox(
                                  height: 5 * SizeConfig.heightMultiplier!,
                                ),
                                Row(
                                  children: [
                                    ImageLoader.svgPictureAssetImage(
                                        imagePath: ImagePath.flagicon),
                                    CustomSizedBox(
                                      width: 8 * SizeConfig.heightMultiplier!,
                                    ),
                                    Text(
                                      '+91',
                                      style: TextStyle(
                                          fontSize:
                                              16 * SizeConfig.textMultiplier!,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // Text(
                                    //   UserRepository.getCountryCode ?? "",
                                    //   style: TextStyle(
                                    //       fontSize: 16 * SizeConfig.textMultiplier!,
                                    //       color: Colors.black,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
                                    CustomSizedBox(
                                      width: 4 * SizeConfig.widthMultiplier!,
                                    ),
                                    Text(
                                      UserRepository.getPhoneNumber ?? "",
                                      style: TextStyle(
                                          fontSize:
                                              16 * SizeConfig.textMultiplier!,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                CustomSizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    confirmDeletionPopUp(
                                      context: context,
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: 20 * SizeConfig.widthMultiplier!,
                                    ),
                                    child: Row(children: [
                                      Text("account_deletion".tr,
                                          style: AppTextStyle
                                              .text14kredDF0000W500),
                                      const Spacer(),
                                      ImageLoader.svgPictureAssetImage(
                                          imagePath: ImagePath.rightArrowIcon,
                                          color: AppColors.kredDF0000),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomSizedBox(
                            height: 80.0 * SizeConfig.heightMultiplier!,
                          ),
                          BlueButton(
                            wantMargin: true,
                            title: 'save'.tr,
                            isLoading: state is AccountLoading,
                            onTap: () async {
                              await accountCubit.uploadProfileImg(
                                  imagePath: cameraImagePath ??
                                      galleryImagePath ??
                                      "");

                              accountCubit.postUserData(
                                  firstName:
                                      firstNameController.text.isNotEmpty ==
                                              true
                                          ? firstNameController.text
                                          : getUserProfileData?.data?.firstName,
                                  lastName:
                                      lastNameController.text.isNotEmpty == true
                                          ? lastNameController.text
                                          : getUserProfileData?.data?.lastName,
                                  email: emailController.text.isNotEmpty == true
                                      ? emailController.text
                                      : getUserProfileData?.data?.email);
                            },
                          )
                        ],
                      );
              }

              return ProfileScreenShimmer();
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> uploadImagePopUp({
    required BuildContext context,
    String? message,
  }) {
    return showDialog(
        context: context,
        barrierColor: AppColors.kBlackTextColor.withOpacity(0.45),
        barrierDismissible: true,
        builder: (context) {
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 90.0 * SizeConfig.heightMultiplier!,
                  left: 20 * SizeConfig.widthMultiplier!,
                  right: 20 * SizeConfig.widthMultiplier!),
              child: Container(
                height: 170 * SizeConfig.heightMultiplier!,
                decoration: BoxDecoration(
                    color: AppColors.kWhiteFFFF,
                    borderRadius:
                        BorderRadius.circular(4 * SizeConfig.widthMultiplier!)),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20 * SizeConfig.widthMultiplier!),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomSizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Spacer(),
                            ImageLoader.svgPictureAssetImage(
                                width: 20 * SizeConfig.widthMultiplier!,
                                height: 20 * SizeConfig.heightMultiplier!,
                                imagePath: ImagePath.cutIcon),
                            CustomSizedBox(
                              width: 9,
                            ),
                          ],
                        ),
                      ),
                      CustomSizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () async {
                          uploadFrontFile();
                          AnywhereDoor.pop(context);
                        },
                        child: Row(
                          children: [
                            ImageLoader.svgPictureAssetImage(
                                width: 20 * SizeConfig.widthMultiplier!,
                                height: 20 * SizeConfig.heightMultiplier!,
                                imagePath: ImagePath.galleryIcon),
                            CustomSizedBox(
                              width: 9,
                            ),
                            Text(
                              "Choose_from_library".tr,
                              style: AppTextStyle.text16kBlackTextColorW500
                                  .copyWith(
                                      color: AppColors.kBlackTextColor
                                          .withOpacity(0.60),
                                      fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      CustomSizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          captureFrontImage();
                          AnywhereDoor.pop(context);
                        },
                        child: Row(
                          children: [
                            ImageLoader.svgPictureAssetImage(
                                imagePath: ImagePath.proCameraIcon),
                            CustomSizedBox(
                              width: 9,
                            ),
                            Text(
                              "take_photo".tr,
                              style: AppTextStyle.text16kBlackTextColorW500
                                  .copyWith(
                                      color: AppColors.kBlackTextColor
                                          .withOpacity(0.60),
                                      fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      CustomSizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void confirmDeletionPopUp({
    required BuildContext context,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false, // Disable back button
            child: AlertDialog(
              titlePadding: EdgeInsets.only(
                  top: 10 * SizeConfig.heightMultiplier!,
                  bottom: 20 * SizeConfig.heightMultiplier!,
                  left: 15 * SizeConfig.widthMultiplier!,
                  right: 15 * SizeConfig.widthMultiplier!),
              backgroundColor: AppColors.kWhite,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10 * SizeConfig.widthMultiplier!)),
              title: SizedBox(
                width: 450 * SizeConfig.widthMultiplier!,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomSizedBox(height: 10),
                    Text(
                      "confirm_deletion".tr,
                      style: AppTextStyle.text16black0000W600,
                      textAlign: TextAlign.center,
                    ),
                    CustomSizedBox(height: 5 * SizeConfig.heightMultiplier!),
                    Center(
                      child: Text(
                        "are_you_sure_you_want_to_delete_this_account_permamnently_you_can".tr,
                        style: AppTextStyle.text14black0000W400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CustomSizedBox(height: 15),
                    BlocConsumer<AccountCubit, AccountState>(
                      listener: (context, state) {
                        if (state is AccountDeleteSuccessState) {
                          AnywhereDoor.pop(context);
                          Future.delayed(const Duration(milliseconds: 500), () {
                            accountDeletedPopUp();
                          });
                        }
                      },
                      builder: (context, state) {
                        return BlueButton(
                          onTap: () async {
                            await accountCubit.deleteAccount();
                          },
                          height: 44,
                          wantMargin: false,
                          title: "confirm".tr,
                          isLoading: state is AccountDeleteLoading,
                        );
                      },
                    ),
                    CustomSizedBox(height: 10),
                    CustomOutlineButton(
                      onTap: () {
                        AnywhereDoor.pop(context);
                      },
                      height: 44,
                      wantMargin: false,
                      title: "cancel".tr,
                      titleColor: AppColors.kBlackTextColor,
                      borderColor: AppColors.kredDF0000,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  accountDeletedPopUp() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              titlePadding: EdgeInsets.only(
                  top: 10 * SizeConfig.heightMultiplier!,
                  bottom: 20 * SizeConfig.heightMultiplier!,
                  left: 15 * SizeConfig.widthMultiplier!,
                  right: 15 * SizeConfig.widthMultiplier!),
              backgroundColor: AppColors.kWhite,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10 * SizeConfig.widthMultiplier!)),
              title: SizedBox(
                width: 400 * SizeConfig.widthMultiplier!,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageLoader.svgPictureAssetImage(
                            width: 48 * SizeConfig.widthMultiplier!,
                            height: 48 * SizeConfig.widthMultiplier!,
                            imagePath: ImagePath.bigCheckIcon,
                            color: AppColors.red534A),
                      ],
                    ),
                    CustomSizedBox(height: 10 * SizeConfig.heightMultiplier!),
                    Text(
                      "your_account_has_been_deleted".tr,
                      style: AppTextStyle.text16black0000W600,
                      textAlign: TextAlign.center,
                    ),
                    CustomSizedBox(height: 5 * SizeConfig.heightMultiplier!),
                    Center(
                      child: Text(
                        "you_can_still_recover_you_account_within_7_days_after_that_it_will_be_lost_forever".tr,
                        style: AppTextStyle.text12black0000W400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CustomSizedBox(height: 15),
                    GestureDetector(
                        onTap: () {
                          logInStatus.logOutUser();
                          Future.delayed(const Duration(microseconds: 50), () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MobileNumberLoginScreen()),
                                (route) => false);
                          });
                        },
                        child: BlueButton(
                          height: 44,
                          wantMargin: false,
                          title: "continue".tr,
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
