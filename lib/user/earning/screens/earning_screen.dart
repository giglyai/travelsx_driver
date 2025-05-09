import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/utils/utilities.dart';
import '../../../shared/widgets/container_with_border/container_with_border.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/empty_data_screens/earnings_empty.dart';
import '../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../../promotions/widgets/usable_row.dart';
import '../bloc/earning_cubit.dart';

class Earnings extends StatefulWidget {
  const Earnings({Key? key}) : super(key: key);

  @override
  State<Earnings> createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  late EarningCubit _earningCubit;

  bool hideBreakDown = true;
  bool activityArrow = true;
  int? selectedIndex;
  String? selectName;
  // List<Metric> metrics = [];

  @override
  void initState() {
    _earningCubit = BlocProvider.of<EarningCubit>(context);
    _earningCubit.getEarningData(dateFilter: "Today");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RideBackButton(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Center(
                child: Text(
                  "earning_activity".tr,
                  style: TextStyle(
                      color: AppColors.kBlackTextColor.withOpacity(0.70),
                      fontSize: 20 * SizeConfig.widthMultiplier!,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 30 * SizeConfig.heightMultiplier!,
              ),
              Center(
                child: SizedBox(
                  width: 190 * SizeConfig.widthMultiplier!,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors
                            .kWhite, //background color of dropdown button
                        border: Border.all(
                            color: AppColors.kBlackTextColor,
                            width: 2 *
                                SizeConfig
                                    .widthMultiplier!), //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            40 * SizeConfig.widthMultiplier!),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        value: selectName,
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              EarningActivity.today.getEarningActivityString,
                              style: TextStyle(
                                  color: AppColors.kBlackTextColor
                                      .withOpacity(0.70),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16 * SizeConfig.textMultiplier!),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20 * SizeConfig.imageSizeMultiplier!,
                            ),
                          ],
                        ),

                        items: [
                          DropdownMenuItem(
                            value:
                                EarningActivity.today.getEarningActivityString,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    EarningActivity
                                        .today.getEarningActivityString,
                                    style: TextStyle(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.70),
                                        fontSize:
                                            16 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20 * SizeConfig.imageSizeMultiplier!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: EarningActivity
                                .yesterday.getEarningActivityString,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    EarningActivity
                                        .yesterday.getEarningActivityString,
                                    style: TextStyle(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.70),
                                        fontSize:
                                            16 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20 * SizeConfig.imageSizeMultiplier!,
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: EarningActivity
                                .lastweek.getEarningActivityString,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    EarningActivity
                                        .lastweek.getEarningActivityString,
                                    style: TextStyle(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.70),
                                        fontSize:
                                            16 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20 * SizeConfig.imageSizeMultiplier!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: EarningActivity
                                .thisWeek.getEarningActivityString,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    EarningActivity
                                        .thisWeek.getEarningActivityString,
                                    style: TextStyle(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.70),
                                        fontSize:
                                            16 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20 * SizeConfig.imageSizeMultiplier!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: EarningActivity
                                .lastmonth.getEarningActivityString,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    EarningActivity
                                        .lastmonth.getEarningActivityString,
                                    style: TextStyle(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.70),
                                        fontSize:
                                            16 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20 * SizeConfig.imageSizeMultiplier!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: EarningActivity
                                .thisMonth.getEarningActivityString,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    EarningActivity
                                        .thisMonth.getEarningActivityString,
                                    style: TextStyle(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.70),
                                        fontSize:
                                            16 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20 * SizeConfig.imageSizeMultiplier!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) async {
                          //get value when changed
                          setState(() {
                            selectName = value;
                          });

                          if (selectName ==
                              EarningActivity.today.getEarningActivityString) {
                            await _earningCubit.getEarningData(
                                dateFilter: selectName);
                          } else {
                            await _earningCubit.getFilterData(
                                dateFilter: selectName);
                          }
                        },

                        iconEnabledColor: AppColors.kWhite, //Icon color
                        style: TextStyle(
                            color: AppColors.kBlackTextColor.withOpacity(0.70),
                            fontWeight: FontWeight.w700,
                            fontSize: 16 * SizeConfig.textMultiplier!),

                        dropdownColor:
                            AppColors.kWhite, //dropdown background color
                        underline: Container(), //remove underline
                      )),
                ),
              ),
              SizedBox(
                height: 15 * SizeConfig.heightMultiplier!,
              ),
              BlocConsumer<EarningCubit, EarningState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GotEarningSuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "total_earnings".tr,
                            style: TextStyle(
                                color:
                                    AppColors.kBlackTextColor.withOpacity(0.60),
                                fontWeight: FontWeight.w500,
                                fontSize: 16 * SizeConfig.textMultiplier!),
                          ),
                        ),
                        SizedBox(
                          height: 7 * SizeConfig.heightMultiplier!,
                        ),
                        Center(
                          child: Text(
                            "${state.earningModel.data.metrics.breakdown.currency}"
                            "${state.earningModel.data.metrics.breakdown.totalAmount}",
                            style: TextStyle(
                                color: AppColors.kBlackTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 30 * SizeConfig.textMultiplier!),
                          ),
                        ),
                        SizedBox(
                          height: 20 * SizeConfig.heightMultiplier!,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 31 * SizeConfig.widthMultiplier!,
                            right: 33 * SizeConfig.widthMultiplier!,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "breakdown".tr,
                                style: TextStyle(
                                    color: AppColors.kBlackTextColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20 * SizeConfig.textMultiplier!),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hideBreakDown = !hideBreakDown;
                                  });
                                },
                                child: hideBreakDown == false
                                    ? Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 30 *
                                            SizeConfig.imageSizeMultiplier!,
                                      )
                                    : Icon(
                                        Icons.keyboard_arrow_up,
                                        size: 30 *
                                            SizeConfig.imageSizeMultiplier!,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        if (hideBreakDown == true)
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 31 * SizeConfig.widthMultiplier!,
                                  right: 33 * SizeConfig.widthMultiplier!,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20 * SizeConfig.heightMultiplier!,
                                    ),
                                    UsableRow(
                                      title: "total_trips".tr,
                                      subTitle: state.earningModel.data.metrics
                                          .breakdown.totalTrips
                                          .toString(),
                                    ),
                                    UsableRow(
                                      title: "total_distance".tr,
                                      subTitle: state.earningModel.data.metrics
                                          .breakdown.totalDistance
                                          .toString(),
                                    ),
                                    UsableRow(
                                      title: "total_time".tr,
                                      subTitle: state.earningModel.data.metrics
                                          .breakdown.totalTime
                                          .toString(),
                                    ),
                                    Divider(
                                      color: AppColors.kBlackTextColor
                                          .withOpacity(0.40),
                                      thickness:
                                          1 * SizeConfig.widthMultiplier!,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (hideBreakDown == false)
                          SizedBox(
                            height: 20 * SizeConfig.heightMultiplier!,
                          ),
                        if (hideBreakDown == false)
                          Divider(
                            indent: 31 * SizeConfig.widthMultiplier!,
                            endIndent: 29 * SizeConfig.widthMultiplier!,
                            color: AppColors.kBlackTextColor.withOpacity(0.4),
                            thickness: 0.4 * SizeConfig.widthMultiplier!,
                          ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!,
                            right: 20 * SizeConfig.widthMultiplier!,
                          ),
                          child: Wrap(
                              children: List.generate(
                            state.earningModel.data.activities.length,
                            (activityIndex) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 12 * SizeConfig.widthMultiplier!,
                                ),
                                ...List.generate(
                                    state.earningModel.data
                                        .activities[activityIndex].length,
                                    (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8 *
                                                        SizeConfig
                                                            .widthMultiplier!),
                                                color: AppColors.kWhitef7f7f7,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10 *
                                                        SizeConfig
                                                            .heightMultiplier!,
                                                    bottom: 10 *
                                                        SizeConfig
                                                            .heightMultiplier!,
                                                    left: 10 *
                                                        SizeConfig
                                                            .heightMultiplier!),
                                                child: Text(
                                                  state
                                                      .earningModel
                                                      .data
                                                      .activities[activityIndex]
                                                          [index]
                                                      .createdTime,
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .kBlackTextColor
                                                          .withOpacity(0.80),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14 *
                                                          SizeConfig
                                                              .textMultiplier!),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = index;
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: 10 *
                                                      SizeConfig
                                                          .heightMultiplier!,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    selectedIndex == index
                                                        ? Icon(
                                                            Icons
                                                                .keyboard_arrow_up,
                                                            size: 25 *
                                                                SizeConfig
                                                                    .imageSizeMultiplier!,
                                                            color: AppColors
                                                                .kBlackTextColor,
                                                            weight: 50,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .keyboard_arrow_down_rounded,
                                                            size: 25 *
                                                                SizeConfig
                                                                    .imageSizeMultiplier!,
                                                            color: AppColors
                                                                .kBlackTextColor,
                                                            weight: 50,
                                                          ),
                                                    CustomSizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                         Text(
                                                            "payment_received_for_completed_trip".tr),
                                                        CustomSizedBox(
                                                          height: 12,
                                                        ),
                                                        ContainerWithBorder(
                                                          wantPadding: true,
                                                          borderColor: AppColors
                                                              .kWhiteF8F8F8,
                                                          containerColor:
                                                              AppColors
                                                                  .kWhiteF8F8F8,
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      "${state.earningModel.data.activities[activityIndex][index].currency}${state.earningModel.data.activities[activityIndex][index].fee}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16 *
                                                              SizeConfig
                                                                  .textMultiplier!,
                                                          color: AppColors
                                                              .kBlackTextColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            CustomSizedBox(
                                              height: 5 *
                                                  SizeConfig.heightMultiplier!,
                                            ),
                                            if (selectedIndex == index)
                                              SizedBox(
                                                height: 10 *
                                                    SizeConfig
                                                        .heightMultiplier!,
                                              ),
                                            if (selectedIndex == index)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 22 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    right: 6 *
                                                        SizeConfig
                                                            .widthMultiplier!),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedIndex = -1;
                                                    });
                                                  },
                                                  child: ContainerWithBorder(
                                                    borderColor:
                                                        AppColors.kWhite,
                                                    borderRadius: 6 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      ImagePath
                                                                          .greenRadioIcon),
                                                                  SizedBox(
                                                                    height: 2 *
                                                                        SizeConfig
                                                                            .heightMultiplier!,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 2 *
                                                                            SizeConfig.widthMultiplier!),
                                                                    child: SizedBox(
                                                                        height: 30 * SizeConfig.heightMultiplier!,
                                                                        child: VerticalDivider(
                                                                          thickness:
                                                                              1 * SizeConfig.widthMultiplier!,
                                                                          color: AppColors
                                                                              .kBlackTextColor
                                                                              .withOpacity(0.30),
                                                                        )),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2 *
                                                                        SizeConfig
                                                                            .heightMultiplier!,
                                                                  ),
                                                                  SvgPicture.asset(
                                                                      ImagePath
                                                                          .greenRadioIcon),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 7 *
                                                                  SizeConfig
                                                                      .widthMultiplier!,
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    right: 25 *
                                                                        SizeConfig
                                                                            .widthMultiplier!),
                                                                child: SizedBox(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        state
                                                                            .earningModel
                                                                            .data
                                                                            .activities[activityIndex][index]
                                                                            .pickupAddress,
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.kBlackTextColor.withOpacity(0.70),
                                                                            fontSize: 12 * SizeConfig.textMultiplier!,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      SizedBox(
                                                                        height: 24 *
                                                                            SizeConfig.heightMultiplier!,
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .earningModel
                                                                            .data
                                                                            .activities[activityIndex][index]
                                                                            .dropoffAddress,
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.kBlackTextColor.withOpacity(0.70),
                                                                            fontSize: 12 * SizeConfig.textMultiplier!,
                                                                            fontWeight: FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Icon(Icons
                                                            .arrow_drop_up_rounded),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10 *
                                                      SizeConfig
                                                          .heightMultiplier!),
                                              child: Divider(
                                                color: AppColors.kBlackTextColor
                                                    .withOpacity(0.40),
                                                thickness: 1 *
                                                    SizeConfig.widthMultiplier!,
                                              ),
                                            ),
                                          ],
                                        ))
                              ],
                            ),
                          )),
                        ),
                      ],
                    );
                  }
                  if (state is GotFilterEarningSuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "total_earnings".tr,
                            style: TextStyle(
                                color:
                                    AppColors.kBlackTextColor.withOpacity(0.60),
                                fontWeight: FontWeight.w500,
                                fontSize: 16 * SizeConfig.textMultiplier!),
                          ),
                        ),
                        SizedBox(
                          height: 7 * SizeConfig.heightMultiplier!,
                        ),
                        Center(
                          child: Text(
                            "${state.earningFilterModel.data.metrics.breakdown.currency}"
                            "${state.earningFilterModel.data.metrics.breakdown.totalAmount}",
                            style: TextStyle(
                                color: AppColors.kBlackTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 30 * SizeConfig.textMultiplier!),
                          ),
                        ),
                        SizedBox(
                          height: 20 * SizeConfig.heightMultiplier!,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!,
                            right: 20 * SizeConfig.widthMultiplier!,
                          ),
                          child: Wrap(
                              children: List.generate(
                            state.earningFilterModel.data.activities.length,
                            (activityIndex) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "breakdown".tr,
                                      style: TextStyle(
                                          color: AppColors.kBlackTextColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              20 * SizeConfig.textMultiplier!),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          hideBreakDown = !hideBreakDown;
                                        });
                                      },
                                      child: hideBreakDown == false
                                          ? Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 30 *
                                                  SizeConfig
                                                      .imageSizeMultiplier!,
                                            )
                                          : Icon(
                                              Icons.keyboard_arrow_up,
                                              size: 30 *
                                                  SizeConfig
                                                      .imageSizeMultiplier!,
                                            ),
                                    ),
                                  ],
                                ),
                                if (hideBreakDown == true)
                                  Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20 *
                                                SizeConfig.heightMultiplier!,
                                          ),
                                          UsableRow(
                                            title: "total_trips".tr,
                                            subTitle: state
                                                .earningFilterModel
                                                .data
                                                .metrics
                                                .breakdown
                                                .totalTrips
                                                .toString(),
                                          ),
                                          UsableRow(
                                            title: "total_distance".tr,
                                            subTitle: state
                                                .earningFilterModel
                                                .data
                                                .metrics
                                                .breakdown
                                                .totalDistance
                                                .toString(),
                                          ),
                                          UsableRow(
                                            title: "total_time".tr,
                                            subTitle: state
                                                .earningFilterModel
                                                .data
                                                .metrics
                                                .breakdown
                                                .totalTime
                                                .toString(),
                                          ),
                                          Divider(
                                            color: AppColors.kBlackTextColor
                                                .withOpacity(0.40),
                                            thickness:
                                                1 * SizeConfig.widthMultiplier!,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                if (hideBreakDown == true)
                                  SizedBox(
                                    height: 16 * SizeConfig.widthMultiplier!,
                                  ),
                                ...List.generate(
                                    state.earningFilterModel.data
                                        .activities[activityIndex].length,
                                    (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = index;
                                                });
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  selectedIndex == index
                                                      ? Icon(
                                                          Icons
                                                              .keyboard_arrow_up,
                                                          size: 25 *
                                                              SizeConfig
                                                                  .imageSizeMultiplier!,
                                                          color: AppColors
                                                              .kBlackTextColor,
                                                          weight: 50,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          size: 25 *
                                                              SizeConfig
                                                                  .imageSizeMultiplier!,
                                                          color: AppColors
                                                              .kBlackTextColor,
                                                          weight: 50,
                                                        ),
                                                  CustomSizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color:
                                                              Colors.grey[200],
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            state
                                                                .earningFilterModel
                                                                .data
                                                                .activities[
                                                                    activityIndex]
                                                                    [index]
                                                                .createdTime,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14 *
                                                                    SizeConfig
                                                                        .textMultiplier!,
                                                                color: AppColors
                                                                    .kBlackTextColor
                                                                    .withOpacity(
                                                                        0.70)),
                                                          ),
                                                        ),
                                                      ),
                                                      CustomSizedBox(
                                                        height: 5,
                                                      ),
                                                       Text(
                                                          "payment_received_for_completed_trip".tr),
                                                      CustomSizedBox(
                                                        height: 12,
                                                      ),
                                                      ContainerWithBorder(
                                                        wantPadding: true,
                                                        borderColor: AppColors
                                                            .kWhiteF8F8F8,
                                                        containerColor:
                                                            AppColors
                                                                .kWhiteF8F8F8,
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "${state.earningFilterModel.data.activities[activityIndex][index].currency}${state.earningFilterModel.data.activities[activityIndex][index].fee}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16 *
                                                            SizeConfig
                                                                .textMultiplier!,
                                                        color: AppColors
                                                            .kBlackTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            CustomSizedBox(height: 12),
                                            if (selectedIndex == index)
                                              SizedBox(
                                                height: 10 *
                                                    SizeConfig
                                                        .heightMultiplier!,
                                              ),
                                            if (selectedIndex == index)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 22 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    right: 6 *
                                                        SizeConfig
                                                            .widthMultiplier!),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedIndex = -1;
                                                    });
                                                  },
                                                  child: ContainerWithBorder(
                                                    borderColor:
                                                        AppColors.kWhite,
                                                    borderRadius: 6 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      ImagePath
                                                                          .greenRadioIcon),
                                                                  SizedBox(
                                                                    height: 2 *
                                                                        SizeConfig
                                                                            .heightMultiplier!,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 2 *
                                                                            SizeConfig.widthMultiplier!),
                                                                    child: SizedBox(
                                                                        height: 30 * SizeConfig.heightMultiplier!,
                                                                        child: VerticalDivider(
                                                                          thickness:
                                                                              1 * SizeConfig.widthMultiplier!,
                                                                          color: AppColors
                                                                              .kBlackTextColor
                                                                              .withOpacity(0.30),
                                                                        )),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2 *
                                                                        SizeConfig
                                                                            .heightMultiplier!,
                                                                  ),
                                                                  SvgPicture.asset(
                                                                      ImagePath
                                                                          .greenRadioIcon),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 7 *
                                                                  SizeConfig
                                                                      .widthMultiplier!,
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    right: 25 *
                                                                        SizeConfig
                                                                            .widthMultiplier!),
                                                                child: SizedBox(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        state
                                                                            .earningFilterModel
                                                                            .data
                                                                            .activities[activityIndex][index]
                                                                            .pickupAddress,
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.kBlackTextColor.withOpacity(0.70),
                                                                            fontSize: 12 * SizeConfig.textMultiplier!,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      SizedBox(
                                                                        height: 24 *
                                                                            SizeConfig.heightMultiplier!,
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .earningFilterModel
                                                                            .data
                                                                            .activities[activityIndex][index]
                                                                            .dropoffAddress,
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.kBlackTextColor.withOpacity(0.70),
                                                                            fontSize: 12 * SizeConfig.textMultiplier!,
                                                                            fontWeight: FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Icon(Icons
                                                            .arrow_drop_up_rounded),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10 *
                                                      SizeConfig
                                                          .heightMultiplier!),
                                              child: Divider(
                                                color: AppColors.kBlackTextColor
                                                    .withOpacity(0.40),
                                                thickness: 1 *
                                                    SizeConfig.widthMultiplier!,
                                              ),
                                            ),
                                          ],
                                        ))
                              ],
                            ),
                          )),
                        ),
                        SizedBox(
                          height: 20 * SizeConfig.widthMultiplier!,
                        ),
                      ],
                    );
                  }

                  if (state is EarningEmptyState) {
                    return Center(
                      child: EmptyEarnings(
                        message: state.emptyMessage,
                      ),
                    );
                  }

                  if (state is EarningLoadingState) {
                    return Center(
                      child: Lottie.asset(ImagePath.loadingAnimation,
                          height: 50 * SizeConfig.heightMultiplier!,
                          width: 300 * SizeConfig.widthMultiplier!),
                    );
                  }

                  return Center(child: Text("no_data_available".tr));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
