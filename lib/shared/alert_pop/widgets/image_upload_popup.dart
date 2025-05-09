import 'package:flutter/material.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadPopUp extends StatefulWidget {
  final Function(String? filePath) onFilePicked;
  const ImageUploadPopUp({
    super.key,
    required this.onFilePicked,
  });

  static Future<dynamic> pick({
    required Function(String? filePath) onFilePicked,
  }) {
    return showDialog(
      context: navigatorKey.currentState!.context,
      barrierColor: AppColors.kBlackTextColor.withOpacity(0.45),
      barrierDismissible: true,
      builder: (context) {
        return SizedBox(
          height: 170 * SizeConfig.heightMultiplier!,
          child: ImageUploadPopUp(
            onFilePicked: onFilePicked,
          ),
        );
      },
    );
  }

  @override
  State<ImageUploadPopUp> createState() => _ImageUploadPopUpState();
}

class _ImageUploadPopUpState extends State<ImageUploadPopUp> {
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.kWhite,
      child: Container(
        height: 170 * SizeConfig.heightMultiplier!,
        decoration: BoxDecoration(
            color: AppColors.kWhiteFFFF,
            borderRadius:
                BorderRadius.circular(4 * SizeConfig.widthMultiplier!)),
        child: Padding(
          padding: EdgeInsets.only(left: 20 * SizeConfig.widthMultiplier!),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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
                    const Spacer(),
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
                      "Choose from library",
                      style: AppTextStyle.text16kBlackTextColorW500.copyWith(
                          color: AppColors.kBlackTextColor.withOpacity(0.60),
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
                      "Take Photo",
                      style: AppTextStyle.text16kBlackTextColorW500.copyWith(
                          color: AppColors.kBlackTextColor.withOpacity(0.60),
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
    );
  }

  captureFrontImage() async {
    final XFile? image =
        await picker.pickImage(imageQuality: 10, source: ImageSource.camera);

    if (image?.path.isNotEmpty == true) {
      widget.onFilePicked.call(image?.path);
    }
  }

  Future<void> uploadFrontFile() async {
    final XFile? result =
        await picker.pickImage(imageQuality: 10, source: ImageSource.gallery);
    if (result != null) {
      if (result.path.isNotEmpty == true) {
        widget.onFilePicked.call(result.path);
      }
    }
  }
}
