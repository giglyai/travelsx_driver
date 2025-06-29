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
  bool isMapLoaded = false;
  String? rideType;
  bool isReturnTrip = false;

  bool get hasReturnTrip {
    return widget.params.ride.rideType == "return" ||
        (widget.params.ride.tripSequence?.any(
              (sequence) =>
                  sequence.type == "pickup_re" || sequence.type == "dropoff_re",
            ) ??
            false);
  }

  int getCurrentSequenceIndex() {
    final currentStatus =
        _hireDriverCubit.state.onGoingRideStatus ?? RideStatus.started;
    if (rideSequence == 0) {
      if (currentStatus == RideStatus.started ||
          currentStatus == RideStatus.arrivedAtPickup) {
        return 0; // First pickup
      } else if (currentStatus == RideStatus.pickedUp ||
          currentStatus == RideStatus.arrivedAtDropOff) {
        return 1; // First dropoff
      }
    } else if (rideSequence == 2) {
      if (currentStatus == RideStatus.returnTrip ||
          currentStatus == RideStatus.arrivedAtPickup) {
        return 2; // Return pickup
      } else if (currentStatus == RideStatus.pickedUp ||
          currentStatus == RideStatus.arrivedAtDropOff) {
        return 3; // Return dropoff
      }
    }
    return 0; // Default to first pickup
  }

  bool shouldShowReturnButton() {
    final currentStatus =
        _hireDriverCubit.state.onGoingRideStatus ?? RideStatus.started;
    return widget.params.ride.rideType == "return" &&
        currentStatus == RideStatus.arrivedAtDropOff &&
        rideSequence == 1;
  }

  bool shouldCallFinalAPI() {
    final currentStatus =
        _hireDriverCubit.state.onGoingRideStatus ?? RideStatus.started;
    if (widget.params.ride.rideType != "return") {
      return currentStatus == RideStatus.arrivedAtDropOff && rideSequence == 1;
    } else {
      return currentStatus == RideStatus.arrivedAtDropOff && rideSequence == 3;
    }
  }

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _hireDriverCubit = BlocProvider.of<HireDriverCubit>(context);
    _hireDriverCubit.flushData();
    WidgetsBinding.instance.addObserver(this);

    rideType = widget.params.ride.rideType;
    isReturnTrip = hasReturnTrip;

    if (widget.params.ride.userMessage == "RETURNED") {
      rideSequence = 2;
    } else if (widget.params.ride.userMessage == "REACHED" && hasReturnTrip) {
      rideSequence = 1;
    }

    if (widget.params.ride.userMessage == "REACHED" && shouldCallFinalAPI()) {
      _hireDriverCubit.getFinalRideDetails(
        rideID: widget.params.ride.rideId ?? "",
        mutationReason: '',
        userDeviceToken: widget.params.ride.user?.deviceToken,
        userAmount: widget.params.ride.payment?.amount,
        userCurrency: widget.params.ride.payment?.currency,
        userMode: widget.params.ride.payment?.mode,
        userPaymentStatus: widget.params.ride.payment?.status,
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
        sourceLatLng: driverPosition,
        destinationLatLng:
            widget
                .params
                .ride
                .tripSequence![getCurrentSequenceIndex()]
                .position,
      );
    });

    super.initState();
  }

  void gotoNextSequence() {
    final currentStatus =
        _hireDriverCubit.state.onGoingRideStatus ?? RideStatus.started;
    if (currentStatus == RideStatus.pickedUp) {
      if (rideSequence == 0) {
        rideSequence = 1; // First dropoff
      } else if (rideSequence == 2) {
        rideSequence = 3; // Return dropoff
      }
      _hireDriverCubit.updateRideStatus(RideStatus.arrivedAtDropOff);
      if (rideSequence < widget.params.ride.tripSequence!.length) {
        _hireDriverCubit.getDistanceMatrix(
          onRoute: false,
          sourceLatLng: driverPosition,
          destinationLatLng:
              widget.params.ride.tripSequence![rideSequence].position,
        );
      }
    }
  }

  void initiateReturnTrip() {
    if (widget.params.ride.rideType == "return") {
      rideSequence = 2;
      _hireDriverCubit.updateRideStatus(RideStatus.returnTrip);
      _hireDriverCubit.getDistanceMatrix(
        onRoute: false,
        sourceLatLng: driverPosition,
        destinationLatLng: widget.params.ride.tripSequence![2].position,
      );
    }
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
              BlocListener<HireDriverCubit, HireState>(
                listener: (context, state) {
                  if (state.driverMutateRideStatus == ApiStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Something went wrong"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<HireDriverCubit, HireState>(
                  builder: (context, state) {
                    final currentStatus =
                        state.onGoingRideStatus ?? RideStatus.started;

                    // Update map when distance matrix is available
                    if (state.distanceMatrixStatus.success &&
                        state.distanceMatrix?.routePath != null) {
                      _googleMapWidgetStateKey.currentState
                          ?.setNavigationRouteForRide(
                            markerDirection: markerDirection,
                            state.distanceMatrix?.routePath,
                            driverLocation: driverPosition,
                            destination:
                                widget
                                    .params
                                    .ride
                                    .tripSequence![getCurrentSequenceIndex()]
                                    .position,
                            type:
                                widget
                                    .params
                                    .ride
                                    .tripSequence![getCurrentSequenceIndex()]
                                    .type,
                          );
                      distanceMatrix = state.distanceMatrix;
                      isMapLoaded = true;
                    }

<<<<<<< HEAD
                    return HireDraggableRideCardScreen(
                      status: currentStatus,
                      isLoading: state.driverMutateRideStatus.isLoading,
                      rideSequence:
                          widget
                              .params
                              .ride
                              .tripSequence?[getCurrentSequenceIndex()],
                      distanceMatrix: distanceMatrix,
                      showReturnButton: shouldShowReturnButton(),
                      onReturn: initiateReturnTrip,
                      rideType: widget.params.ride.rideType,
                      onArrival: () async {
                        final tripDistance =
                            double.tryParse(
                              widget.params.ride.tripDetails?.distance ?? "0",
                            ) ??
                            0;
=======
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
                              3) {
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
>>>>>>> parent of cb83ec3 (updated)

                        if (currentStatus == RideStatus.started ||
                            currentStatus == RideStatus.returnTrip) {
                          await _hireDriverCubit.onGoingTripMutateRide(
                            mutationReason: '',
                            rideID: widget.params.ride.rideId ?? '',
                            userDeviceToken:
                                widget.params.ride.user?.deviceToken,
                            userAmount: widget.params.ride.payment?.amount,
                            userCurrency: widget.params.ride.payment?.currency,
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
                        } else if (currentStatus ==
                            RideStatus.arrivedAtPickup) {
                          if (tripDistance > 3) {
                            await _hireDriverCubit.showEnterMeterBottomSheet(
                              onRoute: false,
                              sourceLatLng: driverPosition,
                              destinationLatLng:
                                  widget
                                      .params
                                      .ride
                                      .tripSequence![rideSequence]
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
                            await _hireDriverCubit.onGoingTripMutateRide(
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
                          }
                        } else if (currentStatus == RideStatus.pickedUp) {
                          gotoNextSequence();
                          if (shouldCallFinalAPI()) {
                            if (tripDistance > 3) {
                              await _hireDriverCubit
                                  .showEnterReachedMeterBottomSheet(
                                    onRoute: false,
                                    sourceLatLng: driverPosition,
                                    destinationLatLng:
                                        widget
                                            .params
                                            .ride
                                            .tripSequence![rideSequence]
                                            .position,
                                    mutationReason: '',
                                    rideID: widget.params.ride.rideId ?? '',
                                    userDeviceToken:
                                        widget.params.ride.user?.deviceToken,
                                    userAmount:
                                        widget.params.ride.payment?.amount,
                                    userCurrency:
                                        widget.params.ride.payment?.currency,
                                    userMode: widget.params.ride.payment?.mode,
                                    userPaymentStatus:
                                        widget.params.ride.payment?.status,
                                  );
                            } else {
                              await _hireDriverCubit.getFinalRideDetails(
                                rideID: widget.params.ride.rideId ?? '',
                                mutationReason: '',
                                userDeviceToken:
                                    widget.params.ride.user?.deviceToken,
                                userAmount: widget.params.ride.payment?.amount,
                                userCurrency:
                                    widget.params.ride.payment?.currency,
                                userMode: widget.params.ride.payment?.mode,
                                userPaymentStatus:
                                    widget.params.ride.payment?.status,
                              );
<<<<<<< HEAD
                            }
                          }
                        } else if (currentStatus ==
                                RideStatus.arrivedAtDropOff &&
                            shouldCallFinalAPI()) {
                          if (tripDistance > 3) {
                            await _hireDriverCubit
                                .showEnterReachedMeterBottomSheet(
                                  onRoute: false,
                                  sourceLatLng: driverPosition,
                                  destinationLatLng:
                                      widget
                                          .params
                                          .ride
                                          .tripSequence![rideSequence]
                                          .position,
                                  mutationReason: '',
                                  rideID: widget.params.ride.rideId ?? '',
                                  userDeviceToken:
                                      widget.params.ride.user?.deviceToken,
                                  userAmount:
                                      widget.params.ride.payment?.amount,
                                  userCurrency:
                                      widget.params.ride.payment?.currency,
                                  userMode: widget.params.ride.payment?.mode,
                                  userPaymentStatus:
                                      widget.params.ride.payment?.status,
                                );
                          } else {
                            await _hireDriverCubit.getFinalRideDetails(
                              rideID: widget.params.ride.rideId ?? '',
                              mutationReason: '',
                              userDeviceToken:
                                  widget.params.ride.user?.deviceToken,
                              userAmount: widget.params.ride.payment?.amount,
                              userCurrency:
                                  widget.params.ride.payment?.currency,
                              userMode: widget.params.ride.payment?.mode,
                              userPaymentStatus:
                                  widget.params.ride.payment?.status,
                            );
                          }
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
                                  .tripSequence![getCurrentSequenceIndex()]
                                  .position,
                        );
                      },
                    );
                  },
                ),
=======
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
>>>>>>> parent of cb83ec3 (updated)
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
          widget.params.ride.tripSequence![getCurrentSequenceIndex()].position,
    );
  }

  @override
  void dispose() {
    positionStream.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
