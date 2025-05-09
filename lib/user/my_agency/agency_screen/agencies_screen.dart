import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marquee/marquee.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/app_styles/app_styles.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/routes/navigator.dart';
import '../../../shared/utils/image_loader/image_loader.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../bloc/my_agency_cubit.dart';
import '../entity/my_agency_entity.dart';
import '../widget_shimmer/agencies_list_shimmer.dart';

class AgencyListScreen extends StatefulWidget {
  const AgencyListScreen({super.key});

  @override
  State<AgencyListScreen> createState() => _AgencyListScreenState();
}

class _AgencyListScreenState extends State<AgencyListScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  late MyAgencyCubit _myAgencyCubit;
  bool buttonEnabled = false;

  MyAgency? myAgency;
  int? selectedIndex;
  bool showDropDownButton = false;

  GoogleMapController? _mapController;

  Marker? _myMarker;

  Future<BitmapDescriptor> getMarkerImage(String path) async {
    ByteData bytes = await rootBundle.load(path);
    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List(),
        size: const Size(10, 10));
  }

  @override
  void initState() {
    _myAgencyCubit = BlocProvider.of<MyAgencyCubit>(context);
    _myAgencyCubit.getMyAgencyCubit();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RideBackButton(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              CustomSizedBox(
                width: 80,
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 45 * SizeConfig.heightMultiplier!),
                child: Text("my_agencies".tr,
                    style: AppTextStyle.text20kBlackTextColorW700.copyWith(
                        color: AppColors.kBlackTextColor.withOpacity(0.70))),
              ),
            ],
          ),
          CustomSizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 18 * SizeConfig.widthMultiplier!,
                right: 18 * SizeConfig.widthMultiplier!),
            child: const Divider(),
          ),
          CustomSizedBox(
            height: 18,
          ),
          BlocConsumer<MyAgencyCubit, MyAgencyState>(
            listener: (context, state) {
              if (state is GetAgencyLocationSuccess) {
                myAgency = state.myAgency;
              }
            },
            builder: (context, state) {
              if (state is GetAgencyLocationEmpty) {
                return Center(
                  child: Text(
                    state.emptyMessage ?? "",
                    style: AppTextStyle.text14Black0000W400,
                  ),
                );
              }
              if (state is GetAgencyLoading) {
                return const Center(child: AgenciesListShimmer());
              }
              if (state is GetAgencyLocationSuccess) {
                return Wrap(
                    children: List.generate(
                  myAgency?.data.length ?? 0,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                        bottom: 5.0 * SizeConfig.heightMultiplier!),
                    child: GestureDetector(
                      onTap: () async {
                        selectedIndex = index;
                        showDropDownButton = true;
                        final driverMarker =
                            await getMarkerImage(ImagePath.icDriverPosition);
                        _myMarker = Marker(
                          markerId: const MarkerId("my_marker"),
                          position: LatLng(
                              double.tryParse(myAgency?.data[index].latitude
                                          .toString() ??
                                      "0.0") ??
                                  0.0,
                              double.tryParse(myAgency?.data[index].longitude
                                          .toString() ??
                                      "0.0") ??
                                  0.0),
                          icon: driverMarker,
                        );
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: index == selectedIndex
                                        ? AppColors.bBlack070202
                                        : Colors.transparent,
                                    width: 1),
                                color: AppColors.kBlueF2F1F7),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 11 * SizeConfig.widthMultiplier!,
                                  top: 10 * SizeConfig.heightMultiplier!,
                                  bottom: 7 * SizeConfig.heightMultiplier!),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 22 *
                                                SizeConfig.widthMultiplier!),
                                        child: ImageLoader.svgPictureAssetImage(
                                            width: 16 *
                                                SizeConfig.widthMultiplier!,
                                            height: 16 *
                                                SizeConfig.heightMultiplier!,
                                            imagePath: ImagePath.userIcon,
                                            color: AppColors.kBlackTextColor),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10 *
                                                SizeConfig.widthMultiplier!),
                                        child: Text(
                                          myAgency?.data[index].businessName
                                                      .isNotEmpty ==
                                                  true
                                              ? (myAgency
                                                      ?.data[index].businessName.capitalizeFirst??
                                                  "")
                                              : (myAgency?.data[index]
                                                      .businessName ??
                                                  ""), // Use null-coalescing operator for empty string default
                                          style:
                                              AppTextStyle.text14black0000W500,
                                        ),
                                      ),
                                      CustomSizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    AppColors.kBlackTextColor),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Row(
                                            children: [
                                              ImageLoader.svgPictureAssetImage(
                                                  width: 18 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                  height: 18 *
                                                      SizeConfig
                                                          .heightMultiplier!,
                                                  imagePath:
                                                      ImagePath.travelPhoneIcon,
                                                  color: AppColors.kblueDF0000),
                                              CustomSizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                myAgency?.data[index]
                                                        .phoneNumber ??
                                                    "",
                                                style: AppTextStyle
                                                    .text16black0000W400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomSizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      if (myAgency?.data[index].address
                                                  .isNotEmpty ==
                                              true &&
                                          myAgency?.data[index].address ==
                                              "OFFLINE")
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8 *
                                                  SizeConfig.widthMultiplier!),
                                          child: ImageLoader.assetLottie(
                                              imagePath:
                                                  ImagePath.pickupAnimation,
                                              height: 40 *
                                                  SizeConfig.heightMultiplier!,
                                              width: 40 *
                                                  SizeConfig.widthMultiplier!),
                                        ),
                                      if (myAgency?.data[index].address
                                                  .isNotEmpty ==
                                              true &&
                                          myAgency?.data[index].address !=
                                              "OFFLINE")
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8 *
                                                  SizeConfig.widthMultiplier!),
                                          child: ImageLoader.assetLottie(
                                              imagePath:
                                                  ImagePath.onlineAnimation,
                                              height: 30 *
                                                  SizeConfig.heightMultiplier!,
                                              width: 40 *
                                                  SizeConfig.widthMultiplier!),
                                        ),
                                      if (myAgency?.data[index].address
                                                  .isNotEmpty ==
                                              true &&
                                          myAgency?.data[index].address !=
                                              "OFFLINE")
                                        SizedBox(
                                          width:
                                              300 * SizeConfig.widthMultiplier!,
                                          height:
                                              20 * SizeConfig.heightMultiplier!,
                                          child: Marquee(
                                            text:
                                                myAgency?.data[index].address ??
                                                    "",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            scrollAxis: Axis.horizontal,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            blankSpace: 10.0,
                                            velocity: 50.0,
                                            pauseAfterRound: const Duration(
                                                milliseconds: 500),
                                            startPadding: 10.0,
                                            accelerationDuration:
                                                const Duration(seconds: 1),
                                            accelerationCurve: Curves.linear,
                                            decelerationDuration:
                                                const Duration(
                                                    milliseconds: 500),
                                            decelerationCurve: Curves.easeOut,
                                          ),
                                        )
                                      else
                                        Text(
                                          myAgency?.data[index].address ?? "",
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (selectedIndex == index &&
                              myAgency?.data[index].address != "OFFLINE" &&
                              showDropDownButton == true)
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration:
                                  BoxDecoration(color: AppColors.kGreyF0EFEF),
                              child: SizedBox(
                                height: 200 * SizeConfig.heightMultiplier!,
                                child: GoogleMap(
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _mapController = controller;
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        double.tryParse(myAgency
                                                    ?.data[index].latitude
                                                    .toString() ??
                                                "0.0") ??
                                            0.0,
                                        double.tryParse(myAgency
                                                    ?.data[index].longitude
                                                    .toString() ??
                                                "0.0") ??
                                            0.0),
                                    zoom: 16.0,
                                  ),
                                  markers: {if (_myMarker != null) _myMarker!},
                                ),
                              ),
                            ),
                          if (selectedIndex == index &&
                              myAgency?.data[index].address != "OFFLINE" &&
                              showDropDownButton == true)
                            CustomSizedBox(
                              height: 10,
                            ),
                          if (selectedIndex == index &&
                              myAgency?.data[index].address != "OFFLINE" &&
                              showDropDownButton == true)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showDropDownButton = false;
                                    });
                                  },
                                  child: ImageLoader.svgPictureAssetImage(
                                    imagePath: ImagePath.upDropDownIcon,
                                  ),
                                ),
                                CustomSizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ));
              }
              return const Center(child: Text("yy"));
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showAlertDialog({required int selectedIndex}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final GlobalKey<ScaffoldState> alertKey = GlobalKey<ScaffoldState>();
        return Dialog(
            backgroundColor: AppColors.kWhite,
            key: alertKey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(4 * SizeConfig.widthMultiplier!))),
            elevation: 4.0,
            insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
                width: 202 * SizeConfig.widthMultiplier!,
                height: 110 * SizeConfig.widthMultiplier!,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 16 * SizeConfig.widthMultiplier!),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSizedBox(
                        height: 12,
                      ),
                      Text(
                        'Do you want to remove this \nagency!',
                        style: AppTextStyle.text14Black0000W400,
                      ),
                      CustomSizedBox(
                        height: 10,
                      ),
                      BlocConsumer<MyAgencyCubit, MyAgencyState>(
                        listener: (context, state) {
                          if (state is AgencyRemoveSuccess) {
                            AnywhereDoor.pop(context);
                            _myAgencyCubit.getMyAgencyCubit();
                          }
                        },
                        builder: (context, state) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0 * SizeConfig.widthMultiplier!),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            5 * SizeConfig.widthMultiplier!),
                                        border: Border.all(
                                            color: AppColors.kBlackTextColor,
                                            width: 1)),
                                    height: 30 * SizeConfig.heightMultiplier!,
                                    width: 90 * SizeConfig.widthMultiplier!,
                                  ),
                                  CustomSizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            5 * SizeConfig.widthMultiplier!),
                                        border: Border.all(
                                            color: AppColors.kRed1, width: 1)),
                                    height: 30 * SizeConfig.heightMultiplier!,
                                    width: 90 * SizeConfig.widthMultiplier!,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style:
                                              AppTextStyle.text13kredColorW700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )));
      },
    );
  }
}
