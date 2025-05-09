import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelx_driver/home/models/position_data_model.dart'
    as position;
import 'package:travelx_driver/home/models/ride_response_model.dart'
    as ride_model;
import 'package:travelx_driver/shared/utils/utilities.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

import '../../constants/app_colors/app_colors.dart';
import '../../constants/imagePath/image_paths.dart';
import '../../local_storage/user_repository.dart';
import '../circular_button/buttons.dart';
import '../size_config/size_config.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({
    super.key,
    this.onCancel,
    this.isNavigationMap = false,
    this.circle,
  });
  final void Function()? onCancel;
  final bool isNavigationMap;
  final Set<Circle>? circle;

  @override
  //ignore: library_private_types_in_public_api
  GoogleMapWidgetState createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  Completer<GoogleMapController> mapController = Completer();
  final Future<bool> _mapFuture = Future.delayed(
    const Duration(milliseconds: 1000),
    () => true,
  );
  bool isMapVisible = false;

  // GoogleMapPolyline googleMapPolyline =
  //     GoogleMapPolyline(apiKey: "AIzaSyBtDSlrpYHSR41NjrwcYW5dp9_mia0ZFzo");
  // GoogleMapPolyline googleMapPolyline = GoogleMapPolyline(
  //   apiKey: initializeMapApi(),
  // );
  final List<Marker> _markers = [];
  final Set<Polyline> _polyline = {};
  final MarkerId driverMarkerId = const MarkerId('driver');
  late BitmapDescriptor mapMarker;
  static const List<MapType> mapTypes = [
    MapType.normal,
    MapType.hybrid,
    MapType.satellite,
    MapType.terrain,
  ];
  late String _mapStyle;
  late Position driverPosition;
  Future<BitmapDescriptor> getMarkerImage(String path) async {
    ByteData bytes = await rootBundle.load(path);
    return BitmapDescriptor.fromBytes(
      bytes.buffer.asUint8List(),
      size: const Size(50, 50),
    );
  }

  final LatLng _center = LatLng(
    UserRepository.getLat ?? 0,
    UserRepository.getLong ?? 0,
  );

  void _onMapCreated(GoogleMapController controller) async {
    // Check if the map controller is already completed. If not, complete it.
    if (!mapController.isCompleted) {
      mapController.complete(controller);
    }

    // Set the map style.
    await controller.setMapStyle(_mapStyle);

    // Check if the location permission has been granted. If not, request it.
    if (LocationPermission.denied == LocationPermission.denied) {
      await checkPermissions();
    }

    // Notify the state that the map has been created.

    // Wait for 800 milliseconds and then show the map.
    // This gives the map time to load before it is displayed.
    await Future.delayed(const Duration(milliseconds: 800));

    isMapVisible = true;
  }

  void setRouteForRideWithMarkers({
    required position.DriverPosition driverLocation,
    required String? routePath,
    required List<ride_model.TripSequence> rideSequence,
  }) async {
    // Get the GoogleMapController.
    final GoogleMapController controller = await mapController.future;

    // Decode the route path into a list of LatLngs.
    List<LatLng> result = [];
    try {
      result.addAll(
        PolylinePoints()
            .decodePolyline(routePath ?? '')
            .map((e) => LatLng(e.latitude, e.longitude)),
      );
    } catch (e) {
      log(e.toString());
    }

    // Clear the existing polylines and markers.
    _polyline.clear();
    _markers.clear();

    // Add the polyline to the map.
    _polyline.add(
      Polyline(
        polylineId: PolylineId(DateTime.now().toIso8601String()),
        visible: true,
        width: 5,
        points: result,
        color: AppColors.kGreen00996,
      ),
    );

    // Add the markers to the map.
    final dropOffMarker = await getMarkerImage(ImagePath.icDropOff);
    final pickupMarker = await getMarkerImage(ImagePath.icPickup);
    final driverMarker = await getMarkerImage(ImagePath.icCurrentPosition);

    int i = 0;

    // Add the driver marker.
    _markers.add(
      Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(driverLocation.latitude, driverLocation.longitude),
        visible: true,
        icon: driverMarker,
      ),
    );

    // Add the pickup and drop-off markers.
    for (var element in rideSequence) {
      _markers.add(
        Marker(
          markerId: MarkerId((++i).toString()),
          position: LatLng(
            element.position.latitude,
            element.position.longitude,
          ),
          visible: true,
          icon:
              element.type == LocationRideType.pickup
                  ? pickupMarker
                  : dropOffMarker,
        ),
      );
    }

    // Calculate the bounds of the route.
    double minLat = result.first.latitude;
    double minLong = result.first.longitude;
    double maxLat = result.first.latitude;
    double maxLong = result.first.longitude;
    for (var point in result) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLong) minLong = point.longitude;
      if (point.longitude > maxLong) maxLong = point.longitude;
    }

    // Move the camera to the bounds of the route.
    Future.delayed(const Duration(seconds: 1), () {
      controller.moveCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong),
          ),
          18,
        ),
      );
    });

    // Call setState() to update the UI.
    setState(() {});
  }

  void setNavigationRouteForRide(
    String? routePath, {
    required position.DriverPosition driverLocation,
    required position.DriverPosition destination,
    required String? type,
    required double markerDirection,
  }) async {
    // Get the GoogleMapController.

    // Decode the route path into a list of LatLngs.
    List<LatLng> result = [];
    try {
      result.addAll(
        PolylinePoints()
            .decodePolyline(routePath ?? '')
            .map((e) => LatLng(e.latitude, e.longitude)),
      );
    } catch (e) {
      log(e.toString());
    }

    // Clear the existing polylines and markers.
    _polyline.clear();
    _markers.clear();

    // Add the polyline to the map.
    _polyline.add(
      Polyline(
        polylineId: PolylineId(DateTime.now().toIso8601String()),
        visible: true,
        width: 5,
        points: result,
        color: Colors.green,
      ),
    );

    // Add the markers to the map.
    final dropOffMarker = await getMarkerImage(ImagePath.icDropOff);
    final pickupMarker = await getMarkerImage(ImagePath.icPickup);
    final driverMarker = await getMarkerImage(ImagePath.icDriverPosition);

    int i = 0;

    // Add the driver marker.
    _markers.add(
      Marker(
        rotation: markerDirection,
        markerId: driverMarkerId,
        position: LatLng(driverLocation.latitude, driverLocation.longitude),
        visible: true,
        icon: driverMarker,
      ),
    );

    // Add the pickup and drop-off markers.
    _markers.add(
      Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(destination.latitude, destination.longitude),
        visible: true,
        icon:
            type == LocationRideType.pickup.getLocationRideTypeString
                ? pickupMarker
                : dropOffMarker,
      ),
    );

    // Calculate the bounds of the route.
    double minLat = result.first.latitude;
    double minLong = result.first.longitude;
    double maxLat = result.first.latitude;
    double maxLong = result.first.longitude;
    for (var point in result) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLong) minLong = point.longitude;
      if (point.longitude > maxLong) maxLong = point.longitude;
    }

    // Move the camera to the bounds of the route.
    Future.delayed(const Duration(seconds: 1), () async {
      await mapController.future.then(
        (value) => value.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(driverLocation.latitude, driverLocation.longitude),
            18,
          ),
        ),
      );
    });

    // Call setState() to update the UI.
    setState(() {});
  }

  bool isDriverOnroute(LatLng position) {
    // Check if the polyline is empty.
    if (_polyline.isEmpty) {
      return true;
    }

    // Convert the polyline points to LatLng objects.
    List<mp.LatLng> latLngPoints =
        _polyline.first.points
            .map((e) => mp.LatLng(e.latitude, e.longitude))
            .toList();

    // Check if the driver's position is on the polyline.
    return mp.PolygonUtil.isLocationOnPath(
      mp.LatLng(position.latitude, position.longitude),
      latLngPoints,
      false,
      tolerance: 20,
    );
  }

  Future<void> checkPermissions() async {
    // Request location permission.
    final permission = await Geolocator.requestPermission();

    // Check if the user granted location permission.
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // Move the marker to the current position.
      await moveMarkerToCurrentPosition();
    } else {
      // Show a dialog for the Permission Failed screen.
      // ...
    }
  }

  Future<void> moveMarkerToCurrentPosition() async {
    // Get the current location.
    final location = await Utils.getCurrentLocation();

    // Get the map controller.
    final GoogleMapController controller = await mapController.future;

    // Zoom out the camera and move the camera to the current location,
    // both animated.
    await Future.wait([
      controller.animateCamera(CameraUpdate.zoomOut()),
      controller.animateCamera(CameraUpdate.newLatLng(location)),
    ]);

    // Log the current location.
    log(location.toString());
  }

  MapType maptype = MapType.normal;

  toggleMapTypes(MapType currentMapType) {
    int currentIndex = mapTypes.indexOf(currentMapType);
    if (currentIndex == (mapTypes.length - 1)) {
      maptype = mapTypes.first;
    } else {
      maptype = mapTypes[++currentIndex];
    }
    setState(() {});
  }

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
  );
  Future<void> updateDriverMarker(Position position) async {
    // Get the map controller.
    final GoogleMapController controller = await mapController.future;

    // Get the driver marker image.
    final driverMarker = await getMarkerImage(ImagePath.icDriverPosition);

    // Remove the existing driver marker.
    _markers.removeWhere((element) => element.markerId == driverMarkerId);

    // Add a new driver marker at the given position.
    _markers.add(
      Marker(
        rotation: position.heading,
        markerId: driverMarkerId,
        position: LatLng(position.latitude, position.longitude),
        visible: true,
        icon: driverMarker,
      ),
    );

    // Get the polyline.
    final Polyline polyline = _polyline.first;

    // Get the polyline points.
    final List<LatLng> points = polyline.points;

    // Convert the polyline points to LatLng objects.
    List<mp.LatLng> latLangPoints =
        points.map((e) => mp.LatLng(e.latitude, e.longitude)).toList();

    // Get the index of the driver's position on the polyline.
    int currentIndex = mp.PolygonUtil.locationIndexOnPath(
      mp.LatLng(position.latitude, position.longitude),
      latLangPoints,
      false,
      tolerance: 20,
    );

    // Get the remaining polyline points.
    final List<LatLng> remainingPoints = points.sublist(currentIndex);

    // Clear the existing polyline.
    _polyline.clear();

    // Add a new polyline with the remaining points.
    _polyline.add(
      Polyline(
        polylineId: polyline.polylineId,
        visible: true,
        width: 5,
        points: remainingPoints,
        color: Colors.green,
      ),
    );

    // Move the camera to the driver's position, animated.
    await Future.delayed(const Duration(seconds: 1), () async {
      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          18,
        ),
      );
    });

    // Notify the state that the driver marker and polyline have been updated.
    setState(() {});
  }

  Future<void> initializeGoogleMapPolyline() async {
    final apiKey = await initializeMapApi();
    if (apiKey != null && apiKey.isNotEmpty) {
      GoogleMapPolyline(apiKey: apiKey);
    } else {
      throw Exception("Google Maps API key not found in SharedPreferences");
    }
  }

  Future<String?> initializeMapApi() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('google_maps_api_key');
  }

  @override
  void initState() {
    super.initState();
    initializeGoogleMapPolyline();
    rootBundle.loadString('images/map_style.txt').then((string) {
      _mapStyle = string;
    });
    getMarkerImage(ImagePath.icDriverPosition).then((value) {
      mapMarker = value;
    });
  }

  @override
  void dispose() {
    mapController = Completer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          circles: widget.circle ?? {},
          mapType: maptype,
          myLocationEnabled: widget.isNavigationMap ? false : true,
          myLocationButtonEnabled: false,
          onMapCreated: _onMapCreated,
          markers: Set.from(_markers),
          zoomControlsEnabled: false,
          polylines: _polyline,
          initialCameraPosition: CameraPosition(target: _center, zoom: 16),
        ),
        if (widget.onCancel != null)
          Positioned(
            top: 30 * SizeConfig.heightMultiplier!,
            right: 30 * SizeConfig.widthMultiplier!,
            child: CircularIconButton(
              svgIconPath: ImagePath.icCancel,
              onTap: widget.onCancel,
            ),
          ),
        Positioned(
          bottom: 110 * SizeConfig.heightMultiplier!,
          right: 30 * SizeConfig.widthMultiplier!,
          child:
              widget.isNavigationMap
                  ? CircularIconButton(
                    svgIconPath: ImagePath.icCurrentLocation,
                    onTap: () async {
                      await moveMarkerToCurrentPosition();
                    },
                  )
                  : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularIconButton(
                        svgIconPath: ImagePath.icMapView,
                        onTap: () {
                          toggleMapTypes(maptype);
                        },
                      ),
                      SizedBox(height: 10 * SizeConfig.heightMultiplier!),
                      CircularIconButton(
                        svgIconPath: ImagePath.icCurrentLocation,
                        onTap: () async {
                          await moveMarkerToCurrentPosition();
                        },
                      ),
                    ],
                  ),
        ),
      ],
    );
  }
  // return FutureBuilder<bool>(
  //   future: _mapFuture,
  //   builder: (context, AsyncSnapshot<bool> snapshot) {
  //     if (!snapshot.hasData) {
  //       return Stack(
  //         children: [
  //           GoogleMap(
  //             mapType: maptype,
  //             markers: Set.from(_markers),
  //             initialCameraPosition: CameraPosition(
  //               target: _center,
  //               zoom: 16,
  //             ),
  //           ),
  //           if (widget.onCancel != null)
  //             Positioned(
  //               top: 30 * SizeConfig.heightMultiplier!,
  //               right: 30 * SizeConfig.widthMultiplier!,
  //               child: CircularIconButton(
  //                 svgIconPath: ImagePath.icCancel,
  //                 onTap: widget.onCancel,
  //               ),
  //             ),
  //           Positioned(
  //             bottom: 110 * SizeConfig.heightMultiplier!,
  //             right: 30 * SizeConfig.widthMultiplier!,
  //             child: widget.isNavigationMap
  //                 ? CircularIconButton(
  //                     svgIconPath: ImagePath.icCurrentLocation,
  //                     onTap: () async {
  //                       await moveMarkerToCurrentPosition();
  //                     },
  //                   )
  //                 : Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       CircularIconButton(
  //                         svgIconPath: ImagePath.icMapView,
  //                         onTap: () {
  //                           toggleMapTypes(maptype);
  //                         },
  //                       ),
  //                       SizedBox(
  //                         height: 10 * SizeConfig.heightMultiplier!,
  //                       ),
  //                       CircularIconButton(
  //                         svgIconPath: ImagePath.icCurrentLocation,
  //                         onTap: () async {
  //                           await moveMarkerToCurrentPosition();
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //           ),
  //         ],
  //       );
  //     }

  // );

  //}
}
