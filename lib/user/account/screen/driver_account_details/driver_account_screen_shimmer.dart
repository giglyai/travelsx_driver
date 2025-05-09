import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../../shared/widgets/size_config/size_config.dart';

class DriverAccountScreenShimmer extends StatelessWidget {
  const DriverAccountScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Color containerColor = Colors.grey.withOpacity(0.3);
    Color baseColor = Colors.grey.withOpacity(0.55);
    Color highlightColor = Colors.white.withOpacity(0.6);
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 26 * SizeConfig.widthMultiplier!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              highlightColor: highlightColor,
              baseColor: baseColor,
              child: Container(
                height: 26 * SizeConfig.heightMultiplier!,
                width: 227 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                ),
              ),
            ),
            CustomSizedBox(
              height: 20,
            ),
            Shimmer.fromColors(
              highlightColor: highlightColor,
              baseColor: baseColor,
              child: Container(
                height: 20 * SizeConfig.heightMultiplier!,
                width: 127 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                ),
              ),
            ),
            CustomSizedBox(
              height: 20,
            ),
            Shimmer.fromColors(
              highlightColor: highlightColor,
              baseColor: baseColor,
              child: Container(
                height: 54 * SizeConfig.heightMultiplier!,
                width: 317 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(5 * SizeConfig.widthMultiplier!)
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
