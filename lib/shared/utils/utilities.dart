import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors/app_colors.dart';
import '../widgets/size_config/size_config.dart';

class Utils {
  static Future<LatLng> getCurrentLocation() async {
    await Geolocator.checkPermission();
    bool getData = await Geolocator.isLocationServiceEnabled();
    if (getData == false) {
      await Geolocator.openLocationSettings();
    }
    Position currentPosition =
        await Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
    return LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  static Future<void> openDirections({required LatLng destination}) async {
    final Uri uri = Uri.parse(
        'google.navigation:q=${destination.latitude}, ${destination.longitude}&travelmode=driving&dir_action=navigate');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else if (Platform.isIOS) {
      String urlAppleMaps =
          'https://maps.apple.com/?q=${destination.latitude},${destination.longitude}';
      if (await canLaunchUrl(Uri.parse(urlAppleMaps))) {
        await launchUrl(Uri.parse(urlAppleMaps));
      } else {
        throw 'Could not launch';
      }
    } else {
      throw 'Unable to Launch Maps';
    }
  }

  static Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  static title({String? title, required bool isSelected}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            left: 20 * SizeConfig.widthMultiplier!,
            right: 20 * SizeConfig.widthMultiplier!,
            bottom: 2 * SizeConfig.heightMultiplier!),
        child: Container(
          decoration: BoxDecoration(
              color:
                  isSelected == true ? AppColors.kRedD32F2F : AppColors.kWhite),
          child: Padding(
            padding: EdgeInsets.only(
                top: 12 * SizeConfig.heightMultiplier!,
                bottom: 12 * SizeConfig.heightMultiplier!),
            child: Center(
              child: Text(
                title ?? "",
                style: TextStyle(
                  color: isSelected == true
                      ? AppColors.kWhite
                      : AppColors.kBlackTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * SizeConfig.textMultiplier!,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension NumberFormat on num? {
  String toOrdinal() {
    switch ((this ?? 0) % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}

enum LocationType { pickup, dropoff }

enum LocationRideType { pickup, dropoff }

extension LocationTypeString on LocationType {
  String get getLocationTypeString {
    switch (this) {
      case LocationType.pickup:
        return 'pickup';
      case LocationType.dropoff:
        return 'dropoff';
    }
  }
}

extension LocationRideTypeString on LocationRideType {
  String get getLocationRideTypeString {
    switch (this) {
      case LocationRideType.pickup:
        return 'pickup';
      case LocationRideType.dropoff:
        return 'dropoff';
    }
  }
}

enum DeliveryStatus {
  accepted,
  declined,
  unresponsive,
  arrivedAtPickup,
  pickedUp,
  arrivedAtDropOff,
  delivered,
  ontrip
}

enum SelectRideType {
  all,
  oneWay,
  round,
  package,
  tour,
}

extension SelectRideTypeExtension on SelectRideType? {
  String get toValue {
    switch (this) {
      case SelectRideType.all:
        return 'all';
      case SelectRideType.oneWay:
        return 'oneway';
      case SelectRideType.round:
        return 'return';
      case SelectRideType.package:
        return 'package';
      case SelectRideType.tour:
        return 'tour';
      case null:
        return 'all';
    }
  }

  String get toName {
    switch (this) {
      case SelectRideType.all:
        return 'All';
      case SelectRideType.oneWay:
        return 'Oneway';
      case SelectRideType.round:
        return 'Return';
      case SelectRideType.package:
        return 'Package';
      case SelectRideType.tour:
        return 'Tour';
      case null:
        return 'all';
    }
  }

  List<SelectRideType> get getAll {
    return [
      SelectRideType.all,
      SelectRideType.oneWay,
      SelectRideType.round,
      SelectRideType.package,
      SelectRideType.tour,
    ];
  }
}

enum SelectRideAvailable {
  nearMe,
  upTo50KM,
  upTo100KM,

  upTo500KM,
  upTo1000KM,
}

extension SelectRideAvailableExtension on SelectRideAvailable? {
  String get toValue {
    switch (this) {
      case SelectRideAvailable.nearMe:
        return '30';
      case SelectRideAvailable.upTo50KM:
        return '50';
      case SelectRideAvailable.upTo100KM:
        return '100';

      case SelectRideAvailable.upTo500KM:
        return '500';
      case SelectRideAvailable.upTo1000KM:
        return '1000';
      case null:
        return '30';
    }
  }

  String get toName {
    switch (this) {
      case SelectRideAvailable.nearMe:
        return 'Near Me';
      case SelectRideAvailable.upTo50KM:
        return 'Upto 50 KM';
      case SelectRideAvailable.upTo100KM:
        return 'Upto 100 KM';

      case SelectRideAvailable.upTo500KM:
        return 'Upto 500 KM';
      case SelectRideAvailable.upTo1000KM:
        return 'Upto 1000 KM';
      case null:
        return 'Near Me';
    }
  }

  List<SelectRideAvailable> get getAll {
    return [
      SelectRideAvailable.nearMe,
      SelectRideAvailable.upTo50KM,
      SelectRideAvailable.upTo100KM,
      SelectRideAvailable.upTo500KM,
      SelectRideAvailable.upTo1000KM,
    ];
  }
}

enum RideStatus {
  none,
  accepted,
  declined,
  unresponsive,
  arrivedAtPickup,
  pickedUp,
  arrivedAtDropOff,
  delivered,
  ontrip,
  cancel,
  started;

  // static RideStatus fromString(String? status) {
  //   switch (status) {
  //     case 'ARRIVED':
  //       return RideStatus.arrivedAtPickup;
  //     case 'PICKEDUP':
  //       return RideStatus.pickedUp;
  //     case 'REACHED':
  //       return RideStatus.arrivedAtDropOff;
  //     case 'COMPLETED':
  //       return RideStatus.delivered;
  //     default:
  //       return RideStatus.started;
  //   }
  // }
  static RideStatus fromString(String? status) {
    switch (status) {
      case 'ARRIVED':
        return RideStatus.arrivedAtPickup;
      case 'PICKEDUP':
        return RideStatus.pickedUp;
      case 'REACHED':
        return RideStatus.arrivedAtDropOff;
      case 'COMPLETED':
        return RideStatus.delivered;
      default:
        return RideStatus.started;
    }
  }
}

enum DriverStatus {
  online,
  offline,
  onTrip,
}

enum EarningActivity {
  today,
  yesterday,
  thisWeek,
  thisMonth,
  lastweek,
  lastmonth
}

extension EarningActivityString on EarningActivity {
  String get getEarningActivityString {
    switch (this) {
      case EarningActivity.today:
        return 'Today';
      case EarningActivity.yesterday:
        return 'Yesterday';
      case EarningActivity.thisWeek:
        return 'This Week';
      case EarningActivity.thisMonth:
        return 'This Month';
      case EarningActivity.lastmonth:
        return 'Last Month';
      case EarningActivity.lastweek:
        return 'Last Week';
    }
  }
}

extension DeliveryStatusString on DeliveryStatus {
  String get getDeliveryStatusString {
    switch (this) {
      case DeliveryStatus.accepted:
        return 'ACCEPTED';
      case DeliveryStatus.declined:
        return 'DECLINED';
      case DeliveryStatus.unresponsive:
        return 'UNRESPONSIVE';
      case DeliveryStatus.arrivedAtPickup:
        return 'ARRIVED_AT_PICKUP';
      case DeliveryStatus.pickedUp:
        return 'PICKEDUP';
      case DeliveryStatus.arrivedAtDropOff:
        return 'ARRIVED_AT_DROPOFF';
      case DeliveryStatus.delivered:
        return 'DELIVERED';
      case DeliveryStatus.ontrip:
        return 'ON_TRIP';
    }
  }
}

extension RideStatusString on RideStatus? {
  String get getRideStatusString {
    switch (this) {
      case RideStatus.none:
        return 'None';
      case RideStatus.accepted:
        return 'ACCEPTED';
      case RideStatus.declined:
        return 'DECLINED';
      case RideStatus.unresponsive:
        return 'UNRESPONSIVE';
      case RideStatus.arrivedAtPickup:
        return 'ARRIVED_AT_PICKUP';
      case RideStatus.pickedUp:
        return 'PICKEDUP';
      case RideStatus.arrivedAtDropOff:
        return 'ARRIVED_AT_DROPOFF';
      case RideStatus.delivered:
        return 'COMPLETED';
      case RideStatus.ontrip:
        return 'ON_TRIP';
      case RideStatus.cancel:
        return 'CANCELLED_BY_DRIVER';
      case RideStatus.started:
        return 'STARTED';
      case null:
        return 'STARTED';
    }
  }

  String get toValue {
    switch (this) {
      case RideStatus.started:
        return 'ARRIVED';
      case RideStatus.arrivedAtPickup:
        return 'PICKEDUP';
      case RideStatus.pickedUp:
        return 'REACHED';
      case RideStatus.arrivedAtDropOff:
        return 'COMPLETED';
      default:
        return 'ARRIVED';
    }
  }
}

enum OnlineOfflineString {
  online,
  offline,
}

extension OnlineOfflineExtension on OnlineOfflineString {
  String get getOnOffString {
    switch (this) {
      case OnlineOfflineString.online:
        return 'Online';
      case OnlineOfflineString.offline:
        return 'Offline';
      default:
        return 'Title is null';
    }
  }
}

enum RideType {
  none,
  oneWay,
  roundTrip,
}

extension RideTypeString on RideType {
  String get getRideTypeString {
    switch (this) {
      case RideType.oneWay:
        return 'oneway';
      case RideType.roundTrip:
        return 'roundtrip';
      default:
        return 'Title is null';
    }
  }
}

enum Flavor {
  dev,
  staging,
  production,
}

enum Config {
  debug,
  profile,
  release,
}

enum RequestType {
  get,
  post,
  put,
  postFile,
}

extension RideTypeForUIString on RideType {
  String get getRideTypeForUIString {
    switch (this) {
      case RideType.oneWay:
        return 'One way';
      case RideType.roundTrip:
        return 'Round Trip';
      default:
        return 'Title is null';
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension StringExtensionLowerCase on String {
  String toLowerCase() {
    return "${this[0].toLowerCase()}${substring(1).toLowerCase()}";
  }
}

enum ListOfDocuments { aadhar, pan, dl, none }

extension ListOfDocumentsExtension on ListOfDocuments {
  String get getListOfDocumentsString {
    switch (this) {
      case ListOfDocuments.aadhar:
        return 'Aadhar card';
      case ListOfDocuments.pan:
        return 'PAN card';
      case ListOfDocuments.dl:
        return 'Driving license';
      default:
        return 'Title is null';
    }
  }
}

enum VehicleType {
  none,
  mini,
  sedan,
  primeSedan,
  suv,
  primeSuv,
  maxicab,
  maxicabCoach,
}

extension VehicleTypeString on VehicleType {
  String get getVehicleTypeString {
    switch (this) {
      case VehicleType.none:
        return 'None';
      case VehicleType.mini:
        return 'mini';
      case VehicleType.sedan:
        return 'sedan';
      case VehicleType.primeSedan:
        return 'prime sedan';
      case VehicleType.suv:
        return 'suv';
      case VehicleType.primeSuv:
        return 'prime suv';
      case VehicleType.maxicab:
        return 'maxicab';
      case VehicleType.maxicabCoach:
        return 'maxicab coach';
    }
  }
}

enum DriverRideType {
  ride,
  actingDriver,
  deliveryDriver,
}
