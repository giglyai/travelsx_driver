import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/imagePath/image_paths.dart';
import '../../utils/image_loader/image_loader.dart';
import '../size_config/size_config.dart';

class BLueButtonWithIcon extends StatelessWidget {
  ///added gestureDetector so that we can make on tap call if it is button or
  ///something like login or signup
  GestureTapCallback? onTap;

  /// added margin so that we can give default value either true or false
  /// because it take boolean data type
  /// default margin is left 69 and right 68
  bool wantMargin;

  /// added tittle so that we can take default value and this value
  /// is taking string type of value
  String? title;

  ///added borderRadius for the container to give radius from all side
  ///of the container and it can be in decimal value
  double? borderRadius;

  /// default height is 45 and its value can be in decimal so we taken
  /// double data type
  double? height;

  /// default width and its value can be in decimal so we taken
  /// double data type
  double? width;

  /// added buttonColor so that we can change  buttonColor according to need
  /// and give this one default value and this is taking color
  /// from appColors (class)
  Color? buttonColor;

  /// added margin so that we can give default value either true or false
  /// because it take boolean data type
  bool wantWhiteTextColor;

  ///added imagePath so that we can add images and change according to need
  ///and imagePath is taking string type of value and this is
  /// from imagePath (class)
  String? imagePath;

  /// this is used to give loading animation to button
  bool isLoading;

  /// this variable take true or false
  /// to enable and desable button
  bool buttonIsEnabled;

  /// this is used to give loading button color on time of loading
  final Color? loadingButtonColor;
  final Color? loadingImageColor;

  ///if want to disable tap when buttonIsEnabled == false make this true
  bool? disableTap;

  Color? borderColor;

  double? borderWidth;

  Color? imageColor;
  Color? textColor;

  BLueButtonWithIcon(
      {Key? key,
      this.buttonIsEnabled = true,
      this.onTap,
      this.wantMargin = true,
      this.wantWhiteTextColor = false,
      this.title,
      this.borderRadius,
      this.height,
      this.width,
      this.buttonColor,
      this.imagePath,
      this.isLoading = false,
      this.loadingButtonColor,
      this.disableTap,
      this.borderColor,
      this.borderWidth,
      this.imageColor,
      this.textColor,
      this.loadingImageColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (buttonIsEnabled == false || disableTap == true) ? null : onTap,
      child: Container(
        margin: wantMargin
            ? EdgeInsets.only(
                left: 21 * SizeConfig.widthMultiplier!,
                right: 24 * SizeConfig.widthMultiplier!)
            : EdgeInsets.zero,
        width: width ?? 330 * SizeConfig.widthMultiplier!,
        height: height ?? 56 * SizeConfig.heightMultiplier!,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 10,
                color: const Color(0xff000000).withOpacity(0.2)),
          ],
          border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 1 * SizeConfig.widthMultiplier!),
          borderRadius: BorderRadius.circular(
              borderRadius ?? (8 * SizeConfig.widthMultiplier!)),
          color: buttonIsEnabled == false
              ? AppColors.kGrey8C8C8C
              : (loadingButtonColor != null && isLoading == true
                  ? loadingButtonColor
                  : (buttonColor ?? AppColors.kBlue3D6)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading == false && buttonIsEnabled == false)
              ImageLoader.svgPictureAssetImage(
                  imagePath: imagePath,
                  width: 24 * SizeConfig.widthMultiplier!,
                  height: 24 * SizeConfig.heightMultiplier!,
                  color: AppColors.kWhite),
            if (buttonIsEnabled == true && isLoading == false)
              ImageLoader.svgPictureAssetImage(
                  imagePath: imagePath,
                  width: 24 * SizeConfig.widthMultiplier!,
                  height: 24 * SizeConfig.heightMultiplier!,
                  color: imageColor),
            SizedBox(
              width: 5 * SizeConfig.widthMultiplier!,
            ),
            isLoading == true
                ? ImageLoader.assetImage(
                    imagePath: ImagePath.loaderImage,
                    width: 80 * SizeConfig.widthMultiplier!,
                    //loaderColor: loadingImageColor ?? AppColors.kWhite
                    )
                : buttonIsEnabled == false
                    ? Text(
                        title ?? "",
                        style: TextStyle(
                            color: AppColors.kWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.textMultiplier! * (15.0)),
                      )
                    : Text(title ?? "",
                        style: TextStyle(
                            color: textColor ?? AppColors.kWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.textMultiplier! * (15.0))),
          ],
        ),
      ),
    );
  }
}
