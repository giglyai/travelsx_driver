import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/widgets/size_config/size_config.dart';

class RideSettlementAmountCard extends StatelessWidget {
  final String settlementAmount;
  final String pickupAddress;
  final String dropupAddress;
  final String currency;
  const RideSettlementAmountCard({
    super.key,
    required this.settlementAmount,
    required this.pickupAddress,
    required this.dropupAddress,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius:
              BorderRadius.circular(11 * SizeConfig.widthMultiplier!)),
      width: 351 * SizeConfig.widthMultiplier!,
      child: Padding(
        padding: EdgeInsets.only(
            left: 21 * SizeConfig.widthMultiplier!,
            top: 20 * SizeConfig.heightMultiplier!,
            bottom: 40 * SizeConfig.heightMultiplier!),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox.shrink(),
                Spacer(),
                Text(
                  "Payment Received",
                  style: TextStyle(
                      color: AppColors.kBlackTextColor.withOpacity(0.60),
                      fontSize: 20 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w400),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    AnywhereDoor.pushReplacementNamed(
                      context,
                      routeName: RouteName.homeScreen,
                    );
                  },
                  child: SvgPicture.asset(
                    ImagePath.closeIcon,
                  ),
                ),
                CustomSizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 10 * SizeConfig.heightMultiplier!,
            ),
            ImageLoader.svgPictureAssetImage(imagePath: ImagePath.redWallet),
            SizedBox(
              height: 10 * SizeConfig.heightMultiplier!,
            ),
            Text(
              "$currency $settlementAmount",
              style: TextStyle(
                  color: AppColors.kBlackTextColor,
                  fontSize: 40 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10 * SizeConfig.heightMultiplier!,
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      ImagePath.locBIcon,
                    ),
                    SizedBox(
                      width: 9 * SizeConfig.widthMultiplier!,
                    ),
                    SizedBox(
                      width: 280 * SizeConfig.widthMultiplier!,
                      child: Text(
                        pickupAddress,
                        style: TextStyle(
                            color: AppColors.kBlackTextColor.withOpacity(0.50),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w400),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 30 * SizeConfig.widthMultiplier!,
                      right: 60 * SizeConfig.widthMultiplier!),
                  child: const Divider(),
                ),
                SizedBox(
                  height: 14 * SizeConfig.heightMultiplier!,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      ImagePath.dropBIcon,
                    ),
                    SizedBox(
                      width: 9 * SizeConfig.widthMultiplier!,
                    ),
                    SizedBox(
                      width: 280 * SizeConfig.widthMultiplier!,
                      child: Text(
                        dropupAddress,
                        style: TextStyle(
                            color: AppColors.kBlackTextColor.withOpacity(0.50),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomSizedBox(
              height: 16,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color(0xffF6F6F6),
                ),
                height: 61 * SizeConfig.heightMultiplier!,
                width: 259 * SizeConfig.widthMultiplier!,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 50.0 * SizeConfig.widthMultiplier!,
                  ),
                  child: Row(
                    children: [
                      ImageLoader.svgPictureAssetImage(
                          imagePath: ImagePath.redWallet),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 8.0 * SizeConfig.heightMultiplier!,
                            ),
                            child: Text(
                              'You’ve Earned',
                              style: AppTextStyle.text14black0000W400,
                            ),
                          ),
                          Text(
                            "$currency $settlementAmount",
                            style: TextStyle(
                                color: AppColors.kBlackTextColor,
                                fontSize: 18 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
