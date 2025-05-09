import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/driver/widgets/trip_tab.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:intl/intl.dart' as intl;
import 'package:regex_range/regex_range.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/constants/app_styles/app_styles.dart';
import '../../shared/constants/imagePath/image_paths.dart';
import '../../shared/local_storage/user_repository.dart';
import '../../shared/widgets/buttons/blue_button.dart';
import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/custom_toast/custom_toast.dart';
import '../../shared/widgets/size_config/size_config.dart';
import '../../shared/widgets/text_form_field/custom_textform_field.dart';

class DriverRateDraggableRateSet extends StatefulWidget {
  const DriverRateDraggableRateSet({Key? key}) : super(key: key);

  @override
  State<DriverRateDraggableRateSet> createState() =>
      _DriverRateDraggableRateSetState();

  static GlobalKey<_DriverRateDraggableRateSetState> createKey() =>
      GlobalKey<_DriverRateDraggableRateSetState>();
}

class _DriverRateDraggableRateSetState
    extends State<DriverRateDraggableRateSet> {
  // String? selectedBaseDistanceValue;

  TextEditingController selectedBaseDistanceValue = TextEditingController();
  TextEditingController selectedBaseRateValue = TextEditingController();
  TextEditingController selectedPerMileRateValue = TextEditingController();

  final selectedBaseDistanceValueRegex = numberRange(1, 200, exact: true);
  final selectedBaseRateValueRegex = numberRange(1, 5000, exact: true);
  RegExp selectedPerMileRateValueRegex = numberRange(1, 130, exact: true);

  // String? selectedBaseRateValue;
  // String? selectedPerMileRateValue;

  RideType rideType = RideType.oneWay;
  bool pickupTab = true;
  late HomeCubit _homeCubit;

  intl.NumberFormat? formatNew;

  void currency() {
    // Locale locale = Localizations.localeOf(context);
    //
    // var format = intl.NumberFormat.simpleCurrency(locale: Platform.localeName);
    // print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
    // print("CURRENCY NAME ${format.currencyName}"); // USD

    var format =
        intl.NumberFormat.simpleCurrency(name: UserRepository.getCountry);

    formatNew = format;

    print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
    print("CURRENCY NAME ${format.currencyName}"); //
    setState(() {});
  }

  @override
  void initState() {
    selectedBaseDistanceValue.text = "130";
    selectedBaseRateValue.text = "1990";
    selectedPerMileRateValue.text = "13";
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 540 * SizeConfig.heightMultiplier!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSizedBox(height: 35),
          Padding(
            padding: EdgeInsets.only(
                left: 30 * SizeConfig.widthMultiplier!,
                right: 30 * SizeConfig.widthMultiplier!),
            child: Row(
              children: [
                PickupTab(
                  title: "One way",
                  isSelected: rideType == RideType.oneWay,
                  onTap: () {
                    setState(() {
                      rideType = RideType.oneWay;
                    });
                  },
                ),
                PickupTab(
                  title: "Round Trip",
                  isSelected: rideType == RideType.roundTrip,
                  onTap: () {
                    setState(() {
                      rideType = RideType.roundTrip;
                    });
                  },
                ),
              ],
            ),
          ),
          CustomSizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              currency();
            },
            child: Center(
              child: Text("update your ride rates here",
                  style: TextStyle(
                      fontSize: 16 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w700,
                      color: AppColors.kBlackTextColor.withOpacity(0.48))),
            ),
          ),
          CustomSizedBox(
            height: 23,
          ),
          Container(
            padding: EdgeInsets.only(
                top: 15 * SizeConfig.heightMultiplier!,
                left: 17 * SizeConfig.widthMultiplier!,
                bottom: 15 * SizeConfig.heightMultiplier!),
            width: 330,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(12 * SizeConfig.widthMultiplier!),
                border: Border.all(
                  color: AppColors.kBlackTextColor.withOpacity(0.32),
                )),
            child: Row(
              children: [
                Text(
                  "Base Distance",
                  style: AppTextStyle.text14kBlack3C3C3CW400,
                ),
                const Spacer(),
                SizedBox(
                  width: 100 * SizeConfig.widthMultiplier!,
                  height: 50 * SizeConfig.heightMultiplier!,
                  child: CustomTextFromField(
                    keyboardType: TextInputType.number,
                    customInputFormatters: [
                      FilteringTextInputFormatter.allow(
                          selectedBaseDistanceValueRegex)
                    ],
                    controller: selectedBaseDistanceValue,
                    hintText: "130",
                  ),
                ),
                CustomSizedBox(
                  width: 10,
                ),
                Text(
                  "KM",
                  style: AppTextStyle.text14kBlack3C3C3CW700.copyWith(
                    color: AppColors.kBlack3C3C3C.withOpacity(0.50),
                  ),
                ),
                CustomSizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          CustomSizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(
                top: 15 * SizeConfig.heightMultiplier!,
                left: 17 * SizeConfig.widthMultiplier!,
                bottom: 15 * SizeConfig.heightMultiplier!),
            width: 330,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(12 * SizeConfig.widthMultiplier!),
              border: Border.all(
                color: AppColors.kBlackTextColor.withOpacity(0.32),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Base rate",
                  style: AppTextStyle.text14kBlack3C3C3CW400,
                ),
                Spacer(),
                SizedBox(
                    width: 100 * SizeConfig.widthMultiplier!,
                    height: 50 * SizeConfig.heightMultiplier!,
                    child: CustomTextFromField(
                      keyboardType: TextInputType.number,
                      customInputFormatters: [
                        FilteringTextInputFormatter.allow(
                            selectedBaseRateValueRegex)
                      ],
                      controller: selectedBaseRateValue,
                      hintText: "1990",
                    )),
                CustomSizedBox(
                  width: 10,
                ),
                Text(
                  UserRepository.getCountry ?? "",
                  style: AppTextStyle.text14kBlack3C3C3CW700.copyWith(
                      color: AppColors.kBlack3C3C3C.withOpacity(0.50)),
                ),
                CustomSizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          CustomSizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(
                top: 15 * SizeConfig.heightMultiplier!,
                left: 17 * SizeConfig.widthMultiplier!,
                bottom: 15 * SizeConfig.heightMultiplier!),
            width: 330,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(12 * SizeConfig.widthMultiplier!),
              border: Border.all(
                color: AppColors.kBlackTextColor.withOpacity(0.32),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Per KM Rate",
                  style: AppTextStyle.text14kBlack3C3C3CW400,
                ),
                Spacer(),
                SizedBox(
                    width: 100 * SizeConfig.widthMultiplier!,
                    height: 50 * SizeConfig.heightMultiplier!,
                    child: CustomTextFromField(
                      keyboardType: TextInputType.number,
                      customInputFormatters: [
                        FilteringTextInputFormatter.allow(
                            selectedPerMileRateValueRegex)
                      ],
                      controller: selectedPerMileRateValue,
                      hintText: "130",
                    )),
                CustomSizedBox(
                  width: 10,
                ),
                Text(
                  UserRepository.getCountry ?? "",
                  style: AppTextStyle.text14kBlack3C3C3CW700.copyWith(
                      color: AppColors.kBlack3C3C3C.withOpacity(0.50)),
                ),
                CustomSizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          CustomSizedBox(
            height: 20,
          ),
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is DriverBlocSuccess) {
                CustomToastUtils.showToast(
                    title: state.message ?? '',
                    context: context,
                    imagePath: ImagePath.successIcon,
                    toastColor: AppColors.kGreen47D7);
                AnywhereDoor.pop(context);
              }
            },
            builder: (context, state) {
              return BlueButton(
                isLoading: state is DriverBlocLoading,
                onTap: () async {
                  await _homeCubit.updateDriverRate(
                      rideType: rideType,
                      baseDistance: selectedBaseDistanceValue.text,
                      baseRate: selectedBaseRateValue.text,
                      perUnitRate: selectedPerMileRateValue.text);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
