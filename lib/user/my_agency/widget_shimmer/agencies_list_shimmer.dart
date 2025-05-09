import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/size_config/size_config.dart';

class AgenciesListShimmer extends StatelessWidget {
  const AgenciesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Color containerColor = Colors.grey.withOpacity(0.3);
    Color baseColor = Colors.grey.withOpacity(0.55);
    Color highlightColor = Colors.white.withOpacity(0.6);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16 * SizeConfig.widthMultiplier!,
                right: 18 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 62 * SizeConfig.heightMultiplier!,
                width: 327 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(
                    4 * SizeConfig.widthMultiplier!,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15 * SizeConfig.heightMultiplier!,
                        left: 10 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 95 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 24,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 20 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 110 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                          CustomSizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 30 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(
                                    37 * SizeConfig.widthMultiplier!)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomSizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16 * SizeConfig.widthMultiplier!,
                right: 18 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 62 * SizeConfig.heightMultiplier!,
                width: 327 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(
                    4 * SizeConfig.widthMultiplier!,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15 * SizeConfig.heightMultiplier!,
                        left: 10 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 95 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 24,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 20 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 110 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                          CustomSizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 30 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(
                                    37 * SizeConfig.widthMultiplier!)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomSizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16 * SizeConfig.widthMultiplier!,
                right: 18 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 62 * SizeConfig.heightMultiplier!,
                width: 327 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(
                    4 * SizeConfig.widthMultiplier!,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15 * SizeConfig.heightMultiplier!,
                        left: 10 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 95 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 24,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 20 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 110 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                          CustomSizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 30 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(
                                    37 * SizeConfig.widthMultiplier!)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomSizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16 * SizeConfig.widthMultiplier!,
                right: 18 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 62 * SizeConfig.heightMultiplier!,
                width: 327 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(
                    4 * SizeConfig.widthMultiplier!,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15 * SizeConfig.heightMultiplier!,
                        left: 10 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 95 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 24,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 20 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 110 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                          CustomSizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 30 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(
                                    37 * SizeConfig.widthMultiplier!)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomSizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16 * SizeConfig.widthMultiplier!,
                right: 18 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 62 * SizeConfig.heightMultiplier!,
                width: 327 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(
                    4 * SizeConfig.widthMultiplier!,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15 * SizeConfig.heightMultiplier!,
                        left: 10 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 95 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 24,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 20 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 110 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                          CustomSizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 30 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(
                                    37 * SizeConfig.widthMultiplier!)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomSizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16 * SizeConfig.widthMultiplier!,
                right: 18 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 62 * SizeConfig.heightMultiplier!,
                width: 327 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(
                    4 * SizeConfig.widthMultiplier!,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15 * SizeConfig.heightMultiplier!,
                        left: 10 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 95 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 24,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 20 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 110 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                          CustomSizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 30 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(
                                    37 * SizeConfig.widthMultiplier!)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomSizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            highlightColor: highlightColor,
            baseColor: baseColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16 * SizeConfig.widthMultiplier!,
                right: 18 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 62 * SizeConfig.heightMultiplier!,
                width: 327 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(
                    4 * SizeConfig.widthMultiplier!,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15 * SizeConfig.heightMultiplier!,
                        left: 10 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 95 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 24,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 20 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(
                                5 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                          ),
                          CustomSizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: 110 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: containerColor,
                            ),
                          ),
                          CustomSizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 30 * SizeConfig.heightMultiplier!,
                            width: 30 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(
                                    37 * SizeConfig.widthMultiplier!)),
                          ),
                        ],
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
