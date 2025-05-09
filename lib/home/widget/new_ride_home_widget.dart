import 'package:flutter/material.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/app_styles/app_styles.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../../shared/utils/image_loader/image_loader.dart';

class NewRideHomeServiceScreenWidget extends StatelessWidget {
  NewRideHomeServiceScreenWidget(
      {Key? key, this.imagePath, this.onTap, this.title, this.isSelected})
      : super(key: key);

  VoidCallback? onTap;

  String? title;

  String? imagePath;

  bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 14 * SizeConfig.widthMultiplier!,
          right: 0 * SizeConfig.widthMultiplier!
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(left: 5 * SizeConfig.widthMultiplier!, right: 5 * SizeConfig.widthMultiplier!),
          decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected == true
                      ? AppColors.kBlue3D6
                      : Colors.transparent,
                  width: 2 * SizeConfig.widthMultiplier!),
              borderRadius:
                  BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
              color: AppColors.kWhite),
          child: Column(
            children: [
              CustomSizedBox(
                height: 8,
              ),
              ImageLoader.assetImage(
                width: 43 * SizeConfig.widthMultiplier!,
                height: 38 * SizeConfig.widthMultiplier!,
                imagePath: imagePath,
                wantsScale: true,
                scale: 1,
              ),
              CustomSizedBox(
                height: 8,
              ),
              Center(
                child: Text(
                  title ?? "",
                  style: AppTextStyle.text12Bblack0000W500,
                ),
              ),
              CustomSizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
