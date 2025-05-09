import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color containerColor = Colors.grey.withOpacity(0.3);
    Color baseColor = Colors.grey.withOpacity(0.25);
    Color highlightColor = Colors.white.withOpacity(0.6);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(
          //     left: SizeConfig.widthMultiplier! * 16,
          //     right: SizeConfig.widthMultiplier! * 16,
          //   ),
          //   child: SizedBox(
          //     height: SizeConfig.heightMultiplier! * 90,
          //     child: ListView.builder(
          //         itemCount: 5,
          //         clipBehavior: Clip.none,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: ((context, index) {
          //           return Shimmer.fromColors(
          //             baseColor: baseColor,
          //             highlightColor: highlightColor,
          //             child: SingleChildScrollView(
          //               physics: const BouncingScrollPhysics(),
          //               scrollDirection: Axis.horizontal,
          //               child: Padding(
          //                 padding: EdgeInsets.only(
          //                     right: 15 * SizeConfig.widthMultiplier!),
          //                 child: Row(
          //                   children: [
          //                     Container(
          //                       height: 60 * SizeConfig.heightMultiplier!,
          //                       width: 60 * SizeConfig.widthMultiplier!,
          //                       decoration: BoxDecoration(
          //                         shape: BoxShape.circle,
          //                         color: containerColor,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           );
          //         })),
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier! * 26,
              right: SizeConfig.widthMultiplier! * 26,
            ),
            child: SizedBox(
              height: SizeConfig.heightMultiplier! * 200,
              //width: SizeConfig.widthMultiplier*100,
              child: ListView.builder(
                  itemCount: 1,
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 17 * SizeConfig.heightMultiplier!),
                          child: Shimmer.fromColors(
                            highlightColor: highlightColor,
                            baseColor: baseColor,
                            child: Container(
                              width: SizeConfig.widthMultiplier! * 349,
                              height: SizeConfig.heightMultiplier! * 158,
                              decoration: BoxDecoration(
                                  color: containerColor,
                                  borderRadius: BorderRadius.circular(
                                      10 * SizeConfig.widthMultiplier!)),
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}

class OfferCardShimmer extends StatelessWidget {
  const OfferCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color containerColor = Colors.grey.withOpacity(0.3);
    Color baseColor = Colors.grey.withOpacity(0.25);
    Color highlightColor = Colors.white.withOpacity(0.6);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier! * 26,
              right: SizeConfig.widthMultiplier! * 26,
            ),
            child: SizedBox(
              height: SizeConfig.heightMultiplier! * 300,
              //width: SizeConfig.widthMultiplier*100,
              child: ListView.builder(
                  itemCount: 1,
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 17 * SizeConfig.heightMultiplier!),
                          child: Shimmer.fromColors(
                            highlightColor: highlightColor,
                            baseColor: baseColor,
                            child: Container(
                              width: SizeConfig.widthMultiplier! * 349,
                              height: SizeConfig.heightMultiplier! * 158,
                              decoration: BoxDecoration(
                                  color: containerColor,
                                  borderRadius: BorderRadius.circular(
                                      10 * SizeConfig.widthMultiplier!)),
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
