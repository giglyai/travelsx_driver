import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/google_map/google-map.widget.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
import 'package:travelx_driver/user/account/bloc/account_cubit.dart';
import 'package:travelx_driver/user/location/model/location_model.dart'
    as loc;
import 'package:travelx_driver/user/location/model/place_lat_lng.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../shared/utils/utilities.dart';
import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/app_styles/app_styles.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/custom_toast/custom_toast.dart';
import '../../../shared/widgets/text_form_field/custom_textform_field.dart';
import '../../../user/account/screen/vehicle/driver_onboarding_screen.dart';
import '../../../user/location/service/location_service.dart';

class NewDriverScreen extends StatefulWidget {
  const NewDriverScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NewDriverScreen> createState() => _NewDriverScreenState();
}

class _NewDriverScreenState extends State<NewDriverScreen> {
  late AccountCubit accountCubit;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? currentBackPressTime; //// scaffoldKey to open drawer

  FocusNode addressfocusNode = FocusNode();
  FocusNode focusNode = FocusNode();
  FocusNode licensefocusNode = FocusNode();
  DraggableScrollableController controller = DraggableScrollableController();
  TextEditingController username = TextEditingController();
  TextEditingController liceNumber = TextEditingController();

  bool wantAddressField = false;
  Position? _currentPosition;
  String? _currentAddress;

  TextEditingController completeAddressController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController placeShortName = TextEditingController();
  TextEditingController streetController = TextEditingController();

  Future<Position>? _positionFuture;
  Future<void> _getCurrentLocation() async {
    try {
      await Future.delayed(const Duration(seconds: 1), () async {
        _currentPosition = await getLocation();
      });
      print("hhhhhhhhh ${_currentPosition.toString()}");
      _currentAddress = await _getAddressFromLatLng(_currentPosition!);
    } catch (e) {
      print("eeeeeeeeeeee$e");
    }
  }

