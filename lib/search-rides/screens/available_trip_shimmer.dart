import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/size_config/size_config.dart';

class AvailableTripShimmer extends StatelessWidget {
  const AvailableTripShimmer({super.key});

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
            height: 28,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20 * SizeConfig.widthMultiplier!,
                right: 20 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 293 * SizeConfig.heightMultiplier!,
                width: 353 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(
                    6 * SizeConfig.widthMultiplier!,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15 * SizeConfig.heightMultiplier!,
                        left: 8 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 119 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                6 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 85 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                10 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 9,
                          ),
                          Container(
                            height: 28 * SizeConfig.heightMultiplier!,
                            width: 95 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 15 * SizeConfig.heightMultiplier!,
                            width: 194 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                          CustomSizedBox(
                            width: 55,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 8 * SizeConfig.heightMultiplier!,
                            ),
                            child: Container(
                              height: 13 * SizeConfig.heightMultiplier!,
                              width: 59 * SizeConfig.widthMultiplier!,
                              decoration: BoxDecoration(
                                color: containerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 237 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                10 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 11,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 39 * SizeConfig.widthMultiplier!,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15 * SizeConfig.heightMultiplier!,
                                width: 198 * SizeConfig.widthMultiplier!,
                                decoration: BoxDecoration(
                                  color: containerColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 11 * SizeConfig.heightMultiplier!,
                                  left: 5 * SizeConfig.widthMultiplier!
                                ),
                                child: Container(
                                  height: 21 * SizeConfig.heightMultiplier!,
                                  width: 59 * SizeConfig.widthMultiplier!,
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(
                                      10 * SizeConfig.widthMultiplier!,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 17 * SizeConfig.heightMultiplier!,
                            width: 90 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(height: 5,),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 39 * SizeConfig.widthMultiplier!,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15 * SizeConfig.heightMultiplier!,
                                width: 198 * SizeConfig.widthMultiplier!,
                                decoration: BoxDecoration(
                                  color: containerColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 11 * SizeConfig.heightMultiplier!,
                                  left: 5 * SizeConfig.widthMultiplier!
                                ),
                                child: Container(
                                  height: 21 * SizeConfig.heightMultiplier!,
                                  width: 59 * SizeConfig.widthMultiplier!,
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(
                                      10 * SizeConfig.widthMultiplier!,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 17 * SizeConfig.heightMultiplier!,
                            width: 90 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(height: 19,),
                    Center(
                      child: Container(
                        height: 30 * SizeConfig.heightMultiplier!,
                        width: 237 * SizeConfig.widthMultiplier!,
                        decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(
                            10 * SizeConfig.widthMultiplier!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomSizedBox(
            height: 20,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20 * SizeConfig.widthMultiplier!,
                right: 20 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 293 * SizeConfig.heightMultiplier!,
                width: 353 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(
                    6 * SizeConfig.widthMultiplier!,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15 * SizeConfig.heightMultiplier!,
                        left: 8 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 119 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                6 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 85 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                10 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 9,
                          ),
                          Container(
                            height: 28 * SizeConfig.heightMultiplier!,
                            width: 95 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 15 * SizeConfig.heightMultiplier!,
                            width: 194 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                          CustomSizedBox(
                            width: 55,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 8 * SizeConfig.heightMultiplier!,
                            ),
                            child: Container(
                              height: 13 * SizeConfig.heightMultiplier!,
                              width: 59 * SizeConfig.widthMultiplier!,
                              decoration: BoxDecoration(
                                color: containerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 237 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                10 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 11,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 39 * SizeConfig.widthMultiplier!,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15 * SizeConfig.heightMultiplier!,
                                width: 198 * SizeConfig.widthMultiplier!,
                                decoration: BoxDecoration(
                                  color: containerColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 11 * SizeConfig.heightMultiplier!,
                                    left: 5 * SizeConfig.widthMultiplier!
                                ),
                                child: Container(
                                  height: 21 * SizeConfig.heightMultiplier!,
                                  width: 59 * SizeConfig.widthMultiplier!,
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(
                                      10 * SizeConfig.widthMultiplier!,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 17 * SizeConfig.heightMultiplier!,
                            width: 90 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(height: 5,),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 39 * SizeConfig.widthMultiplier!,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15 * SizeConfig.heightMultiplier!,
                                width: 198 * SizeConfig.widthMultiplier!,
                                decoration: BoxDecoration(
                                  color: containerColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 11 * SizeConfig.heightMultiplier!,
                                    left: 5 * SizeConfig.widthMultiplier!
                                ),
                                child: Container(
                                  height: 21 * SizeConfig.heightMultiplier!,
                                  width: 59 * SizeConfig.widthMultiplier!,
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(
                                      10 * SizeConfig.widthMultiplier!,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 17 * SizeConfig.heightMultiplier!,
                            width: 90 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(height: 19,),
                    Center(
                      child: Container(
                        height: 30 * SizeConfig.heightMultiplier!,
                        width: 237 * SizeConfig.widthMultiplier!,
                        decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(
                            10 * SizeConfig.widthMultiplier!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
