import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/user/subscription/cubit/subscription_cubit.dart';

import '../data/subscription.data.dart';
import '../entity/subscription_res.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../shared/local_storage/user_repository.dart';
import '../data/subscription.data.dart';
import '../entity/subscription_res.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late SubscriptionCubit subscriptionCubit;

  int selectedPlanIndex = -1; // Initially, no plan is selected

  SubscriptionRes? subscriptionRes;

  @override
  void initState() {
    subscriptionCubit = BlocProvider.of<SubscriptionCubit>(context);
    subscriptionCubit.getSubscriptionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 0.0 * SizeConfig.heightMultiplier!,
          ),
          child: BlocConsumer<SubscriptionCubit, SubscriptionState>(
            listener: (context, state) {
              if (state is GotSubscriptionSuccessState) {
                subscriptionRes = state.subscriptionRes;
              }
            },
            builder: (context, state) {
              if (state is GotSubscriptionSuccessState) {
                return Column(
                  children: [
                    Row(
                      children: [
                        RideBackButton(),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 45 * SizeConfig.heightMultiplier!,
                            left: 20 * SizeConfig.widthMultiplier!,
                          ),
                          child: Text(
                            'Ride subscription plans',
                            style: AppTextStyle.text16black0000W700,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Choose a plan',
                      style: AppTextStyle.text20black0000W600,
                    ),
                    const Text(
                        'Select a subscription plan to get a ride instantly.'),
                    CustomSizedBox(
                      height: 20,
                    ),
                    Wrap(
                      spacing: 20, // Add spacing between containers
                      children: List.generate(subscriptionRes?.data.length ?? 0,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPlanIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              subscriptionContainer(
                                planTitle:
                                    subscriptionRes?.data[index].subPlan ?? "",
                                planPrice: subscriptionRes?.data[index].price
                                        .toString() ??
                                    "",
                                minimumuRide: subscriptionRes
                                        ?.data[index].totalRides
                                        .toString() ??
                                    "",
                                planRides: subscriptionRes
                                        ?.data[index].totalRides
                                        .toString() ??
                                    "",
                                planSupport: '24*7 Support',
                                index: index,
                              ),
                              CustomSizedBox(
                                height: 20, // Add spacing between containers
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    CustomSizedBox(
                      height: 40,
                    ),
                    BlueButton(
                      title: selectedPlanIndex != -1
                          ? 'Buy Now for ${subscriptionRes?.data[selectedPlanIndex].price}'
                          : 'Buy Now',
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget subscriptionContainer({
    String? planTitle,
    String? planPrice,
    String? planRides,
    String? planSupport,
    String? minimumuRide,
    required int index, // Add index parameter
  }) {
    bool isSelected = selectedPlanIndex == index;

    return Container(
      height: 170,
      width: 328,
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Color(0xff5925DC) : Colors.grey),
        borderRadius: BorderRadius.circular(4),
        color: isSelected
            ? Colors.grey[200]
            : Colors.transparent, // Change color to red if selected
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            planTitle ?? "",
            style: AppTextStyle.text18black0000W600,
          ),
          CustomSizedBox(
            height: 10,
          ),
          Row(
            children: [
              SvgPicture.asset(ImagePath.rupeeIcon),
              CustomSizedBox(
                width: 6,
              ),
              Text(
                planPrice ?? "",
                style: AppTextStyle.text16kBlue3D6DFEW600,
              ),
              Text(
                ' /',
                style: AppTextStyle.text16black0000W400,
              ),
              Text(
                minimumuRide ?? "",
                style: AppTextStyle.text16black0000W400,
              ),
              Text(
                ' total rides',
                style: AppTextStyle.text16black0000W400,
              ),
            ],
          ),
          CustomSizedBox(
            height: 10,
          ),
          Text(
            planRides ?? "",
            style: AppTextStyle.text14black0000W400,
          ),
          CustomSizedBox(
            height: 10,
          ),
          Text(
            planSupport ?? "",
            style: AppTextStyle.text14black0000W400,
          ),
          CustomSizedBox(
            height: 10,
          ),
          Text(
            minimumuRide ?? '',
            style: AppTextStyle.text14black0000W400,
          ),
        ]),
      ),
    );
  }
}
