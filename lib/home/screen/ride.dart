import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart'
    as ride_model;
import 'package:travelx_driver/home/widget/auto_ride_card/auto_ride_card.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/google_map/google-map.widget.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/constants/imagePath/image_paths.dart';
import '../../shared/local_storage/log_in_status.dart';
import '../../shared/utils/image_loader/image_loader.dart';
import '../../shared/widgets/buttons/blue_button.dart';
import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/size_config/size_config.dart';
import '../bloc/home_cubit.dart';

class RidesScreen extends StatefulWidget {
  RidesScreen({Key? key, required this.rides}) : super(key: key);

  List<ride_model.Ride> rides;

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late HomeCubit _homeCubit;
  int? selectedRideIndex;
  List<ride_model.Ride> rides = [];

  LogInStatus userHasLoggedIn = LogInStatus();

  bool pauseCountdownTimer = false;
  late Timer calculateRemainingTimer;
  final _googleMapWidgetStateKey = GlobalKey<GoogleMapWidgetState>();

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _homeCubit.emitState(GotRideSuccess(widget.rides));
    // _homeCubit.stream.listen((state) {
    //   if (state is GotRideSuccess) {
    //     handleGotRideSuccess(state);
    //   }
    // });
    calculateRemainingTimer = Timer.periodic(const Duration(seconds: 1), (
      timer,
    ) {
      if (!pauseCountdownTimer && timeRemainingToCancel > 0) {
        _homeCubit.emitState(
          GetRideRemainingTime(remainingTime: --timeRemainingToCancel),
        );
      } else {
        calculateRemainingTimer.cancel();
        AnywhereDoor.pop(context);
      }
    });

