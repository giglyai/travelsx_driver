import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/home/hire_driver_bloc/entity/upcoming_ontrip_ride_res.dart';
import 'package:travelx_driver/search-rides/screens/booking_registration/cubit/booking_registration_cubit.dart';
import 'package:travelx_driver/shared/alert_pop/widgets/image_upload_popup.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/user/account/screen/vehicle/vehicle_screen.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/app_styles/app_styles.dart';
import '../../../shared/utils/image_loader/image_loader.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../../../shared/widgets/text_form_field/custom_textform_field.dart';

class BookingsScreenParam {
  OntripRide ride;
  BookingsScreenParam({
    required this.ride,
  });
}

class BookingsScreen extends StatefulWidget {
  final BookingsScreenParam params;
  const BookingsScreen({
    super.key,
    required this.params,
  });

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  bool isSelected = false;
  late final BookingRegistrationCubit controller;

  @override
  void initState() {
    controller = BlocProvider.of<BookingRegistrationCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<BookingRegistrationCubit, BookingRegistrationState>(
          builder: (context, state) {
            return Column(
              children: [
                CustomSizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RideBackButton(
                      onTap: () => Navigator.pop(context),
                    ),
                    CustomSizedBox(
                      width: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 45 * SizeConfig.heightMultiplier!),
                      child: Text("Upload Vehicle Images",
                          style: AppTextStyle.text18black0000W600),
                    ),
                  ],
                ),
                CustomSizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: 20 * SizeConfig.widthMultiplier!,
                      right: 20 * SizeConfig.widthMultiplier!,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            repeatedRowContainerImage(
                              onFileChanged: controller.onSelfieChanged,
                              imagePath: ImagePath.safetyCarIcon,
                              title: "Selfie",
                              pickedImagePath: state.selfie.file,
                            ),
                            CustomSizedBox(
                              width: 15,
                            ),
                            repeatedRowContainerImage(
                              onFileChanged: controller.onExteriorFrontChanged,
                              imagePath: ImagePath.carFrontIcon,
                              title: "Exterior Front",
                              subTitle: "(With license plate)",
                              pickedImagePath: state.exteriorFront.file,
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            repeatedRowContainerImage(
                              onFileChanged: controller.onExteriorRightChanged,
                              imagePath: ImagePath.carRightIcon,
                              title: "Exterior right",
                              subTitle: "(With license plate)",
                              pickedImagePath: state.exteriorRight.file,
                            ),
                            CustomSizedBox(
                              width: 15,
                            ),
                            repeatedRowContainerImage(
                              onFileChanged: controller.onExteriorLeftChanged,
                              imagePath: ImagePath.carLeftIcon,
                              title: "Exterior left",
                              pickedImagePath: state.exteriorLeft.file,
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          height: 10,
                        ),
                        repeatedRowContainerImage(
                          onFileChanged: controller.onExteriorRearChanged,
                          imagePath: ImagePath.carRearIcon,
                          title: "Exterior Rear",
                          pickedImagePath: state.exteriorRear.file,
                        ),
                        CustomSizedBox(
                          height: 24,
                        ),
                        BlueButton(
                          buttonIsEnabled: state.isValidInput,
                          wantMargin: false,
                          onTap: () {
                            _selectCarModelBottomSheet();
                          },
                        )
                      ],
                    )),
              ],
            );
          },
        ),
      ),
    );
  }

  _selectCarModelBottomSheet() {
    final TextEditingController registrationNumber = TextEditingController();
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.black.withOpacity(0.7),
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
            return BlocBuilder<BookingRegistrationCubit,
                BookingRegistrationState>(
              builder: (context, state) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.kWhiteFFFF,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                10 * SizeConfig.widthMultiplier!),
                            topRight: Radius.circular(
                                10 * SizeConfig.widthMultiplier!))),
                    height: 300 * SizeConfig.heightMultiplier!,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                RideBackButton(
                                  onTap: () => Navigator.pop(context),
                                ),
                                CustomSizedBox(width: 50),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 45 * SizeConfig.heightMultiplier!),
                                  child: Text("Registration  Number",
                                      style: AppTextStyle.text18black0000W600),
                                ),
                              ],
                            ),
                            CustomSizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20 * SizeConfig.widthMultiplier!),
                              child: Text(
                                "Enter car registration no.  (e.g AA-11-AA-1111)",
                                style: AppTextStyle.text16black0000W500,
                              ),
                            ),
                            CustomSizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20 * SizeConfig.widthMultiplier!,
                                right: 20 * SizeConfig.widthMultiplier!,
                              ),
                              child: Column(
                                children: [
                                  CustomSizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFromField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    customInputFormatters: [
                                      UppercaseInputFormatter()
                                    ],
                                    controller: registrationNumber,
                                    hintText: "X|X     XX    XX   XXXX",
                                    hintTextSize: 16,
                                    textStyle: AppTextStyle.text20black0000W700,
                                  ),
                                ],
                              ),
                            ),
                            CustomSizedBox(
                              height: 20,
                            ),

                            ///Todo add ride id
                            BlueButton(
                              isLoading: state.uploadDocApiStatus.isLoading,
                              wantMargin: true,
                              buttonIsEnabled:
                                  registrationNumber.text.isNotEmpty == true,
                              onTap: () => controller.onSaveCarDataPressed(
                                registrationNumber: registrationNumber.text,
                                rideId: widget.params.ride.rideId ?? '',
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          });
        });
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
                height: 145 * SizeConfig.heightMultiplier!,
              ),
            if (isImagePicked == false) ...{
              SizedBox(
                  height: 130,
                  child: ImageLoader.assetImage(imagePath: imagePath)),
            },
            Expanded(
              child: Container(
                width: 153 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      title ?? "",
                      style: AppTextStyle.text12black0000W500,
                    ),
                    Text(
                      subTitle ?? "",
                      style: AppTextStyle.text12black0000W500,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  repeatedRowContainer({
    String? title,
    String? imagePath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          ImageLoader.svgPictureAssetImage(
              imagePath: imagePath, color: AppColors.kBlackTextColor),
          CustomSizedBox(
            width: 14,
          ),
          Text(title ?? "", style: AppTextStyle.text14unBack0000W400),
        ],
      ),
    );
  }
}
