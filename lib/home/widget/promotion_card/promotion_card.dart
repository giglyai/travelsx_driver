import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelx_driver/home/models/promotion_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/widgets/size_config/size_config.dart';

class PromotionCard extends StatelessWidget {
  final List<Datum>? promotionModel;

  const PromotionCard({super.key, this.promotionModel});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: promotionModel?.length ?? 0,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.kWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10 * SizeConfig.heightMultiplier!,
              ),
              Center(
                child: Container(
                  height: 4 * SizeConfig.heightMultiplier!,
                  width: 50 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    color: AppColors.kBlackTextColor.withOpacity(0.25),
                    borderRadius:
                        BorderRadius.circular(4 * SizeConfig.widthMultiplier!),
                  ),
                ),
              ),
              SizedBox(
                height: 18 * SizeConfig.heightMultiplier!,
              ),
              Center(
                child: Text(
                  promotionModel?[index].title ?? "",
                  style: TextStyle(
                      color: AppColors.kBlackTextColor.withOpacity(0.7),
                      fontSize: 20 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 18 * SizeConfig.heightMultiplier!,
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 34 * SizeConfig.widthMultiplier!),
                    child: Text(
                      "${promotionModel?[index].completedDelivery} of ${promotionModel?[index].totalDelivery} deliveries completed",
                      style: TextStyle(
                          color: AppColors.kBlackTextColor,
                          fontSize: 14 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 34 * SizeConfig.widthMultiplier!),
                    child: Text(
                      "${promotionModel?[index].daysLeftMsg}",
                      style: TextStyle(
                          color: AppColors.kBlackTextColor,
                          fontSize: 14 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10 * SizeConfig.heightMultiplier!,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15 * SizeConfig.widthMultiplier!,
                    right: 15 * SizeConfig.widthMultiplier!),
                child: SfSlider(
                  activeColor: AppColors.kBlue3D6,
                  inactiveColor: AppColors.dividerwhiteE2E2,
                  min: promotionModel?[index].completedDelivery?.toDouble(),
                  max: promotionModel?[index].totalDelivery,
                  value: promotionModel?[index].completedDelivery?.toDouble(),
                  enableTooltip: true,
                  tooltipShape: const SfRectangularTooltipShape(),
                  onChanged: null,
                ),
              ),
              SizedBox(
                height: 15 * SizeConfig.heightMultiplier!,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 36 * SizeConfig.widthMultiplier!, right: 40),
                child: Text(
                  "${promotionModel?[index].name} to get ${promotionModel?[index].value} as a bonus ",
                  style: TextStyle(
                      color: AppColors.kBlackTextColor.withOpacity(0.7),
                      fontSize: 14 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 12 * SizeConfig.heightMultiplier!,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80 * SizeConfig.heightMultiplier!,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 32 * SizeConfig.widthMultiplier!),
                      child: VerticalDivider(
                        thickness: 2 * SizeConfig.widthMultiplier!,
                        color: AppColors.kBlackTextColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5 * SizeConfig.heightMultiplier!,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(ImagePath.promoDeliveryIcon),
                          SizedBox(
                            width: 7 * SizeConfig.widthMultiplier!,
                          ),
                          Text(
                            "${promotionModel?[index].name} ",
                            style: TextStyle(
                                color:
                                    AppColors.kBlackTextColor.withOpacity(0.4),
                                fontSize: 14 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10 * SizeConfig.heightMultiplier!,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(ImagePath.dollarIcon),
                          SizedBox(
                            width: 5 * SizeConfig.widthMultiplier!,
                          ),
                          Text(
                            "${promotionModel?[index].value} ",
                            style: TextStyle(
                                color:
                                    AppColors.kBlackTextColor.withOpacity(0.4),
                                fontSize: 14 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10 * SizeConfig.heightMultiplier!,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            ImagePath.locationIcon,
                            width: 20 * SizeConfig.widthMultiplier!,
                            height: 20 * SizeConfig.heightMultiplier!,
                          ),
                          SizedBox(
                            width: 6 * SizeConfig.widthMultiplier!,
                          ),
                          Text(
                            "${promotionModel?[index].location} ",
                            style: TextStyle(
                                color:
                                    AppColors.kBlackTextColor.withOpacity(0.4),
                                fontSize: 14 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
