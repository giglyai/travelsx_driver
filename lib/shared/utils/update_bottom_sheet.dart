import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/utils/StoreRedirect.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';

import '../../global_variables.dart';
import '../constants/app_colors/app_colors.dart';
import '../constants/app_styles/app_styles.dart';
import '../widgets/custom_sized_box/custom_sized_box.dart';
import '../widgets/size_config/size_config.dart';

class UpdateBottomSheet {
  updateBottomSheet({
    required BuildContext context,
  }) {
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
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
            return WillPopScope(
              onWillPop: () async {

                return isUpdateCrucial;
              },
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(20 * SizeConfig.widthMultiplier!),
                          topRight: Radius.circular(
                              20 * SizeConfig.widthMultiplier!))),
                  height: isUpdateCrucial == true ? 299  * SizeConfig.heightMultiplier! :  280 * SizeConfig.heightMultiplier!,
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomSizedBox(
                            height: 20,
                          ),
                          ImageLoader.svgPictureAssetImage(
                              imagePath: ImagePath.updateIcon),
                          CustomSizedBox(
                            height: 14,
                          ),
                          Text(
                            "New update available!",
                            style: AppTextStyle.text16black0000W700,
                          ),

                          CustomSizedBox(
                            height: 14,
                          ),

                          Text(
                            "v${updateAppVersion ?? ""}",
                            style: AppTextStyle.textGreen198F52W400
                                ?.copyWith(decoration: TextDecoration.underline),
                          ),
                          CustomSizedBox(
                            height: 14,
                          ),
                          Text(
                            "Update your app for an improved\nexperience!",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.text12kBlack272727W400,
                          ),

                          CustomSizedBox(
                            height: 16,
                          ),

                          BlueButton(
                            borderRadius: 4 * SizeConfig.widthMultiplier!,
                            height: 44 * SizeConfig.heightMultiplier!,
                            title: "Update App",
                            fontSize: 16 * SizeConfig.textMultiplier!,
                            onTap: () {
                              StoreRedirect.openStore();
                            },
                          ),
                          CustomSizedBox(
                            height: 10,
                          ),

                          if(isUpdateCrucial == true)
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Text("SKIP",
                              style: AppTextStyle.text16kBlue3D60W500?.copyWith(
                                decoration: TextDecoration.underline
                              ),
                              ),
                            )

                        ],
                      )),
                ),
              ),
            );
          });
        });
  }
}
