import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/widgets/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';

class CustomDropDown extends StatelessWidget {
  CustomDropDown(
      {super.key,
      this.dropDownListIsOpened = false,
      this.onTapToHideAndShowDropDown,
      required this.controller,
      required this.getListUI,
      this.topPadding,
      this.width,
      this.borderColor});

  bool? dropDownListIsOpened;
  VoidCallback? onTapToHideAndShowDropDown;
  TextEditingController controller = TextEditingController();
  Widget getListUI;
  double? topPadding;

  double? width = 300 * SizeConfig.widthMultiplier!;

  Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTapToHideAndShowDropDown,
            child: CustomTextFromField(
              topPadding: topPadding ?? 20 * SizeConfig.heightMultiplier!,
              disabledBorder: 8,
              wantDisabledBorderColor: borderColor ?? AppColors.kBlue3D6DFE,
              controller: controller,
              hintText: controller.text,
              enabled: false,
              wantFilledColor: true,
              wantDisabledBorder: false,
              filledColor: AppColors.kWhite,
              hintTextStyle: AppTextStyle.text14kblack333333W600,
              suffixIcon: ImageLoader.svgPictureAssetImage(
                  imagePath: ImagePath.arrowIcon),
            ),
          ),
          if (dropDownListIsOpened == true)
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 11 * SizeConfig.widthMultiplier!),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kBlackTextColor.withOpacity(0.15),
                    blurRadius: 3, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                  )
                ],
              ),
              child: getListUI,
            ),
        ],
      ),
    );
  }
}
