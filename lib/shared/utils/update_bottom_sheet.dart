import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travelx_driver/flavors.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';

import '../../global_variables.dart';
import '../constants/app_colors/app_colors.dart';
import '../constants/app_styles/app_styles.dart';
import '../widgets/custom_sized_box/custom_sized_box.dart';
import '../widgets/size_config/size_config.dart';

class UpdateBottomSheet {
  final ValueNotifier<double> _progressNotifier = ValueNotifier(0.0);

  void updateBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: isUpdateCrucial == false ? false : true,
      backgroundColor: Colors.black.withOpacity(0.7),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
      ),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => isUpdateCrucial,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20 * SizeConfig.widthMultiplier!),
                  topRight: Radius.circular(20 * SizeConfig.widthMultiplier!),
                ),
              ),
              height: 340 * SizeConfig.heightMultiplier!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSizedBox(height: 20),
                  ImageLoader.svgPictureAssetImage(
                    imagePath: ImagePath.updateIcon,
                  ),
                  CustomSizedBox(height: 14),
                  Text(
                    "New update available!",
                    style: AppTextStyle.text16black0000W700,
                  ),
                  CustomSizedBox(height: 10),
                  Text(
                    "v${updateAppVersion ?? ""}",
                    style: AppTextStyle.textGreen198F52W400?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  CustomSizedBox(height: 12),
                  Text(
                    "Update your app for an improved\nexperience!",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.text12kBlack272727W400,
                  ),
                  CustomSizedBox(height: 16),

                  // Progress bar or Update button
                  ValueListenableBuilder<double>(
                    valueListenable: _progressNotifier,
                    builder: (_, value, __) {
                      if (value > 0 && value < 1) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: value,
                                  minHeight: 10,
                                  backgroundColor: Colors.grey.shade300,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.kBlue3D6,
                                  ),
                                ),
                              ),
                              CustomSizedBox(height: 12),
                              Text(
                                "${(value * 100).toStringAsFixed(0)}% Downloaded",
                                style: AppTextStyle.text12kBlack272727W400,
                              ),
                            ],
                          ),
                        );
                      }

                      return BlueButton(
                        title: "Update App",
                        height: 44 * SizeConfig.heightMultiplier!,
                        fontSize: 16 * SizeConfig.textMultiplier!,
                        borderRadius: 4 * SizeConfig.widthMultiplier!,
                        onTap: () => _downloadApk(context),
                      );
                    },
                  ),

                  CustomSizedBox(height: 10),

                  if (isUpdateCrucial == true)
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "SKIP",
                        style: AppTextStyle.text16kBlue3D60W500?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _downloadApk(BuildContext context) async {
    try {
      final permission = await Permission.storage.request();
      if (!permission.isGranted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Storage permission denied")));
        return;
      }

      final dir = await getExternalStorageDirectory();
      final filePath = "${dir!.path}/app-update.apk";

      // 🔥 Select APK URL based on flavor
      String apkUrl = "";
      if (F.appFlavor == Flavor.goguldriver) {
        apkUrl =
            "https://giglyusers.blob.core.windows.net/apk/gogulcabtaxi/app-goguldriver-release.apk";
      } else if (F.appFlavor == Flavor.uzhavandriver) {
        apkUrl =
            "https://giglyusers.blob.core.windows.net/apk/uzhavantaxi/app-uzhavandriver-release.apk";
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Unknown app flavor")));
        return;
      }

      Dio dio = Dio();
      await dio.download(
        apkUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            _progressNotifier.value = received / total;
          }
        },
      );

      await OpenFile.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Download failed: $e")));
    }
  }
}
