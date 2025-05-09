import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';
import '../custom_sized_box/custom_sized_box.dart';
import '../size_config/size_config.dart';

class CustomTab extends StatefulWidget {
  CustomTab({Key? key, required this.backFrontTab, required this.onTap})
      : super(key: key);

  bool backFrontTab = true;

  VoidCallback onTap;

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: 6 * SizeConfig.heightMultiplier!,
          top: 6 * SizeConfig.heightMultiplier!),
      width: 185 * SizeConfig.widthMultiplier!,
      decoration: BoxDecoration(
          color: AppColors.kBlackD9D9D9,
          borderRadius: BorderRadius.circular(5 * SizeConfig.widthMultiplier!)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: EdgeInsets.only(
                  bottom: 4 * SizeConfig.heightMultiplier!,
                  top: 4 * SizeConfig.heightMultiplier!),
              width: 73 * SizeConfig.widthMultiplier!,
              decoration: BoxDecoration(
                  color: widget.backFrontTab == true
                      ? AppColors.kWhite
                      : AppColors.kBlackD9D9D9,
                  borderRadius:
                      BorderRadius.circular(5 * SizeConfig.widthMultiplier!)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Front side",
                    style: TextStyle(
                        color: AppColors.kBlackTextColor.withOpacity(0.62),
                        fontWeight: FontWeight.w700,
                        fontSize: 14 * SizeConfig.textMultiplier!),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: EdgeInsets.only(
                  bottom: 4 * SizeConfig.heightMultiplier!,
                  top: 4 * SizeConfig.heightMultiplier!),
              width: 73 * SizeConfig.widthMultiplier!,
              decoration: BoxDecoration(
                  color: widget.backFrontTab == false
                      ? AppColors.kWhite
                      : AppColors.kBlackD9D9D9,
                  borderRadius:
                      BorderRadius.circular(5 * SizeConfig.widthMultiplier!)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSizedBox(
                    width: 2,
                  ),
                  Text(
                    "Backside",
                    style: TextStyle(
                        color: AppColors.kBlackTextColor.withOpacity(0.62),
                        fontWeight: FontWeight.w700,
                        fontSize: 14 * SizeConfig.textMultiplier!),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
