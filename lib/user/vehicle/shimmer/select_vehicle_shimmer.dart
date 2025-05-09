import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../../shared/widgets/size_config/size_config.dart';

class SelectVehicleScreenShimmer extends StatelessWidget {
  const SelectVehicleScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Color containerColor = Colors.grey.withOpacity(0.3);
    Color baseColor = Colors.grey.withOpacity(0.55);
    Color highlightColor = Colors.white.withOpacity(0.6);
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 21 * SizeConfig.widthMultiplier!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedBox(
              height: 150,
            ),
            Shimmer.fromColors(
              highlightColor: highlightColor,
              baseColor: baseColor,
              child: Container(
                height: 121 * SizeConfig.heightMultiplier!,
                width: 336 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
                  color: containerColor,
                ),
              ),
            ),
            CustomSizedBox(
              height: 20,
            ), Shimmer.fromColors(
              highlightColor: highlightColor,
              baseColor: baseColor,
              child: Container(
                height: 121 * SizeConfig.heightMultiplier!,
                width: 336 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
                  color: containerColor,
                ),
              ),
            ),
            CustomSizedBox(
              height: 20,
            ), Shimmer.fromColors(
              highlightColor: highlightColor,
              baseColor: baseColor,
              child: Container(
                height: 121 * SizeConfig.heightMultiplier!,
                width: 336 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
                  color: containerColor,
                ),
              ),
            ),
            CustomSizedBox(
              height: 20,
            ), Shimmer.fromColors(
              highlightColor: highlightColor,
              baseColor: baseColor,
              child: Container(
                height: 121 * SizeConfig.heightMultiplier!,
                width: 336 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
                  color: containerColor,
                ),
              ),
            ),
            CustomSizedBox(
              height: 20,
            ), Shimmer.fromColors(
              highlightColor: highlightColor,
              baseColor: baseColor,
              child: Container(
                height: 121 * SizeConfig.heightMultiplier!,
                width: 336 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
                  color: containerColor,
                ),
              ),
            ),
            CustomSizedBox(
              height: 20,
            ), Shimmer.fromColors(
              highlightColor: highlightColor,
              baseColor: baseColor,
              child: Container(
                height: 121 * SizeConfig.heightMultiplier!,
                width: 336 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
                  color: containerColor,
                ),
              ),
            ),
            CustomSizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}