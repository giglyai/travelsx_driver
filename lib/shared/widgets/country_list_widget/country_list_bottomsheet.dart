import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travelx_driver/login/bloc/login_cubit.dart';
import 'package:travelx_driver/login/bloc/login_state.dart';
import 'package:travelx_driver/login/entity/country_list/country_list.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';

class CountryListBottomSheet {
  Color containerColor = Colors.grey.withOpacity(0.5);
  Color baseColor = Colors.grey.withOpacity(0.5);
  Color highlightColor = Colors.white.withOpacity(0.6);
  RxBool isSignupButtonEnabled = false.obs;

  ServiceLoginCubit? signUpCubit;
  String firstCountryFlag = '';
  String firstCountryCode = '';

  CountryCodeList? countries;

  CountryListBottomSheet._();

  static final CountryListBottomSheet _singleton = CountryListBottomSheet._();
  factory CountryListBottomSheet() {
    _singleton.init();
    return _singleton;
  }

  void init() async {
    signUpCubit = BlocProvider.of<ServiceLoginCubit>(Get.context!);
    countries = await signUpCubit?.getCountryCode();
    firstCountryFlag = countries?.data?.firstOrNull?.flagUrl ?? '';
    firstCountryCode = countries?.data?.firstOrNull?.countryCode ?? '';
  }

  countryBottomSheet({
    required BuildContext context,
    required Function(
      String country,
      String countryId,
      String? countryCode,
      String? countryFlag,
    )
    onTap,
  }) {
    final ScrollController _firstController = ScrollController();

    String countryQuery = "";

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.black.withOpacity(0.7),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (
            BuildContext context,
            void Function(void Function()) setState,
          ) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kWhite.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15 * SizeConfig.widthMultiplier!),
                    topRight: Radius.circular(15 * SizeConfig.widthMultiplier!),
                  ),
                ),
                height: 380 * SizeConfig.heightMultiplier!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20 * SizeConfig.heightMultiplier!,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 27 * SizeConfig.widthMultiplier!,
                            ),
                            child: Text(
                              "Select Country Code".tr,
                              style: AppTextStyle.text22black0000W600,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 26 * SizeConfig.widthMultiplier!,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(
                                  8 * SizeConfig.widthMultiplier!,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.kWhiteE5E5E5,
                                  borderRadius: BorderRadius.circular(37),
                                ),
                                child: ImageLoader.svgPictureAssetImage(
                                  imagePath: ImagePath.closeIcon,
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15 * SizeConfig.widthMultiplier!,
                        right: 16 * SizeConfig.widthMultiplier!,
                      ),
                      child: CustomTextFromField(
                        prefixIcon: SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          setState(() {
                            countryQuery = value.toLowerCase();
                          });
                        },
                        hintText: "Type country name".tr,
                      ),
                    ),
                    CustomSizedBox(height: 15),
                    BlocBuilder<ServiceLoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is CountryCodeLoading) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: baseColor,
                                  highlightColor: highlightColor,
                                  enabled: true,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height:
                                            10 * SizeConfig.heightMultiplier!,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left:
                                              35 * SizeConfig.widthMultiplier!,
                                        ),
                                        child: Container(
                                          height:
                                              35 * SizeConfig.heightMultiplier!,
                                          width:
                                              300 * SizeConfig.widthMultiplier!,
                                          color: containerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }

                        if (state is GotCountryCode) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 14 * SizeConfig.widthMultiplier!,
                              ),
                              child: RawScrollbar(
                                trackColor: AppColors.kBlue3D6.withOpacity(0.5),
                                thumbColor: AppColors.kBlue3D6,
                                radius: Radius.circular(
                                  50 * SizeConfig.widthMultiplier!,
                                ),
                                trackRadius: Radius.circular(
                                  50 * SizeConfig.widthMultiplier!,
                                ),
                                thumbVisibility: true,
                                controller: _firstController,
                                trackVisibility: true,
                                thickness: 4 * SizeConfig.widthMultiplier!,
                                child: ListView.builder(
                                  controller: _firstController,
                                  scrollDirection: Axis.vertical,
                                  itemCount: countries?.data?.length ?? 0,
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    return (countryQuery.isEmpty ||
                                                (countries?.data?[index].name
                                                        ?.toLowerCase()
                                                        .contains(
                                                          countryQuery,
                                                        ) ??
                                                    false)) ||
                                            (countryQuery.isEmpty ||
                                                (countries
                                                        ?.data?[index]
                                                        .countryCode
                                                        ?.toLowerCase()
                                                        .contains(
                                                          countryQuery,
                                                        ) ??
                                                    false))
                                        ? InkWell(
                                          onTap: () {
                                            onTap.call(
                                              countries?.data?[index].name ??
                                                  "",
                                              countries?.data?[index].id ?? "",
                                              countries
                                                      ?.data?[index]
                                                      .countryCode ??
                                                  '',
                                              countries?.data?[index].flagUrl ??
                                                  '',
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left:
                                                  15 *
                                                  SizeConfig.widthMultiplier!,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    if (countries
                                                            ?.data?[index]
                                                            .flagUrl
                                                            ?.isNotEmpty ==
                                                        true)
                                                      ImageLoader.svgPictureNetworkAssetImage(
                                                        imagePath:
                                                            countries
                                                                ?.data?[index]
                                                                .flagUrl,
                                                        width:
                                                            40 *
                                                            SizeConfig
                                                                .widthMultiplier!,
                                                        height:
                                                            40 *
                                                            SizeConfig
                                                                .heightMultiplier!,
                                                      ),
                                                    CustomSizedBox(width: 10),
                                                    Expanded(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            countries
                                                                        ?.data?[index]
                                                                        .countryCode !=
                                                                    null
                                                                ? ('(+${countries?.data?[index].countryCode ?? ''})')
                                                                : "",
                                                            style:
                                                                AppTextStyle
                                                                    .text14Black0000W400,
                                                          ),
                                                          CustomSizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            countries
                                                                    ?.data?[index]
                                                                    .name ??
                                                                "",
                                                            style:
                                                                AppTextStyle
                                                                    .text18black0000W500,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                CustomSizedBox(height: 5),
                                                Divider(
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.3),
                                                  thickness:
                                                      1.5 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        : Container();
                                  },
                                ),
                              ),
                            ),
                          );
                        }

                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
