import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';

import 'domain/help_cubit.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  late final HelpCubit controller;

  @override
  void initState() {
    controller = context.read();
    controller.getHelpData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HelpCubit, HelpState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RideBackButton(),
                  CustomSizedBox(
                    width: 50,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 45 * SizeConfig.heightMultiplier!),
                    child: Text(
                      'Help',
                      style: AppTextStyle.text18black0000W600,
                    ),
                  ),
                ],
              ),
              CustomSizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  await controller.openWhatsapp(
                      phoneNumber: state.getUserHelpData.data?.whtsapp ?? "");
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20 * SizeConfig.widthMultiplier!),
                  child: Row(
                    children: [
                      ImageLoader.svgPictureAssetImage(
                          imagePath: ImagePath.watsaapIcon),
                      CustomSizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(
                            "Chat with help team",
                            style: AppTextStyle.text14Black0000W400,
                          ),
                          Container(
                            width: 130 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  50 * SizeConfig.widthMultiplier!),
                              color: AppColors.kRedF24141,
                              border: Border.all(
                                  color: AppColors.kBlackTextColor,
                                  width: 0.4 * SizeConfig.widthMultiplier!),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CustomSizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  try {
                    Utils.launchPhoneDialer(
                        state.getUserHelpData.data?.phone ?? '');
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20 * SizeConfig.widthMultiplier!),
                  child: Row(
                    children: [
                      ImageLoader.svgPictureAssetImage(
                          imagePath: ImagePath.callBIcon),
                      CustomSizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            "Call with our help team",
                            style: AppTextStyle.text14Black0000W400,
                          ),
                          Container(
                            width: 145 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  50 * SizeConfig.widthMultiplier!),
                              color: AppColors.kRedF24141,
                              border: Border.all(
                                  color: AppColors.kBlackTextColor,
                                  width: 0.4 * SizeConfig.widthMultiplier!),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
