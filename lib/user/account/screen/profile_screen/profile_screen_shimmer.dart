import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../../shared/widgets/size_config/size_config.dart';

class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Color containerColor = Colors.grey.withOpacity(0.3);
    Color baseColor = Colors.grey.withOpacity(0.55);
    Color highlightColor = Colors.white.withOpacity(0.6);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox(
            height: 78 * SizeConfig.heightMultiplier!,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
                padding: EdgeInsets.only(
                  left: 20 * SizeConfig.widthMultiplier!,
                ),
                child: Container(
                  height: 24 * SizeConfig.heightMultiplier!,
                  width: 137 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    color: containerColor,
                  ),
                )),
          ),
          CustomSizedBox(
            height: 20 * SizeConfig.heightMultiplier!,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 80 * SizeConfig.heightMultiplier!,
                width: 80 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                    color: containerColor, shape: BoxShape.circle),
              ),
            ),
          ),
          CustomSizedBox(
            height: 20 * SizeConfig.heightMultiplier!,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
                padding: EdgeInsets.only(
                  left: 20 * SizeConfig.widthMultiplier!,
                ),
                child: Container(
                  height: 24 * SizeConfig.heightMultiplier!,
                  width: 137 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    color: containerColor,
                    // borderRadius: BorderRadius.circular(
                    //   6 * SizeConfig.widthMultiplier!,
                    // ),
                  ),
                )),
          ),
          CustomSizedBox(
            height: 20 * SizeConfig.heightMultiplier!,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
                padding: EdgeInsets.only(
                  left: 20 * SizeConfig.widthMultiplier!,
                ),
                child: Container(
                  height: 24 * SizeConfig.heightMultiplier!,
                  width: 310 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    color: containerColor,
                  ),
                )),
          ),
          CustomSizedBox(
            height: 30 * SizeConfig.heightMultiplier!,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
                padding: EdgeInsets.only(
                  left: 20 * SizeConfig.widthMultiplier!,
                ),
                child: Container(
                  height: 24 * SizeConfig.heightMultiplier!,
                  width: 137 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    color: containerColor,
                    // borderRadius: BorderRadius.circular(
                    //   6 * SizeConfig.widthMultiplier!,
                    // ),
                  ),
                )),
          ),
          CustomSizedBox(
            height: 20 * SizeConfig.heightMultiplier!,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
                padding: EdgeInsets.only(
                  left: 20 * SizeConfig.widthMultiplier!,
                ),
                child: Container(
                  height: 24 * SizeConfig.heightMultiplier!,
                  width: 310 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    color: containerColor,
                  ),
                )),
          ),
          CustomSizedBox(
            height: 30,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
                padding: EdgeInsets.only(
                  left: 20 * SizeConfig.widthMultiplier!,
                ),
                child: Container(
                  height: 24 * SizeConfig.heightMultiplier!,
                  width: 137 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    color: containerColor,
                    // borderRadius: BorderRadius.circular(
                    //   6 * SizeConfig.widthMultiplier!,
                    // ),
                  ),
                )),
          ),
          CustomSizedBox(
            height: 20 * SizeConfig.heightMultiplier!,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
                padding: EdgeInsets.only(
                  left: 20 * SizeConfig.widthMultiplier!,
                ),
                child: Container(
                  height: 24 * SizeConfig.heightMultiplier!,
                  width: 310 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    color: containerColor,
                  ),
                )),
          ),
          CustomSizedBox(
            height: 30 * SizeConfig.heightMultiplier!,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
                padding: EdgeInsets.only(
                  left: 20 * SizeConfig.widthMultiplier!,
                ),
                child: Container(
                  height: 24 * SizeConfig.heightMultiplier!,
                  width: 137 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    color: containerColor,
                    // borderRadius: BorderRadius.circular(
                    //   6 * SizeConfig.widthMultiplier!,
                    // ),
                  ),
                )),
          ),
          CustomSizedBox(
            height: 20 * SizeConfig.heightMultiplier!,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20 * SizeConfig.widthMultiplier!,
            ),
            child: Row(
              children: [
                Shimmer.fromColors(
                  highlightColor: highlightColor,
                  baseColor: baseColor,
                  child: Container(
                    height: 24 * SizeConfig.heightMultiplier!,
                    width: 30 * SizeConfig.widthMultiplier!,
                    decoration: BoxDecoration(
                      color: containerColor,
                    ),
                  ),
                ),
                CustomSizedBox(
                  width: 16 * SizeConfig.widthMultiplier!,
                ),
                Shimmer.fromColors(
                  highlightColor: highlightColor,
                  baseColor: baseColor,
                  child: Container(
                    height: 24 * SizeConfig.heightMultiplier!,
                    width: 210 * SizeConfig.widthMultiplier!,
                    decoration: BoxDecoration(
                      color: containerColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomSizedBox(
            height: 155,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Center(
              child: Container(
                height: 43 * SizeConfig.heightMultiplier!,
                width: 313 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(
                    4 * SizeConfig.widthMultiplier!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
