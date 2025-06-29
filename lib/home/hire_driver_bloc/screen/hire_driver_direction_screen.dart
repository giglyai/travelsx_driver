import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:geolocator/geolocator.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/home/hire_driver_bloc/cubit/hire_driver_cubit.dart';
import 'package:travelx_driver/home/hire_driver_bloc/entity/upcoming_ontrip_ride_res.dart';
import 'package:travelx_driver/home/hire_driver_bloc/screen/draggble_hire_direction_screen.dart';
import 'package:travelx_driver/home/models/distance_matrix_model.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/local_storage/log_in_status.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:travelx_driver/shared/widgets/google_map/google-map.widget.dart';

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
    switch (currentStatus) {
      case RideStatus.started:
      case RideStatus.arrivedAtPickup:
        return isReturnTrip ? 2 : 0; // pickup_re or pickup
      case RideStatus.pickedUp:
      case RideStatus.arrivedAtDropOff:
        return isReturnTrip ? 3 : 1; // dropoff_re or dropoff
      default:
        return 0;
    }
  }

  bool shouldShowReturnButton() {
    final currentStatus =
        _hireDriverCubit.state.onGoingRideStatus ?? RideStatus.started;
    final currentSequence =
        widget.params.ride.tripSequence![getCurrentSequenceIndex()];
    return widget.params.ride.rideType == "return" &&
        currentSequence.type == 'dropoff' &&
        currentStatus == RideStatus.arrivedAtDropOff &&
        !isReturnTrip;
  }

  bool shouldCallFinalAPI() {
    final currentStatus =
        _hireDriverCubit.state.onGoingRideStatus ?? RideStatus.started;
    final currentSequence =
        widget.params.ride.tripSequence![getCurrentSequenceIndex()];
    return (currentStatus == RideStatus.arrivedAtDropOff &&
        (currentSequence.type == 'dropoff' && !isReturnTrip ||
            currentSequence.type == 'dropoff_re' && isReturnTrip));
  }

  void gotoNextSequence() {
    final currentStatus =
        _hireDriverCubit.state.onGoingRideStatus ?? RideStatus.started;
    final currentSequence = widget.params.ride.tripSequence![rideSequence];
    if (currentStatus == RideStatus.arrivedAtDropOff &&
        widget.params.ride.rideType == "return" &&
        currentSequence.type == 'dropoff') {
      rideSequence = 2; // Move to pickup_re
      isReturnTrip = true;
      _hireDriverCubit.updateRideStatus(RideStatus.started);
    } else if (currentStatus == RideStatus.arrivedAtDropOff &&
        currentSequence.type == 'dropoff_re') {
      _hireDriverCubit.updateRideStatus(RideStatus.delivered);
    } else if (currentStatus == RideStatus.pickedUp ||
        currentStatus == RideStatus.arrivedAtDropOff) {
      rideSequence += 1;
      if (rideSequence < widget.params.ride.tripSequence!.length) {
        _hireDriverCubit.updateRideStatus(
          rideSequence == 1 ? RideStatus.started : RideStatus.arrivedAtPickup,
        );
      }
    }
    if (rideSequence < widget.params.ride.tripSequence!.length) {
      _hireDriverCubit.getDistanceMatrix(
        onRoute: false,
        sourceLatLng: driverPosition,
        destinationLatLng:
            widget.params.ride.tripSequence![rideSequence].position,
      );
    }
  }

  void initiateReturnTrip() async {
    final tripSeq = widget.params.ride.tripSequence?[getCurrentSequenceIndex()];
    await _hireDriverCubit.onGoingTripMutateRide(
      mutationReason: 'Starting Return Trip',
      rideID: widget.params.ride.rideId ?? '',
      userDeviceToken: widget.params.ride.user?.deviceToken,
      userAmount: widget.params.ride.payment?.amount,
      userCurrency: widget.params.ride.payment?.currency,
      userMode: widget.params.ride.payment?.mode,
      userPaymentStatus: widget.params.ride.payment?.status,
      countryCode: tripSeq?.countryCode ?? '',
      phoneNumber: tripSeq?.phoneNumber ?? '',
      sequenceType: tripSeq?.type,
      rideType: widget.params.ride.rideType,
    );
  }

  @override
  void initState() {
    super.initState();

    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _hireDriverCubit = BlocProvider.of<HireDriverCubit>(context);

    _hireDriverCubit.flushData();
    WidgetsBinding.instance.addObserver(this);

    rideType = widget.params.ride.rideType;
    isReturnTrip = false; // Start with no return trip

    // Set initial rideSequence and status
    if (widget.params.ride.rideStatus == "PICKEDUP") {
      rideSequence = 1; // First dropoff
      _hireDriverCubit.updateRideStatus(RideStatus.pickedUp);
    } else if (widget.params.ride.userMessage == "RETURNED") {
      rideSequence = 3; // Return dropoff
      isReturnTrip = true;
      _hireDriverCubit.updateRideStatus(RideStatus.arrivedAtDropOff);
    } else if (widget.params.ride.userMessage == "REACHED") {
      rideSequence = 1; // First dropoff
      _hireDriverCubit.updateRideStatus(RideStatus.arrivedAtDropOff);
    } else if (widget.params.ride.userMessage == "ARRIVED") {
      rideSequence = 0; // First pickup
      _hireDriverCubit.updateRideStatus(RideStatus.arrivedAtPickup);
    } else {
      rideSequence = 0; // First pickup
      _hireDriverCubit.updateRideStatus(RideStatus.started);
    }

    print(
      "initState: USER_MESSAGE=${widget.params.ride.userMessage}, RIDE_STATUS=${widget.params.ride.rideStatus}, HAS_RETURN_TRIP=$hasReturnTrip, RIDE_SEQUENCE=$rideSequence",
    );

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

    Future.delayed(const Duration(milliseconds: 500), () async {
      try {
        final LatLng current = await Utils.getCurrentLocation();
        driverPosition = DriverPosition(
          latitude: current.latitude,
          longitude: current.longitude,
        );

        positionStream = loc.Geolocator.getPositionStream(
          locationSettings: locationSettings,
        ).listen((loc.Position position) {
          if (isMapLoaded) {
            _googleMapWidgetStateKey.currentState?.updateDriverMarker(position);
            _hireDriverCubit.getDistanceMatrix(
              onRoute: onRoute,
              sourceLatLng: DriverPosition(
                latitude: position.latitude,
                longitude: position.longitude,
              ),
              destinationLatLng:
                  widget.params.ride.tripSequence![rideSequence].position,
            );
          }
        });
      } catch (error) {
        print('Error getting location: $error');
      }
    });

    if (widget.params.ride.userMessage == "RIDEOTPVERIFIED") {
      _hireDriverCubit.updateRideStatus(RideStatus.arrivedAtPickup);
    }

    _homeCubit.postUserCurrentLocation();

    Future.delayed(const Duration(seconds: 1), () {
      final currentSequence =
          widget.params.ride.tripSequence![getCurrentSequenceIndex()];
      _hireDriverCubit.getDistanceMatrix(
        onRoute: false,
        sourceLatLng: driverPosition,
        destinationLatLng: currentSequence.position,
      );
    });
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
                    final currentSequenceIndex = getCurrentSequenceIndex();
                    final currentSequence =
                        widget.params.ride.tripSequence![currentSequenceIndex];

                    if (state.distanceMatrixStatus.success &&
                        state.distanceMatrix?.routePath != null) {
                      String? routePath;
                      if (currentSequence.type == 'pickup') {
                        routePath =
                            widget.params.ride.tripSequence![0].routeOneway;
                      } else if (currentSequence.type == 'dropoff') {
                        routePath =
                            widget.params.ride.tripSequence![1].routeOneway;
                      } else if (currentSequence.type == 'pickup_re') {
                        routePath =
                            widget.params.ride.tripSequence![2].routeReturn;
                      } else if (currentSequence.type == 'dropoff_re') {
                        routePath =
                            widget.params.ride.tripSequence![3].routeReturn;
                      }

                      _googleMapWidgetStateKey.currentState
                          ?.setNavigationRouteForRide(
                            routePath ?? state.distanceMatrix?.routePath,
                            markerDirection: markerDirection,
                            driverLocation: driverPosition,
                            destination: currentSequence.position,
                            type: currentSequence.type,
                          );
                      distanceMatrix = state.distanceMatrix;
                      isMapLoaded = true;
                    }

                    return HireDraggableRideCardScreen(
                      status: currentStatus,
                      isLoading: state.driverMutateRideStatus.isLoading,
                      rideSequence: currentSequence,
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
                        final currentStatus =
                            _hireDriverCubit.state.onGoingRideStatus ??
                            RideStatus.started;
                        final sequenceIndex = getCurrentSequenceIndex();
                        final tripSeq =
                            widget.params.ride.tripSequence?[sequenceIndex];

                        if (shouldShowReturnButton() &&
                            tripSeq?.type == 'dropoff') {
                          initiateReturnTrip();
                          return;
                        }

                        switch (currentStatus) {
                          case RideStatus.started:
                          case RideStatus.returnTrip:
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
                              countryCode: tripSeq?.countryCode ?? '',
                              phoneNumber: tripSeq?.phoneNumber ?? '',
                              sequenceType: tripSeq?.type,
                              rideType: widget.params.ride.rideType,
                            );
                            break;
                          case RideStatus.arrivedAtPickup:
                            if (tripDistance > 3 &&
                                (sequenceIndex == 0 || sequenceIndex == 2)) {
                              await _hireDriverCubit.showEnterMeterBottomSheet(
                                onRoute: false,
                                sourceLatLng: driverPosition,
                                destinationLatLng: tripSeq!.position,
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
                                countryCode: tripSeq?.countryCode ?? '',
                                phoneNumber: tripSeq?.phoneNumber ?? '',
                                sequenceType: tripSeq?.type,
                                rideType: widget.params.ride.rideType,
                              );
                            }
                            break;
                          case RideStatus.pickedUp:
                            await _hireDriverCubit.onGoingTripMutateRide(
                              mutationReason: 'Reached drop location',
                              rideID: widget.params.ride.rideId ?? '',
                              userDeviceToken:
                                  widget.params.ride.user?.deviceToken,
                              userAmount: widget.params.ride.payment?.amount,
                              userCurrency:
                                  widget.params.ride.payment?.currency,
                              userMode: widget.params.ride.payment?.mode,
                              userPaymentStatus:
                                  widget.params.ride.payment?.status,
                              countryCode: tripSeq?.countryCode ?? '',
                              phoneNumber: tripSeq?.phoneNumber ?? '',
                              sequenceType: tripSeq?.type,
                              rideType: widget.params.ride.rideType,
                            );
                            gotoNextSequence();
                            break;
                          case RideStatus.arrivedAtDropOff:
                            gotoNextSequence();
                            if (shouldCallFinalAPI()) {
                              if (tripDistance > 3) {
                                await _hireDriverCubit
                                    .showEnterReachedMeterBottomSheet(
                                      onRoute: false,
                                      sourceLatLng: driverPosition,
                                      destinationLatLng: tripSeq!.position,
                                      mutationReason: '',
                                      rideID: widget.params.ride.rideId ?? '',
                                      userDeviceToken:
                                          widget.params.ride.user?.deviceToken,
                                      userAmount:
                                          widget.params.ride.payment?.amount,
                                      userCurrency:
                                          widget.params.ride.payment?.currency,
                                      userMode:
                                          widget.params.ride.payment?.mode,
                                      userPaymentStatus:
                                          widget.params.ride.payment?.status,
                                    );
                              } else {
                                await _hireDriverCubit.getFinalRideDetails(
                                  rideID: widget.params.ride.rideId ?? '',
                                  mutationReason: '',
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
                              }
                            }
                            break;
                          default:
                            break;
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