    super.initState();
  }

  void setRideInitialRouteInMap() async {
    // Use a guard clause to avoid null checks.
    final selectedRide =
        selectedRideIndex != null ? rides[selectedRideIndex!] : null;
    final googleMapWidgetState = _googleMapWidgetStateKey.currentState;

    if (selectedRide != null && googleMapWidgetState != null) {
      // Use a null-aware operator to avoid null checks.
      final fullRoute = selectedRide.route?.firstWhere(
        (element) => element.type == 'full_route',
      );

      googleMapWidgetState.setRouteForRideWithMarkers(
        driverLocation: selectedRide.driver.position,
        routePath: fullRoute?.routePath,
        rideSequence: selectedRide.tripSequence,
      );
    }
  }

  goToRideStatusRoute(RideStatus rideStatus) {
    switch (rideStatus) {
      case RideStatus.accepted:
        // Navigator.pushReplacementNamed(
        //   context,
        //   arguments: rides[selectedRideIndex ?? 0],
        //   RouteName.rideDirectionsScreen,
        // );
        break;
      case RideStatus.declined:
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await AnywhereDoor.pop(context);
        });

        break;
      case RideStatus.unresponsive:
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await AnywhereDoor.pop(context);
        });
        break;
      case RideStatus.arrivedAtPickup:
        // TODO: Handle this case.
        break;
      case RideStatus.pickedUp:
        // TODO: Handle this case.
        break;
      case RideStatus.arrivedAtDropOff:
        // TODO: Handle this case.
        break;
      case RideStatus.delivered:
        // TODO: Handle this case.
        break;
      case RideStatus.ontrip:
        // TODO: Handle this case.
        break;
      case RideStatus.cancel:
        // TODO: Handle this case.
        break;
      case RideStatus.none:
        // TODO: Handle this case.
        throw UnimplementedError();
      case RideStatus.started:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  @override
  void dispose() {
    calculateRemainingTimer.cancel();
    log('ride disposed');
    super.dispose();
  }

  bool isLoadingApi = false;
  int timeRemainingToCancel = 30;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kBlueF8F9FD,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMapWidget(
                  key: _googleMapWidgetStateKey,
                  onCancel: () {
                    pauseCountdownTimer = true;
                    _homeCubit.showCancelRideDialog(
                      context,
                      tripId: rides[selectedRideIndex ?? 0].tripId ?? '',
                      rateID: rides[selectedRideIndex ?? 0].price?.id ?? '',
                      rideID: rides[selectedRideIndex ?? 0].rideId ?? '',
                      rideStatus: RideStatus.declined,
                      onSubmit: () {
                        pauseCountdownTimer = false;

                        AnywhereDoor.pushReplacementNamed(
                          context,
                          routeName: RouteName.homeScreen,
                        );
                        // AnywhereDoor.pop(context);
                      },
                      onCancel: () {
                        pauseCountdownTimer = false;
                      },
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 20 * SizeConfig.widthMultiplier!,
                      bottom: 20 * SizeConfig.heightMultiplier!,
                    ),
                    child: BlocConsumer<HomeCubit, HomeState>(
                      listenWhen:
                          (previous, current) =>
                              current is GetRideRemainingTime ||
                              current is MutateRideSuccess ||
                              current is GotRideSuccess ||
                              current is RidesLoading ||
                              current is GetSelectedRide ||
                              current is GetRidesFullRouteSuccess ||
                              current is GetRidesFullRouteFailed ||
                              current is GetRidesFullRouteLoading,
                      listener: (context, state) async {
                        if (state is AcceptedByOtherDriver) {}

                        if (state is MutateRideSuccess) {
                          // goToRideStatusRoute(state.rideStatus);
                        } else if (state is GetRideRemainingTime) {
                          timeRemainingToCancel = state.remainingTime;
                          if (timeRemainingToCancel == 0) {
                            // _homeCubit.pauseResumeRideTimer(false);
                            await goToRideStatusRoute(RideStatus.unresponsive);
                          }
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 58 * SizeConfig.heightMultiplier!,
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 58 * SizeConfig.heightMultiplier!,
                                width: 58 * SizeConfig.widthMultiplier!,
                                child: CircularProgressIndicator(
                                  strokeWidth: 7,
                                  value: timeRemainingToCancel / 30,
                                  color: AppColors.kRed,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20 * SizeConfig.widthMultiplier!,
                                  top: 20 * SizeConfig.heightMultiplier!,
                                ),
                                child: Text(
                                  "${timeRemainingToCancel.toString()}s",
                                  style: AppTextStyle.text14kBlackTextColorW600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is RidesLoading) {
                handleRidesLoading(state);
              }
              if (state is GetRidesFullRouteLoading) {
                handleGetRidesFullRouteLoading(state);
              }
              if (state is GetRidesFullRouteSuccess) {
                handleGetRidesFullRouteSuccess(state);
              }
              if (state is GetSelectedRide) {
                handleGetSelectedRide(state);
              }
              if (state is GotRideSuccess) {
                handleGotRideSuccess(state);
              }

              return Container(
                constraints: BoxConstraints(
                  minHeight: size.height * 0.12,
                  maxHeight: size.height * 0.45,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5 * SizeConfig.widthMultiplier!,
                  ),
                  child: PageView.builder(
                    itemCount: rides.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return AutoRideCard(
                        totalPrice: rides[index].price?.totalPrice,
                        isSelected: selectedRideIndex == index,
                        ride: rides[index],
                        onTap: () {
                          _homeCubit.getRidesFullRoute(
                            deliveryId: rides[index].rideId ?? '',
                            selectedRideIndex: index,
                            driverPosition: rides[index].driver.position,
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0 * SizeConfig.widthMultiplier!,
              right: 20 * SizeConfig.widthMultiplier!,
              bottom: 20 * SizeConfig.heightMultiplier!,
            ),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return BlueButton(
                  wantMargin: false,
                  isLoading: state is MutateOnTripsLoading,
                  title: "Accept",
                  onTap: () async {
                    //_homeCubit.pauseResumeRideTimer(true);

                    // userHasLoggedIn.storeGotDriverData(
                    //   ride: rides[selectedRideIndex ?? 0],
                    // );

                    final bool? result = await _homeCubit.mutateRides(
                      tripId: rides[selectedRideIndex ?? 0].rideTripId ?? '',
                      rateID: rides[selectedRideIndex ?? 0].price?.id ?? '',
                      rideID: rides[selectedRideIndex ?? 0].rideId ?? '',
                      rideStatus: RideStatus.accepted,
                      userDeviceToken:
                          rides[selectedRideIndex ?? 0].user?.deviceToken ?? '',
                      userAmount:
                          rides[selectedRideIndex ?? 0].payment?.amount ?? '',
                      userCurrency:
                          rides[selectedRideIndex ?? 0].payment?.currency ?? '',
                      userMode:
                          rides[selectedRideIndex ?? 0].payment?.mode ?? '',
                      userPaymentStatus:
                          rides[selectedRideIndex ?? 0].payment?.status ?? '',
                      mutationReason: '',
                    );

                    if (result == true) {
                      AnywhereDoor.pushReplacementNamed(
                        context,
                        routeName: RouteName.homeScreen,
                      );
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        rideAcceptedByOtherDriver(context: context);
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleGetSelectedRide(GetSelectedRide state) {
    // Use a guard clause to avoid null checks.
    final googleMapWidgetState = _googleMapWidgetStateKey.currentState;
    if (googleMapWidgetState == null) {
      return;
    }
    // Update the selected ride index.
    selectedRideIndex = state.selectedRideIndex;
    // If there is a selected ride, set the route on the map.
    if (selectedRideIndex != null) {
      googleMapWidgetState.setRouteForRideWithMarkers(
        driverLocation: rides[selectedRideIndex!].driver.position,
        routePath:
            rides[selectedRideIndex!].route
                ?.firstWhere(
                  (element) => element.type == 'full_route',
                  orElse: () => ride_model.Route(),
                )
                .routePath,
        rideSequence: rides[selectedRideIndex!].tripSequence,
      );
    }
  }

  void handleGetRidesFullRouteSuccess(GetRidesFullRouteSuccess state) {
    // Use a guard clause to avoid null checks.
    final googleMapWidgetState = _googleMapWidgetStateKey.currentState;
    if (googleMapWidgetState == null) {
      return;
    }

    // Schedule a post-frame callback to pop the current screen if possible.
    // This ensures that the screen is popped after the current frame has been
    // rendered, which prevents any errors.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Navigator.of(context).canPop()) {
        Navigator.pop(context);
      }
    });

    // Update the selected ride index and set the route on the map.
    selectedRideIndex = state.selectedRideIndex;
    googleMapWidgetState.setRouteForRideWithMarkers(
      driverLocation: rides[selectedRideIndex!].driver.position,
      routePath: state.routePath,
      rideSequence: rides[selectedRideIndex!].tripSequence,
    );

    // Emit a new state to the home cubit.
    _homeCubit.emitState(GetRideSummary());
  }

  Future<void> handleRidesLoading(RidesLoading state) async {
    // Use a guard clause to avoid null checks.
    if (widget.rides.isEmpty) {
      return;
    }

    // Get the selected ride.
    final selectedRide = rides[selectedRideIndex ?? 0];

    // Mutate the ride to be unresponsive.
    await _homeCubit.mutateRides(
      tripId: selectedRide.rideTripId ?? '',
      rateID: selectedRide.price?.id ?? '',
      rideID: selectedRide.rideId ?? '',
      rideStatus: RideStatus.unresponsive,
      mutationReason: '',
    );

    // Pop the current screen if possible.
    // This should be done in a post-frame callback to avoid any errors.

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AnywhereDoor.pop(context);
    });
  }

  void handleGetRidesFullRouteLoading(GetRidesFullRouteLoading state) {
    // Show a loading dialog.
    showLoadingDialog(context);
  }

  void showLoadingDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CupertinoActivityIndicator());
        },
      );
    });
  }

  void handleGotRideSuccess(GotRideSuccess state) {
    // Reset the rides list.
    rides.clear();

    // Add the new rides to the list.
    rides.addAll(state.rides);

    // Set the selected ride index to the first ride.
    selectedRideIndex = 0;

    // Set the initial route on the map.
    setRideInitialRouteInMap();

    // Emit a new state to the home cubit.
    _homeCubit.emitState(GetRideSummary());
  }

  Future<void> rideAcceptedByOtherDriver({
    required BuildContext context,
    String? message,
  }) {
    return showDialog(
      context: context,
      barrierColor: AppColors.kBlackTextColor.withOpacity(0.45),
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: 210 * SizeConfig.heightMultiplier!,
                left: 20 * SizeConfig.widthMultiplier!,
                right: 20 * SizeConfig.widthMultiplier!,
              ),
              child: Container(
                height: 96 * SizeConfig.heightMultiplier!,
                width: 320 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: AppColors.kRedD32F2F,
                  borderRadius: BorderRadius.circular(
                    5 * SizeConfig.widthMultiplier!,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 14 * SizeConfig.heightMultiplier!,
                        left: 10 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          ImageLoader.svgPictureAssetImage(
                            height: 24 * SizeConfig.heightMultiplier!,
                            width: 24 * SizeConfig.widthMultiplier!,
                            imagePath: ImagePath.errorOutlineIcon,
                          ),
                          CustomSizedBox(width: 7),
                          Text(
                            "Ride Accepted by other driver",
                            style: AppTextStyle.text16kWhiteW600,
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              AnywhereDoor.pop(context);
                              AnywhereDoor.pop(context);
                            },
                            child: ImageLoader.svgPictureAssetImage(
                              imagePath: ImagePath.cutIcon,
                              width: 25,
                            ),
                          ),
                          CustomSizedBox(width: 10),
                        ],
                      ),
                    ),
                    CustomSizedBox(width: 4),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 40 * SizeConfig.widthMultiplier!,
                      ),
                      child: Text(
                        "Ride has been Accepted by the other \ndriver.",
                        style: AppTextStyle.text14kWhiteW600.copyWith(
                          color: AppColors.kWhite.withOpacity(0.80),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
