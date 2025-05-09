import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/documents/bloc/document_cubit.dart';
import 'package:travelx_driver/home/widget/image_picker_widgets/camera.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/constants/imagePath/image_paths.dart';
import '../../shared/widgets/buttons/blue_button.dart';
import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/custom_tab/custom_tab.dart';
import '../../shared/widgets/custom_toast/custom_toast.dart';
import '../../shared/widgets/size_config/size_config.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({Key? key}) : super(key: key);

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  bool backFrontTab = true;

  late DocumentCubit _documentCubit;

  String? path;

  captureImage() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    XFile? image = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => TakePictureScreen(
                  camera: firstCamera,
                  availableCameras: cameras,
                )));

    if (kDebugMode) {
      print("helllooooooooooooooo${image?.path}");
    }
    if (image != null) {
      if (kDebugMode) {
        print(image.path);
      }
      setState(() {
        path = image.path;
      });
    }
  }

  @override
  void initState() {
    _documentCubit = BlocProvider.of<DocumentCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 18 * SizeConfig.widthMultiplier!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ),
              child: RideBackButton(),
            ),
            Center(
              child: Text(
                "Driver Requirements",
                style: TextStyle(
                    color: AppColors.kBlackTextColor,
                    fontSize: 18 * SizeConfig.textMultiplier!,
                    fontWeight: FontWeight.w700),
              ),
            ),
            CustomSizedBox(
              height: 41,
            ),
            Text(
              "Upload Photo of your \ndriver’s license",
              style: TextStyle(
                  color: AppColors.kBlackTextColor,
                  fontSize: 24 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.w600),
            ),
            CustomSizedBox(
              height: 14,
            ),
            CustomTab(
              backFrontTab: backFrontTab,
              onTap: () {
                setState(() {});
                backFrontTab = !backFrontTab;
              },
            ),
            CustomSizedBox(
              height: 30,
            ),
            if (path != null)
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10 * SizeConfig.widthMultiplier!),
                child: Image.file(
                  File(path ?? ""),
                  height: 230 * SizeConfig.widthMultiplier!,
                  width: 348,
                  fit: BoxFit.fitWidth,
                ),
              ),
            CustomSizedBox(
              height: 14,
            ),
            Text(
              "Make sure the photo and texts  are clear and \nvisible.",
              style: TextStyle(
                  color: AppColors.kBlackTextColor.withOpacity(0.62),
                  fontSize: 14 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.w400),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 32 * SizeConfig.heightMultiplier!,
                  right: 22 * SizeConfig.widthMultiplier!),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: BlueButton(
                      onTap: () {
                        captureImage();
                      },
                      title: "upload",
                      wantMargin: false,
                      height: 60 * SizeConfig.heightMultiplier!,
                      borderRadius: 4 * SizeConfig.widthMultiplier!,
                      buttonColor: AppColors.kBlack5A5A5A,
                    ),
                  ),
                  CustomSizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: BlocConsumer<DocumentCubit, DocumentState>(
                      listener: (context, state) {
                        if (state is DocumentSuccess) {
                          CustomToastUtils.showToast(
                              title: state.message ?? '',
                              context: context,
                              imagePath: ImagePath.successIcon,
                              toastColor: AppColors.kGreen47D7);
                        }

                        if (state is DocumentFailure) {
                          CustomToastUtils.showToast(
                              title: state.message ?? '',
                              context: context,
                              imagePath: ImagePath.errorIcon,
                              toastColor: AppColors.kRedFF355);
                        }
                      },
                      builder: (context, state) {
                        return BlueButton(
                          isLoading: state is DocumentLoading,
                          onTap: () async {
                            if (path != null) {
                              // TODO:- show loader;

                              await _documentCubit.updateUserDocument(
                                  imagePath: path ?? "");

                              // AnywhereDoor.pop(context);
                            }

                            path = null;
                          },
                          title: "Submit",
                          wantMargin: false,
                          height: 60 * SizeConfig.heightMultiplier!,
                          borderRadius: 4 * SizeConfig.widthMultiplier!,
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
