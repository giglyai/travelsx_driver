import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/shared/alert_pop/widgets/image_upload_popup.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';
import 'package:travelx_driver/user/account/screen/driver_account_details/bloc/driver_accounts_bloc.dart';

import '../../../../shared/utils/image_loader/image_loader.dart';
import '../../../../shared/widgets/size_config/size_config.dart';
import '../../enitity/profile_backside.dart';
import '../../enitity/profile_model.dart';
import '../../enitity/upoad_image_res.dart';
import 'driver_account_screen_shimmer.dart';

class DriverAccountScreen extends StatefulWidget {
  const DriverAccountScreen({super.key});

  @override
  State<DriverAccountScreen> createState() => _DriverAccountScreenState();
}

class _DriverAccountScreenState extends State<DriverAccountScreen> {
  late DriverAccountCubit accountCubit;

  GetUserProfileData? getUserProfileData;
  bool buttonIsEnabled = false;
  int? selectedIndex;
  int? selectedDocIndex;
  ProfileImageRes? profileImageRes;
  ProfileImageBackRes? profileImageBackRes;

  bool isMissingDocContainerOpened = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    accountCubit = context.read();
    accountCubit.getProfileData();
    accountCubit.flushDocData();
    accountCubit.onSetInitialScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (v) {
        AnywhereDoor.pushReplacementNamed(context,
            routeName: RouteName.homeScreen);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocBuilder<DriverAccountCubit, DriverAccountState>(
            builder: (context, state) {
              if (state.driverAccountApiStatus.isLoading == true) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.0 * SizeConfig.widthMultiplier!),
                  child: Column(
                    children: [
                      CustomSizedBox(
                        height: 90,
                      ),
                      const DriverAccountScreenShimmer(),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  if (state.getUserProfileData.data?.missingDocs?.isNotEmpty ==
                      true)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RideBackButton(
                          onTap: () {
                            AnywhereDoor.pushReplacementNamed(context,
                                routeName: RouteName.homeScreen);
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0 * SizeConfig.widthMultiplier!,
                                  right: 20 * SizeConfig.widthMultiplier!),
                              child: Text(
                                'driver_document'.tr,
                                style: AppTextStyle.text24black0000W600,
                              ),
                            ),
                            CustomSizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0 * SizeConfig.widthMultiplier!,
                                  right: 20 * SizeConfig.widthMultiplier!),
                              child: Text(
                                'document'.tr,
                                style: AppTextStyle.text14black0000W500
                                    ?.copyWith(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.50)),
                              ),
                            ),
                            CustomSizedBox(
                              height: 10 * SizeConfig.heightMultiplier!,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       left: 20.0 * SizeConfig.widthMultiplier!,
                            //       right: 20 * SizeConfig.widthMultiplier!),
                            //   child: InputDecorator(
                            //     decoration: InputDecoration(
                            //         border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(
                            //                 4 * SizeConfig.widthMultiplier!))),
                            //     child: DropdownButtonHideUnderline(
                            //       child: DropdownButton<String>(
                            //         value: chooseDocument,
                            //         style: AppTextStyle.text12black0000W400,
                            //         hint: const Text(
                            //           "Select Document",
                            //           style: TextStyle(
                            //             color: Colors.grey,
                            //             fontSize: 16,
                            //           ),
                            //         ),
                            //         items: state.getUserProfileData.data?.missingDocs
                            //             ?.map<DropdownMenuItem<String>>((String value) {
                            //           return DropdownMenuItem(
                            //             value: value,
                            //             child: Row(
                            //               children: [
                            //                 Text(value),
                            //               ],
                            //             ),
                            //           );
                            //         }).toList(),
                            //         isExpanded: true,
                            //         isDense: true,
                            //         onChanged: (String? newSelectedCompany) {
                            //           setState(() {
                            //             chooseDocument = newSelectedCompany;
                            //
                            //             if (chooseDocument == "Aadhar") {
                            //               state.isSingleDocUpload = false;
                            //
                            //               accountCubit.flushDocData();
                            //             } else if (chooseDocument ==
                            //                 "Driving Licence") {
                            //               state.isSingleDocUpload = false;
                            //               accountCubit.flushDocData();
                            //             } else if (chooseDocument == "Profile Image") {
                            //               state.isSingleDocUpload = true;
                            //
                            //               accountCubit.flushDocData();
                            //             } else if (chooseDocument ==
                            //                 "Vehicle Insurance") {
                            //               state.isSingleDocUpload = true;
                            //
                            //               accountCubit.flushDocData();
                            //             } else if (chooseDocument == "Vehicle RC") {
                            //               state.isSingleDocUpload = true;
                            //
                            //               accountCubit.flushDocData();
                            //             }
                            //           });
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isMissingDocContainerOpened =
                                      !isMissingDocContainerOpened;
                                });
                              },
                              child: CustomTextFromField(
                                hintText: state.documentName,
                                enabled: false,
                                wantFilledColor: true,
                                wantDisabledBorder: true,
                                filledColor: AppColors.kWhite,
                                hintTextStyle:
                                    AppTextStyle.text14kblack333333W600,
                                suffixIcon: ImageLoader.svgPictureAssetImage(
                                    imagePath: ImagePath.arrowIcon),
                              ),
                            ),
                            if (isMissingDocContainerOpened == true)
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        22 * SizeConfig.widthMultiplier!),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.kBlackTextColor
                                          .withOpacity(0.15),
                                      blurRadius: 3, // soften the shadow
                                      spreadRadius: 1.0, //extend the shadow
                                    )
                                  ],
                                ),
                                child: Wrap(
                                  children: List.generate(
                                      state.getUserProfileData.data?.missingDocs
                                              ?.length ??
                                          0, (index) {
                                    final missingDoc = state.getUserProfileData
                                        .data?.missingDocs?[index];

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedDocIndex = index;
                                        });
                                        state.documentName = missingDoc;
                                        if (missingDoc == "Aadhar") {
                                          state.isSingleDocUpload = false;
                                          accountCubit.flushDocData();
                                        } else if (missingDoc ==
                                            "Driving Licence") {
                                          state.isSingleDocUpload = false;
                                          accountCubit.flushDocData();
                                        } else if (missingDoc ==
                                            "Profile Image") {
                                          state.isSingleDocUpload = true;
                                          accountCubit.flushDocData();
                                        } else if (missingDoc ==
                                            "Vehicle Insurance") {
                                          state.isSingleDocUpload = true;
                                          accountCubit.flushDocData();
                                        } else if (missingDoc == "Vehicle RC") {
                                          state.isSingleDocUpload = true;
                                          accountCubit.flushDocData();
                                        }
                                        isMissingDocContainerOpened = false;
                                        accountCubit.onDocChanged(true);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16 *
                                                SizeConfig.widthMultiplier!,
                                            vertical: 10 *
                                                SizeConfig.heightMultiplier!,
                                          ),
                                          decoration: BoxDecoration(
                                            color: selectedDocIndex == index
                                                ? AppColors.kWhite
                                                : AppColors.kGreyFAF9F9,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                missingDoc ?? "",
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
                          ],
                        ),
                        if (state.uploadDocColumnOpened == true)
                          Column(
                            children: [
                              CustomSizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20.0 * SizeConfig.widthMultiplier!,
                                    right: 20 * SizeConfig.widthMultiplier!),
                                padding: EdgeInsets.only(
                                    left: 18 * SizeConfig.widthMultiplier!,
                                    top: 12 * SizeConfig.heightMultiplier!,
                                    bottom: 12 * SizeConfig.heightMultiplier!),
                                decoration:
                                    BoxDecoration(color: AppColors.bblueF2F6FF),
                                child: Row(
                                  children: [
                                    ImageLoader.svgPictureAssetImage(
                                        imagePath:
                                            ImagePath.documentUploadImage),
                                    CustomSizedBox(
                                      width: 12 * SizeConfig.widthMultiplier!,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'select_document_from_gallery'.tr,
                                          style:
                                              AppTextStyle.text14black0000W400,
                                        ),
                                        Text('upload_documents'.tr)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              CustomSizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  if (state.isSingleDocUpload == true)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        repeatedRowContainerImage(
                                            onFileChanged:
                                                accountCubit.onFrontFileChanged,
                                            pickedImagePath:
                                                state.docFront?.file),
                                      ],
                                    ),
                                  if (state.isSingleDocUpload == false)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        repeatedRowContainerImage(
                                            onFileChanged:
                                                accountCubit.onFrontFileChanged,
                                            pickedImagePath:
                                                state.docFront?.file),
                                        repeatedRowContainerImage(
                                            onFileChanged:
                                                accountCubit.onBackFileChanged,
                                            pickedImagePath:
                                                state.docBack?.file),
                                      ],
                                    ),
                                  CustomSizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "upload_front_side_image_of_your_documents"
                                            .tr,
                                        style: AppTextStyle.text10black0000W400
                                            ?.copyWith(
                                                color: AppColors.kBlackTextColor
                                                    .withOpacity(0.50)),
                                      ),
                                      if (state.isSingleDocUpload == false)
                                        Text(
                                          "upload_back_side_image_of_your_documents"
                                              .tr,
                                          style: AppTextStyle
                                              .text10black0000W400
                                              ?.copyWith(
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.50)),
                                        ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20 * SizeConfig.widthMultiplier!,
                                        right:
                                            20 * SizeConfig.widthMultiplier!),
                                    child: Divider(),
                                  ),
                                  CustomSizedBox(
                                    height: 5,
                                  ),
                                  BlueButton(
                                    buttonColor: AppColors.kBlackTextColor,
                                    height: 43 * SizeConfig.heightMultiplier!,
                                    borderRadius:
                                        4 * SizeConfig.widthMultiplier!,
                                    title: 'save'.tr,
                                    buttonIsEnabled: state.isValidInput,
                                    isLoading:
                                        state.uploadDocApiStatus.isLoading,
                                    onTap: () =>
                                        accountCubit.onSaveDriverAccountsData(
                                      docType: state.documentName ?? "",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        CustomSizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  if (state.getUserProfileData.data?.missingDocs?.isEmpty ==
                              true &&
                          state.getUserProfileData.data?.accountStatus ==
                              "pending" ||
                      state.getUserProfileData.data?.accountStatus == "")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RideBackButton(
                          onTap: () {
                            AnywhereDoor.pushReplacementNamed(context,
                                routeName: RouteName.homeScreen);
                          },
                        ),
                        CustomSizedBox(
                          height: 25,
                        ),
                        Center(
                          child: Text(
                            "documents_submitted".tr,
                            style: AppTextStyle.text18black0000W600,
                          ),
                        ),
                        CustomSizedBox(
                          height: 2,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "verification_is_under_process".tr,
                                style: AppTextStyle.text12kRedF24141W300,
                              ),
                              Center(
                                child: Container(
                                  width: 150 * SizeConfig.widthMultiplier!,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        50 * SizeConfig.widthMultiplier!),
                                    color: AppColors.kRedF24141,
                                    border: Border.all(
                                        color: AppColors.kRedF24141,
                                        width:
                                            0.4 * SizeConfig.widthMultiplier!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (state.getUserProfileData.data?.missingDocs?.isEmpty ==
                          true &&
                      state.getUserProfileData.data?.accountStatus ==
                          "Verified")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RideBackButton(
                          onTap: () {
                            AnywhereDoor.pushReplacementNamed(context,
                                routeName: RouteName.homeScreen);
                          },
                        ),
                        CustomSizedBox(
                          height: 25,
                        ),
                        Center(
                          child: Text(
                            "documents_submitted".tr,
                            style: AppTextStyle.text18black0000W600,
                          ),
                        ),
                        CustomSizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "your_account_is_verified".tr,
                                style: AppTextStyle.text14Green198F52W600,
                              ),
                              Center(
                                child: Container(
                                  width: 150 * SizeConfig.widthMultiplier!,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        50 * SizeConfig.widthMultiplier!),
                                    color: AppColors.kGreen198F52,
                                    border: Border.all(
                                        color: AppColors.kGreen198F52,
                                        width:
                                            0.4 * SizeConfig.widthMultiplier!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  // if (state.getUserProfileData.data?.docsType?.isNotEmpty ==
                  //     true)
                  //   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.only(
                  //             left: 20.0 * SizeConfig.widthMultiplier!),
                  //         child: Text(
                  //           "Submitted Documents",
                  //           style: AppTextStyle.text14black0000W500,
                  //         ),
                  //       ),
                  //       CustomSizedBox(
                  //         height: 14,
                  //       ),
                  //       Wrap(
                  //         children: List.generate(
                  //             state.getUserProfileData.data?.docsType?.length ??
                  //                 0, (index) {
                  //           WidgetsBinding.instance.addPostFrameCallback((_) {
                  //             selectedIndex = index;
                  //           });
                  //
                  //           return Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Padding(
                  //                 padding: EdgeInsets.only(
                  //                     left: 20.0 * SizeConfig.widthMultiplier!,
                  //                     right: 20 * SizeConfig.widthMultiplier!),
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       state.getUserProfileData.data
                  //                               ?.docsType?[index].docType ??
                  //                           "",
                  //                       style: AppTextStyle.text12black0000W400,
                  //                     ),
                  //                     CustomSizedBox(
                  //                       height: 8,
                  //                     ),
                  //                     Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Wrap(
                  //                           direction: Axis.horizontal,
                  //                           children: List.generate(
                  //                               state
                  //                                       .getUserProfileData
                  //                                       .data
                  //                                       ?.docsType?[index]
                  //                                       .imageUrls
                  //                                       ?.length ??
                  //                                   0, (index1) {
                  //                             return Container(
                  //                               margin: EdgeInsets.only(
                  //                                   left: 10 *
                  //                                       SizeConfig
                  //                                           .widthMultiplier!),
                  //                               width: 98 *
                  //                                   SizeConfig.widthMultiplier!,
                  //                               height: 64 *
                  //                                   SizeConfig
                  //                                       .heightMultiplier!,
                  //                               decoration: BoxDecoration(
                  //                                   border: Border.all(
                  //                                     color: AppColors
                  //                                         .kBlackTextColor,
                  //                                     width: 1 *
                  //                                         SizeConfig
                  //                                             .widthMultiplier!,
                  //                                   ),
                  //                                   borderRadius: BorderRadius
                  //                                       .circular(4 *
                  //                                           SizeConfig
                  //                                               .widthMultiplier!)),
                  //                               child: ImageLoader.networkAssetImage(
                  //                                   fit: BoxFit.fill,
                  //                                   height: 90 *
                  //                                       SizeConfig
                  //                                           .heightMultiplier!,
                  //                                   width: 60 *
                  //                                       SizeConfig
                  //                                           .widthMultiplier!,
                  //                                   imagePath: state
                  //                                           .getUserProfileData
                  //                                           .data
                  //                                           ?.docsType?[index]
                  //                                           .imageUrls?[index1] ??
                  //                                       ""),
                  //                             );
                  //                           }),
                  //                         ),
                  //                         if (index < 1) Divider(),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           );
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  CustomSizedBox(
                    height: 50,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  repeatedRowContainerImage({
    required Function(String?) onFileChanged,
    String? imagePath,
    String? title,
    String? subTitle,
    required String? pickedImagePath,
  }) {
    final isImagePicked = pickedImagePath?.isNotEmpty == true;
    return GestureDetector(
      onTap: () {
        ImageUploadPopUp.pick(onFilePicked: onFileChanged);
      },
      child: Container(
        width: 153 * SizeConfig.widthMultiplier!,
        height: 200 * SizeConfig.heightMultiplier!,
        decoration: BoxDecoration(
          color: AppColors.kGreyF6F5F5,
          borderRadius: BorderRadius.circular(
            6 * SizeConfig.widthMultiplier!,
          ),
          boxShadow: [
            BoxShadow(
                color: AppColors.kBlackTextColor.withOpacity(.2),
                offset: Offset(0.0, 0.5)),
          ],
        ),
        child: Column(
          children: [
            if (isImagePicked == true)
              ImageLoader.file(
                imagePath: pickedImagePath,
                width: 143 * SizeConfig.widthMultiplier!,
                height: 200 * SizeConfig.heightMultiplier!,
              ),
            if (isImagePicked == false) ...{
              SizedBox(
                  height: 130,
                  child: ImageLoader.assetImage(imagePath: imagePath)),
            },
          ],
        ),
      ),
    );
  }
}