  Future<Position> getLocation() async {
    if (_positionFuture != null) {
      // If a future is already in progress, return it directly
      return _positionFuture!;
    } else {
      // If no future is in progress, start a new one
      Completer<Position> completer = Completer<Position>();
      _positionFuture = completer.future;

      // Fetch the current position
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        );
        // Complete the future with the fetched position
        completer.complete(position);
      } catch (e) {
        // Handle any errors and complete the future with an error
        completer.completeError(e);
      }
      // Wait for the future to complete and then return its result
      return await _positionFuture!;
    }
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    print("jhfdsjkbfjkdsbfjk ${position.toString()}");

    List<Placemark>? placemarks = await GeocodingPlatform.instance
        ?.placemarkFromCoordinates(position.latitude, position.longitude);
    placeShortName.text = placemarks?[0].locality ?? "";
    houseController.text = placemarks?[0].street ?? "";
    streetController.text = placemarks?[0].locality ?? "";
    completeAddressController.text =
        "${placemarks?[0].street}, ${placemarks?[0].locality}, ${placemarks?[0].postalCode}, ${placemarks?[0].country}";
    setState(() {});

    return "${placemarks?[0].street}, ${placemarks?[0].locality}, ${placemarks?[0].postalCode}, ${placemarks?[0].country}";
  }

  String lastPickupTwoWords = '';

  splitPickupAddress({required String address}) {
    List<String> addressParts = address.split(', ');

    if (addressParts.length >= 2) {
      lastPickupTwoWords = addressParts.take(2).join(' ');
    }

    placeShortName.text = lastPickupTwoWords;
    setState(() {});
  }

  Timer? _pickupDebounce;

  List<loc.Prediction>? pickupSuggestion = [];

  bool isActiveDriver = false;
  bool isPickupCrossBtnShown = true;
  bool isPickupCrossBtn = true;
  _onPickupSearchChanged(String query) {
    if (_pickupDebounce?.isActive ?? false) _pickupDebounce?.cancel();
    _pickupDebounce = Timer(const Duration(milliseconds: 100), () async {
      final suggestions =
          await PlaceApiProvider.fetchSuggestions(query, 'en', '');

      setState(() {
        pickupSuggestion = suggestions?.predictions;

        if (isPickupCrossBtnShown) {
          isPickupCrossBtn = query.isNotEmpty ? true : false;
          setState(() {});
        }
      });
    });
  }

  _showPickupCrossIconWidget() {
    return (completeAddressController.text.isNotEmpty);
  }

  void clearPickupData() {
    completeAddressController.clear();

    setState(() {
      pickupSuggestion?.clear();
      isPickupCrossBtn = false;
    });
  }

  late LatLng pickupLatLong;

  bool buttonEnabled = false;

  getLatLong() async {
    final currentLocation = await Utils.getCurrentLocation();

    pickupLatLong = currentLocation;
  }

  @override
  void initState() {
    super.initState();
    accountCubit = context.read();
    _getCurrentLocation();
    getLatLong();
    splitPickupAddress(address: completeAddressController.text);
  }

  @override
  void dispose() {
    super.dispose();
    addressfocusNode.dispose();
    focusNode.dispose();
    licensefocusNode.dispose();
    _pickupDebounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        body: Stack(
          children: [
            SizedBox(
              height: size.height * 0.9,
              child: const GoogleMapWidget(),
            ),
            DraggableScrollableSheet(
                controller: controller,
                snap: false,
                minChildSize: 0.57,
                initialChildSize: 0.57,
                maxChildSize: 1,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20 * SizeConfig.widthMultiplier!),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 0.0 * SizeConfig.heightMultiplier!),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20 * SizeConfig.widthMultiplier!),
                              child: Text(
                                'name_address'.tr,
                                style: GoogleFonts.urbanist(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            CustomSizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20 * SizeConfig.widthMultiplier!),
                              child: Text(
                                "name".tr,
                                style: AppTextStyle.text14black0000W500
                                    ?.copyWith(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.50)),
                              ),
                            ),
                            CustomSizedBox(
                              height: 8,
                            ),
                            Focus(
                              focusNode: focusNode,
                              onFocusChange: (found) {
                                if (found == true) {
                                  controller.animateTo((0.89),
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.easeOut);
                                }
                                // else {
                                //   controller.animateTo((0.57),
                                //       duration:
                                //           const Duration(milliseconds: 100),
                                //       curve: Curves.easeOut);
                                // }
                              },
                              child: CustomTextFromField(
                                customInputFormatters: [
                                  FilteringTextInputFormatter(
                                      RegExp(r'[a-zA-Z]+|\s'),
                                      allow: true)
                                ],
                                controller: username,
                                hintTextStyle:
                                    AppTextStyle.text14kBlackTextColorW500,
                                hintText: 'enter_your_name'.tr,
                                textStyle: AppTextStyle.text20black0000W700,
                                onFieldSubmitted: (v) {
                                  setState(() {});
                                  validValue();
                                },
                                onChanged: (v) {
                                  setState(() {});
                                  validValue();
                                },
                              ),
                            ),
                            CustomSizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20 * SizeConfig.widthMultiplier!),
                              child: Text(
                                "License Number".tr,
                                style: AppTextStyle.text14black0000W500
                                    ?.copyWith(
                                        color: AppColors.kBlackTextColor
                                            .withOpacity(0.50)),
                              ),
                            ),
                            CustomSizedBox(
                              height: 10,
                            ),
                            Focus(
                              focusNode: licensefocusNode,
                              onFocusChange: (found) {
                                if (found == true) {
                                  controller.animateTo((0.89),
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.easeOut);
                                }
                              },
                              child: CustomTextFromField(
                                customInputFormatters: [
                                  UppercaseInputFormatter()
                                ],
                                controller: liceNumber,
                                hintTextStyle:
                                    AppTextStyle.text14kBlackTextColorW500,
                                hintText: 'License Number',
                                textStyle: AppTextStyle.text20black0000W700,
                                onFieldSubmitted: (v) {
                                  setState(() {});
                                  validValue();
                                },
                                onChanged: (v) {
                                  setState(() {});
                                  validValue();
                                },
                              ),
                            ),
                            CustomSizedBox(
                              height: 10,
                            ),
                            if (wantAddressField == false)
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20 * SizeConfig.widthMultiplier!),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "address".tr,
                                          style: AppTextStyle
                                              .text14black0000W500
                                              ?.copyWith(
                                                  color: AppColors
                                                      .kBlackTextColor
                                                      .withOpacity(0.50)),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            wantAddressField =
                                                !wantAddressField;
                                            setState(() {});
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 20 *
                                                    SizeConfig
                                                        .widthMultiplier!),
                                            padding: EdgeInsets.only(
                                                left: 20 *
                                                    SizeConfig.widthMultiplier!,
                                                right: 20 *
                                                    SizeConfig.widthMultiplier!,
                                                top: 5 *
                                                    SizeConfig
                                                        .heightMultiplier!,
                                                bottom: 5 *
                                                    SizeConfig
                                                        .heightMultiplier!),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.kRedDF0000,
                                                    width: 1 *
                                                        SizeConfig
                                                            .widthMultiplier!),
                                                color: AppColors.kGreyF2F3F3,
                                                borderRadius:
                                                    BorderRadius.circular(6 *
                                                        SizeConfig
                                                            .widthMultiplier!)),
                                            child: Text(
                                              "Edit",
                                              style: AppTextStyle
                                                  .text12black0000W500
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .kBlackTextColor
                                                          .withOpacity(0.50)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomSizedBox(
                                      height: 5 * SizeConfig.heightMultiplier!,
                                    ),
                                    Text(
                                      completeAddressController.text,
                                      style: AppTextStyle.text12black0000W500
                                          ?.copyWith(
                                              color: AppColors.kBlackTextColor
                                                  .withOpacity(0.50)),
                                    ),
                                    CustomSizedBox(
                                      height: 3 * SizeConfig.heightMultiplier!,
                                    ),
                                    Text(
                                      placeShortName.text,
                                      style: AppTextStyle.text14black0000W600,
                                    ),
                                  ],
                                ),
                              )
                            else
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20 * SizeConfig.widthMultiplier!,
                                    right: 19 * SizeConfig.widthMultiplier!),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'address'.tr,
                                      style: AppTextStyle.text14black0000W500
                                          ?.copyWith(
                                              color: AppColors.kBlackTextColor
                                                  .withOpacity(0.50)),
                                    ),
                                    CustomSizedBox(
                                      height: 12 * SizeConfig.heightMultiplier!,
                                    ),
                                    Column(
                                      children: [
                                        Focus(
                                          focusNode: addressfocusNode,
                                          onFocusChange: (found) {
                                            if (found == true) {
                                              controller.animateTo((1),
                                                  duration: const Duration(
                                                      milliseconds: 100),
                                                  curve: Curves.easeOut);
                                            } else {
                                              controller.animateTo((0.57),
                                                  duration: const Duration(
                                                      milliseconds: 100),
                                                  curve: Curves.easeOut);
                                            }
                                          },
                                          child: Container(
                                            width: 352 *
                                                SizeConfig.widthMultiplier!,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6 *
                                                        SizeConfig
                                                            .widthMultiplier!),
                                                border: Border.all(
                                                    color: AppColors
                                                        .kBlackTextColor
                                                        .withOpacity(0.5),
                                                    width: 1)),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    onChanged:
                                                        _onPickupSearchChanged,
                                                    controller:
                                                        completeAddressController,
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: const Color(
                                                                  0xffD9D9D9)
                                                              .withOpacity(
                                                                  0.20),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xffD9D9D9)
                                                                  .withOpacity(
                                                                      0.20),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      hintText:
                                                          'search_for_a_place'
                                                              .tr,
                                                      prefixIcon: const Icon(
                                                        Icons.search,
                                                        color: Colors.grey,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xffD9D9D9)
                                                                  .withOpacity(
                                                                      0.20),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                (!isPickupCrossBtnShown)
                                                    ? SizedBox()
                                                    : isPickupCrossBtn &&
                                                            _showPickupCrossIconWidget()
                                                        ? IconButton(
                                                            onPressed:
                                                                clearPickupData,
                                                            icon: Icon(
                                                                Icons.close))
                                                        : SizedBox()
                                              ],
                                            ),
                                          ),
                                        ),
                                        Wrap(
                                          children: List.generate(
                                              pickupSuggestion?.length ?? 0,
                                              (index) => GestureDetector(
                                                    onTap: () async {
                                                      controller.animateTo(
                                                          (0.43),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  100),
                                                          curve:
                                                              Curves.easeOut);
                                                      completeAddressController
                                                              .text =
                                                          pickupSuggestion?[
                                                                      index]
                                                                  .description
                                                                  .toString() ??
                                                              "";

                                                      splitPickupAddress(
                                                          address: pickupSuggestion?[
                                                                      index]
                                                                  .description
                                                                  .toString() ??
                                                              "");

                                                      PlaceWithLatLng?
                                                          placeWithLatLng =
                                                          await PlaceApiProvider
                                                              .fetchPlaceDetails(placeId:  pickupSuggestion?[
                                                          index]
                                                              .placeId);

                                                      setState(() {
                                                        pickupLatLong = LatLng(
                                                            placeWithLatLng
                                                                    ?.result
                                                                    ?.geometry
                                                                    ?.location
                                                                    ?.lat ??
                                                                0,
                                                            placeWithLatLng
                                                                    ?.result
                                                                    ?.geometry
                                                                    ?.location
                                                                    ?.lng ??
                                                                0);
                                                      });
                                                      validValue();

                                                      wantAddressField =
                                                          !wantAddressField;
                                                      pickupSuggestion?.clear();
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10 *
                                                              SizeConfig
                                                                  .heightMultiplier!,
                                                          bottom: 20 *
                                                              SizeConfig
                                                                  .widthMultiplier!,
                                                          left: 10 *
                                                              SizeConfig
                                                                  .widthMultiplier!),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 32 *
                                                                SizeConfig
                                                                    .heightMultiplier!,
                                                            width: 32 *
                                                                SizeConfig
                                                                    .widthMultiplier!,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(7 *
                                                                        SizeConfig
                                                                            .widthMultiplier!),
                                                                color: AppColors
                                                                    .kGreyEDEBEB),
                                                            child: Icon(
                                                              Icons.location_on,
                                                              size: 20 *
                                                                  SizeConfig
                                                                      .imageSizeMultiplier!,
                                                              color: AppColors
                                                                  .kBlackTextColor
                                                                  .withOpacity(
                                                                      0.56),
                                                            ),
                                                          ),
                                                          CustomSizedBox(
                                                            width: 15,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              pickupSuggestion?[
                                                                          index]
                                                                      .description
                                                                      .toString() ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontSize: 14 *
                                                                      SizeConfig
                                                                          .textMultiplier!,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            CustomSizedBox(
                              height: 15 * SizeConfig.heightMultiplier!,
                            ),
                            BlocBuilder<AccountCubit, AccountState>(
                              builder: (context, state) {
                                return BlueButton(
                                  buttonIsEnabled: buttonEnabled,
                                  isLoading: state is VehicleInfoLoading,
                                  onTap: () {
                                    if (username.text.isNotEmpty == true) {
                                      accountCubit.postBMTTravelInfo(
                                          licenseNumber: liceNumber.text,
                                          place: placeShortName.text,
                                          address:
                                              completeAddressController.text,
                                          firstName: username.text,
                                          position: pickupLatLong.longitude !=
                                                  null
                                              ? DriverPosition(
                                                  latitude:
                                                      pickupLatLong.latitude,
                                                  longitude:
                                                      pickupLatLong.longitude)
                                              : DriverPosition(
                                                  latitude:
                                                      pickupLatLong.latitude,
                                                  longitude:
                                                      pickupLatLong.longitude));

                                      // if (flavor.F.appFlavor ==
                                      //     flavor.Flavor.bmtravels) {
                                      //   accountCubit.postBMTTravelInfo(
                                      //       licenseNumber: liceNumber.text,
                                      //       place: placeShortName.text,
                                      //       address:
                                      //           completeAddressController.text,
                                      //       firstName: username.text,
                                      //       position: pickupLatLong.longitude !=
                                      //               null
                                      //           ? DriverPosition(
                                      //               latitude:
                                      //                   pickupLatLong.latitude,
                                      //               longitude:
                                      //                   pickupLatLong.longitude)
                                      //           : DriverPosition(
                                      //               latitude:
                                      //                   pickupLatLong.latitude,
                                      //               longitude: pickupLatLong
                                      //                   .longitude));
                                      // } else {
                                      //   // AnywhereDoor.pushNamed(context,
                                      //   //     routeName: RouteName
                                      //   //         .driverOnBoardingVehicleInfoScreen,
                                      //   //     arguments: DriverOnBoardingVehicleInfoScreen(
                                      //   //         name: username.text,
                                      //   //         address:
                                      //   //             completeAddressController
                                      //   //                 .text,
                                      //   //         placeShortName: placeShortName
                                      //   //             .text,
                                      //   //         position:
                                      //   //             pickupLatLong.longitude !=
                                      //   //                     null
                                      //   //                 ? DriverPosition(
                                      //   //                     latitude:
                                      //   //                         pickupLatLong
                                      //   //                             .latitude,
                                      //   //                     longitude:
                                      //   //                         pickupLatLong
                                      //   //                             .longitude)
                                      //   //                 : DriverPosition(
                                      //   //                     latitude:
                                      //   //                         pickupLatLong
                                      //   //                             .latitude,
                                      //   //                     longitude:
                                      //   //                         pickupLatLong
                                      //   //                             .longitude)));
                                      // }
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 40 * SizeConfig.heightMultiplier!,
                          left: 22 * SizeConfig.widthMultiplier!),
                      child: Icon(
                        Icons.menu,
                        size: 40 * SizeConfig.imageSizeMultiplier!,
                        color: AppColors.kBlackTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  validValue() {
    if (username.text.isNotEmpty == true &&
        completeAddressController.text.isNotEmpty == true &&
        liceNumber.text.isNotEmpty == true) {
      setState(() {
        buttonEnabled = true;
      });
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime ?? DateTime.now()) >
            const Duration(seconds: 2)) {
      currentBackPressTime = now;

      CustomToastUtils.showToast(
          title: "Please click back again to exit.",
          context: context,
          imagePath: ImagePath.warningIcon,
          toastColor: AppColors.kYellowFFCB00);

      return Future.value(false);
    }
    return Future.value(true);
  }
}
