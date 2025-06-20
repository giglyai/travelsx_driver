import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:geolocator/geolocator.dart' as loc;
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/home/hire_driver_bloc/cubit/hire_driver_cubit.dart';
import 'package:travelx_driver/home/hire_driver_bloc/entity/upcoming_ontrip_ride_res.dart';
import 'package:travelx_driver/home/hire_driver_bloc/screen/draggble_hire_direction_screen.dart';
import 'package:travelx_driver/home/models/distance_matrix_model.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/home/screen/trip_settled_screen.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/local_storage/log_in_status.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/google_map/google-map.widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HireDriverRideDirectionsScreenParams {
  final OntripRide ride;

  HireDriverRideDirectionsScreenParams({required this.ride});
}

class HireDriverRideDirectionsScreen extends StatefulWidget {
  final HireDriverRideDirectionsScreenParams params;

  const HireDriverRideDirectionsScreen({super.key, required this.params});

  @override
  State<HireDriverRideDirectionsScreen> createState() =>
      _HireDriverRideDirectionsScreenState();
}

class _HireDriverRideDirectionsScreenState
    extends State<HireDriverRideDirectionsScreen>
    with WidgetsBindingObserver {
  late HomeCubit _homeCubit;
  late HireDriverCubit _hireDriverCubit;
  // late Timer distanceTimeTimer;
  LogInStatus logInStatus = LogInStatus();
  final _googleMapWidgetStateKey = GlobalKey<GoogleMapWidgetState>();
  DistanceMatrix? distanceMatrix;
  DriverPosition driverPosition = DriverPosition(latitude: 0.0, longitude: 0.0);
  bool onRoute = true;
  final loc.LocationSettings locationSettings = const loc.LocationSettings(
    accuracy: loc.LocationAccuracy.high,
    distanceFilter: 1,
  );
  late StreamSubscription<loc.Position> positionStream;
  double markerDirection = 0.0;
  int rideSequence = 0;
  int pickupSequence = 1;
  int dropSequence = 0;
  bool isMapLoaded = false;
  bool? isArrived;
  bool? isArrivedAtDropUp;
  String? rideType;
  bool buttonConfirmationEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _hireDriverCubit = BlocProvider.of<HireDriverCubit>(context);
    _hireDriverCubit.flushData();
    WidgetsBinding.instance.addObserver(this);
    if (widget.params.ride.userMessage == "REACHED") {
      _hireDriverCubit.getFinalRideDetails(
        rideID: widget.params.ride.rideId ?? "",
        mutationReason: '',
      );
    } else if (widget.params.ride.userMessage == "ARRIVED") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _hireDriverCubit.showVerifyOtp(
          rideID: widget.params.ride.rideId ?? "",
          startDist: 0,
          endDist: 0,
          userDeviceToken: widget.params.ride.user?.deviceToken,
          userAmount: widget.params.ride.payment?.amount,
          userCurrency: widget.params.ride.payment?.currency,
          userMode: widget.params.ride.payment?.mode,
          userPaymentStatus: widget.params.ride.payment?.status,
        );
      });
    }

    driverPosition = DriverPosition(
      latitude: widget.params.ride.driver.position.latitude,
      longitude: widget.params.ride.driver.position.longitude,
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      Utils.getCurrentLocation()
          .then((LatLng position) {
            driverPosition = DriverPosition(
              latitude: position.latitude,
              longitude: position.longitude,
            );
            positionStream = loc.Geolocator.getPositionStream(
              locationSettings: locationSettings,
            ).listen((loc.Position position) {
              if (isMapLoaded) {
                _googleMapWidgetStateKey.currentState?.updateDriverMarker(
                  position,
                );
              }
            });
          })
          .catchError((error) {
            // Handle potential errors from getCurrentLocation
            print('Error getting location: $error');
          });
    });

    if (widget.params.ride.userMessage == "RIDEOTPVERIFIED") {
      _hireDriverCubit.updateRideStatus(RideStatus.arrivedAtPickup);
    } else {
      _hireDriverCubit.updateRideStatus(
        RideStatus.fromString(widget.params.ride.userMessage),
      );
    }

    _homeCubit.postUserCurrentLocation();

    Future.delayed(const Duration(seconds: 1), () {
      _hireDriverCubit.getDistanceMatrix(
        onRoute: false,
        sourceLatLng: widget.params.ride.driver.position,
        destinationLatLng:
            widget
                .params
                .ride
                .tripSequence![(_hireDriverCubit.state.onGoingRideStatus ==
                            RideStatus.started ||
                        _hireDriverCubit.state.onGoingRideStatus ==
                            RideStatus.arrivedAtPickup)
                    ? 0
                    : 1]
                .position,
      );
    });

    // distanceTimeTimer =
    //     Timer.periodic(const Duration(minutes: 10), (timer) async {
    //   onRoute = _googleMapWidgetStateKey.currentState?.isDriverOnroute(
    //           LatLng(driverPosition.latitude, driverPosition.longitude)) ??
    //       false;
    //   // await _hireDriverCubit.getDistanceMatrix(
    //   //   onRoute: onRoute,
    //   //   sourceLatLng: driverPosition,
    //   //   destinationLatLng:
    //   //       widget.params.ride.tripSequence![rideSequence].position,
    //   // );
    //   //TODO remove static driver id
    //
    //   // await _hireDriverCubit.mutateHireDriverRides(
    //   //   tripId: widget.params.ride.tripId ?? '',
    //   //   rateID: widget.params.ride.price?.id ?? '',
    //   //   rideID: widget.params.ride.rideId ?? '',
    //   //   rideStatus: RideStatus.ontrip,
    //   //   mutationReason: '',
    //   // );
    // });
    super.initState();
  }

  gotoNextSequence() async {
    isArrivedAtDropUp = true;
    isArrived = null;
    if ((rideSequence + 1) == widget.params.ride.tripSequence?.length) {
      //TODO handle trip completion case
      // _homeCubit.emitState(GetTripSettlementAmount(
      //     settlementAmount:
      //         (widget.params.ride.price?.totalPrice ?? 0).toString(),
      //     pickupAddress: widget.params.ride.tripSequence?[0].address ?? "",
      //     dropupAddress: widget.params.ride.tripSequence?[1].address ?? ""));
    } else {
      rideSequence++;
      if (widget.params.ride.tripSequence![rideSequence].type ==
          LocationRideType.pickup.getLocationRideTypeString) {
        pickupSequence++;
      } else {
        dropSequence++;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // distanceTimeTimer.cancel();
    //positionStream.cancel();
    // _homeCubit.pauseResumeRideTimer(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FGBGNotifier(
      onEvent: (FGBGType value) {
        final path =
            ModalRoute.of(navigatorKey.currentState!.context)?.settings.name;

        if (value == FGBGType.foreground && path == null) {
          callBackgroundApis();
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: size.height * 0.7,
                child: GoogleMapWidget(
                  key: _googleMapWidgetStateKey,
                  isNavigationMap: true,
                  onCancel: () {
                    _homeCubit.showCancelRideDialog(
                      context,
                      tripId: widget.params.ride.tripId ?? '',
                      rateID: widget.params.ride.price?.id ?? '',
                      rideID: widget.params.ride.rideId ?? '',
                      rideStatus: RideStatus.cancel,
                      onSubmit: () {
                        // _homeCubit.pauseResumeRideTimer(false);

                        logInStatus.clearRide();
                        AnywhereDoor.pushReplacementNamed(
                          context,
                          routeName: RouteName.homeScreen,
                        );
                      },
                      onCancel: () {},
                    );
                  },
                ),
              ),
              BlocListener<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is GetTripSettlementAmount) {
                    logInStatus.clearRide();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (BuildContext context) => RideSettlementScreen(
                              currency:
                                  widget.params.ride.payment?.currency ?? "",
                              settlementAmount:
                                  (widget.params.ride.payment?.amount ?? 0)
                                      .toString(),
                              pickupAddress:
                                  widget.params.ride.tripSequence![0].address ??
                                  "",
                              dropupAddress:
                                  widget.params.ride.tripSequence![1].address ??
                                  "",
                            ),
                      ),
                    );
                  }
                },
                child: Container(),
              ),
              BlocBuilder<HireDriverCubit, HireState>(
                builder: (context, state) {
                  if (state.driverMutateRideStatus.success) {
                    if (state.rideStatus == RideStatus.arrivedAtPickup ||
                        state.rideStatus == RideStatus.arrivedAtDropOff) {
                      isArrived = true;
                    } else if (state.rideStatus == RideStatus.pickedUp ||
                        state.rideStatus == RideStatus.delivered) {
                      gotoNextSequence();
                    }
                  }

                  if (state.distanceMatrixStatus.success) {
                    if (state.distanceMatrix?.routePath != null) {
                      _googleMapWidgetStateKey.currentState
                          ?.setNavigationRouteForRide(
                            markerDirection: markerDirection,
                            state.distanceMatrix?.routePath,
                            driverLocation: driverPosition,
                            destination:
                                widget
                                    .params
                                    .ride
                                    .tripSequence![rideSequence]
                                    .position,
                            type:
                                widget
                                    .params
                                    .ride
                                    .tripSequence![rideSequence]
                                    .type,
                          );
                    }
                    distanceMatrix = state.distanceMatrix;
                    isMapLoaded = true;
                  }

                  return HireDraggableRideCardScreen(
                    status: state.onGoingRideStatus ?? RideStatus.started,
                    isLoading: state.driverMutateRideStatus.isLoading,
                    rideSequence:
                        widget.params.ride.tripSequence?[(state
                                        .onGoingRideStatus ==
                                    RideStatus.started ||
                                state.onGoingRideStatus ==
                                    RideStatus.arrivedAtPickup)
                            ? 0
                            : 1],
                    distanceMatrix: distanceMatrix,
                    onArrival: () async {
                      if (RideStatus.fromString(
                                state.onGoingRideStatus.toValue,
                              ) ==
                              RideStatus.pickedUp &&
                          double.parse(
                                widget.params.ride.tripDetails!.distance!,
                              ) >
                              50) {
                        await _hireDriverCubit.showEnterMeterBottomSheet(
                          onRoute: false,
                          sourceLatLng: driverPosition,
                          destinationLatLng:
                              widget.params.ride.tripSequence![1].position,
                          mutationReason: '',
                          rideID: widget.params.ride.rideId ?? '',
                          userDeviceToken: widget.params.ride.user?.deviceToken,
                          userAmount: widget.params.ride.payment?.amount,
                          userCurrency: widget.params.ride.payment?.currency,
                          userMode: widget.params.ride.payment?.mode,
                          userPaymentStatus: widget.params.ride.payment?.status,
                        );
                      }

                      if (RideStatus.fromString(
                            state.onGoingRideStatus.toValue,
                          ) ==
                          RideStatus.arrivedAtDropOff) {
                        if (double.parse(
                              widget.params.ride.tripDetails!.distance!,
                            ) >
                            50) {
                          await _hireDriverCubit
                              .showEnterReachedMeterBottomSheet(
                                onRoute: false,
                                sourceLatLng: driverPosition,
                                destinationLatLng:
                                    widget
                                        .params
                                        .ride
                                        .tripSequence![1]
                                        .position,
                                mutationReason: '',
                                rideID: widget.params.ride.rideId ?? '',
                                userDeviceToken:
                                    widget.params.ride.user?.deviceToken,
                                userAmount: widget.params.ride.payment?.amount,
                                userCurrency:
                                    widget.params.ride.payment?.currency,
                                userMode: widget.params.ride.payment?.mode,
                                userPaymentStatus:
                                    widget.params.ride.payment?.status,
                              );
                        } else {
                          await _hireDriverCubit.getFinalRideDetails(
                            rideID: widget.params.ride.rideId!,
                            mutationReason: '',
                            userDeviceToken:
                                widget.params.ride.user?.deviceToken ?? '',
                            userAmount: widget.params.ride.payment?.amount,
                            userCurrency: widget.params.ride.payment?.currency,
                            userMode: widget.params.ride.payment?.mode,
                            userPaymentStatus:
                                widget.params.ride.payment?.status,
                          );
                        }
                      }

                      if (RideStatus.fromString(
                            state.onGoingRideStatus.toValue,
                          ) !=
                          RideStatus.arrivedAtDropOff) {
                        final isSuccess = await _hireDriverCubit
                            .onGoingTripMutateRide(
                              mutationReason: '',
                              rideID: widget.params.ride.rideId ?? '',
                              userDeviceToken:
                                  widget.params.ride.user?.deviceToken,
                              userAmount: widget.params.ride.payment?.amount,
                              userCurrency:
                                  widget.params.ride.payment?.currency,
                              userMode: widget.params.ride.payment?.mode,
                              userPaymentStatus:
                                  widget.params.ride.payment?.status,
                              countyCode:
                                  widget
                                      .params
                                      .ride
                                      .tripSequence![0]
                                      .countryCode ??
                                  "",
                              phoneNumber:
                                  widget
                                      .params
                                      .ride
                                      .tripSequence![0]
                                      .phoneNumber ??
                                  "",
                            );

                        if (RideStatus.fromString(
                              state.onGoingRideStatus.toValue,
                            ) ==
                            RideStatus.delivered) {
                          if (isSuccess == true) {
                            // _homeCubit.emitState(
                            //   GetTripSettlementAmount(
                            //     currency: widget.params.ride.price?.currency ?? "",
                            //     settlementAmount:
                            //         (widget.params.ride.price?.totalPrice ?? 0)
                            //             .toString(),
                            //     pickupAddress:
                            //         widget.params.ride.tripSequence?[0].address ??
                            //             "",
                            //     dropupAddress:
                            //         widget.params.ride.tripSequence?[1].address ??
                            //             "",
                            //   ),
                            // );

                            // AnywhereDoor.pushReplacementNamed(context,
                            //     routeName: RouteName.homeScreen);
                          }
                        }
                        // if (RideStatus.fromString(
                        //         state.onGoingRideStatus.toValue) ==
                        //     RideStatus.pickedUp) {
                        //   await _hireDriverCubit.getDistanceMatrix(
                        //     onRoute: false,
                        //     sourceLatLng: driverPosition,
                        //     destinationLatLng:
                        //         widget.params.ride.tripSequence![1].position,
                        //   );
                        // }
                      }
                    },
                    refreshTap: () async {
                      await _hireDriverCubit.getDistanceMatrix(
                        onRoute: onRoute,
                        sourceLatLng: driverPosition,
                        destinationLatLng:
                            widget
                                .params
                                .ride
                                .tripSequence![(_hireDriverCubit
                                                .state
                                                .onGoingRideStatus ==
                                            RideStatus.started ||
                                        _hireDriverCubit
                                                .state
                                                .onGoingRideStatus ==
                                            RideStatus.arrivedAtPickup)
                                    ? 0
                                    : 1]
                                .position,
                      );
                    },
                    // isArrivedAtDropUp: isArrivedAtDropUp,
                    // isArrived: isArrived,
                    // currentSequence:
                    //     widget.params.ride.tripSequence?[rideSequence].type ==
                    //             LocationRideType.pickup.getLocationRideTypeString
                    //         ? pickupSequence
                    //         : dropSequence,
                    // onConfirmation: () async {
                    //   if (widget.params.ride.tripSequence?[rideSequence].type ==
                    //       LocationRideType.dropoff.getLocationRideTypeString) {
                    //     final isSuccess =
                    //         await _hireDriverCubit.mutateHireDriverRides(
                    //       rideStatus: RideStatus.delivered,
                    //       mutationReason: '',
                    //       userDeviceToken:
                    //           widget.params.ride.user?.deviceToken ?? '',
                    //       userAmount: widget.params.ride.payment?.amount ?? '',
                    //       userCurrency:
                    //           widget.params.ride.payment?.currency ?? '',
                    //       userMode: widget.params.ride.payment?.mode ?? '',
                    //       userPaymentStatus:
                    //           widget.params.ride.payment?.status ?? '',
                    //       rideID: widget.params.ride.rideId ?? '',
                    //     );
                    //     setState(() {});
                    //     if (isSuccess == true) {
                    //       _homeCubit.emitState(
                    //         GetTripSettlementAmount(
                    //           currency: widget.params.ride.price?.currency ?? "",
                    //           settlementAmount:
                    //               (widget.params.ride.price?.totalPrice ?? 0)
                    //                   .toString(),
                    //           pickupAddress:
                    //               widget.params.ride.tripSequence?[0].address ??
                    //                   "",
                    //           dropupAddress:
                    //               widget.params.ride.tripSequence?[1].address ??
                    //                   "",
                    //         ),
                    //       );
                    //     }
                    //   } else if (widget
                    //           .params.ride.tripSequence?[rideSequence].type ==
                    //       LocationRideType.pickup.getLocationRideTypeString) {
                    //     // await _hireDriverCubit.showEnterMeterBottomSheet();
                    //
                    //     await _hireDriverCubit.mutateHireDriverRides(
                    //       rideStatus: widget.params.ride
                    //                   .tripSequence?[rideSequence].type ==
                    //               LocationRideType
                    //                   .pickup.getLocationRideTypeString
                    //           ? RideStatus.pickedUp
                    //           : RideStatus.delivered,
                    //       mutationReason: '',
                    //       rideID: widget.params.ride.rideId ?? '',
                    //     );
                    //   }
                    //   // {
                    //   //      await _hireDriverCubit.mutateHireDriverRides(
                    //   //        rideStatus: widget.params.ride
                    //   //                    .tripSequence?[rideSequence].type ==
                    //   //                LocationRideType
                    //   //                    .pickup.getLocationRideTypeString
                    //   //            ? RideStatus.pickedUp
                    //   //            : RideStatus.delivered,
                    //   //        mutationReason: '',
                    //   //        rideID: widget.params.ride.rideId ?? '',
                    //   //      );
                    //   //    }
                    // },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> callBackgroundApis() async {
    onRoute =
        _googleMapWidgetStateKey.currentState?.isDriverOnroute(
          LatLng(driverPosition.latitude, driverPosition.longitude),
        ) ??
        false;
    await _hireDriverCubit.getDistanceMatrix(
      onRoute: onRoute,
      sourceLatLng: driverPosition,
      destinationLatLng:
          widget
              .params
              .ride
              .tripSequence![(_hireDriverCubit.state.onGoingRideStatus ==
                          RideStatus.started ||
                      _hireDriverCubit.state.onGoingRideStatus ==
                          RideStatus.arrivedAtPickup)
                  ? 0
                  : 1]
              .position,
    );

    //TODO remove static driver id
    // await _hireDriverCubit.mutateHireDriverRides(
    //   rideID: widget.params.ride.rideId ?? '',
    //   rideStatus: RideStatus.ontrip,
    //   mutationReason: '',
    // );
  }
}
