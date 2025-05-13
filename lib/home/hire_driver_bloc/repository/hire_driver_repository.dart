import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart' as ride;
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/api_client/api_client.dart';
import '../entity/accepted_hire_ride.dart';

class HireRepository {
  // static Future<Map<String, dynamic>> fetchAcceptedHireDriverRide({
  //   required String lpId,
  //   required String userId,
  //   required LatLng currentPosition,
  // }) async {
  //   final queryData = {
  //     "lp_id": lpId,
  //     "user_id": userId,
  //     "user": AppNames.appName,
  //     "trip_status": "accepted",
  //     "latitude": currentPosition.latitude,
  //     "longitude": currentPosition.longitude,
  //   };
  //   final response = await ApiClient()
  //       .get(ApiRoutes.getHireDriverAcceptedData, queryParams: queryData);
  //   return response as Map<String, dynamic>;
  // }

  static Future<Map<String, dynamic>> hireDriverMutateRide({
    required String lpId,
    required String userId,
    required String user,
    required String firstName,
    required String countryCode,
    required String phoneNumber,
    required DriverPosition position,
    required String deviceToken,
    required String rideID,
    required String rideStatus,
    required String mutationReason,
    required String vehicleModel,
    required String vehicleName,
    required String vehicleNumber,
    int? startDist,
    int? endDist,
    User? userData,
    Payment? payment,
  }) async {
    final response = await ApiClient().post(
      ApiRoutes.mutateRides,
      body: {
        "lp_id": lpId,
        "user_id": userId,
        "user": user,
        "first_name": firstName,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "position": position.toJson(),
        "device_token": deviceToken,
        "ride_id": rideID,
        "ride_status": rideStatus,
        "mutation_reason": mutationReason,
        "ride_user": userData?.toJson(),
        "payment": payment?.toJson(),
        "mutate_by": "book_ride",
        "mode": "book_ride",
        "vehicle_model": vehicleModel,
        "vehicle_name": vehicleName,
        "vehicle_number": vehicleNumber,
        "start_dist": startDist,
        "end_dist": endDist,
      },
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> startMeterPost({
    required String lpId,
    required String userId,
    required String rideID,
    required String startTime,
    int? startDist,
  }) async {
    final response = await ApiClient().post(
      ApiRoutes.mutateRideDistMeter,
      body: {
        "lp_id": lpId,
        "user_id": userId,
        "user": AppNames.appName,
        "ride_id": rideID,
        "start_dist": startDist,
        "start_time": startTime,
      },
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> verifyRideOtp({
    required String lpId,
    required String userId,
    required String rideID,
    required int otp,
    required String firstName,
    required String countryCode,
    required String phoneNumber,
    required DriverPosition position,
    required String deviceToken,
    required String mutationReason,
    required String vehicleModel,
    required String vehicleName,
    required String vehicleNumber,
    int? startDist,
    int? endDist,
    User? userData,
    Payment? payment,
  }) async {
    final response = await ApiClient().post(
      ApiRoutes.mutateRides,
      body: {
        "lp_id": lpId,
        "user_id": userId,
        "user": AppNames.appName,
        "ride_id": rideID,
        "ride_status": "RIDE_OTP_VERIFIED",
        "ride_otp": otp,
        "first_name": firstName,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "position": position.toJson(),
        "device_token": deviceToken,
        "mutation_reason": mutationReason,
        "ride_user": userData?.toJson(),
        "payment": payment?.toJson(),
        "mutate_by": "book_ride",
        "mode": "book_ride",
        "vehicle_model": vehicleModel,
        "vehicle_name": vehicleName,
        "vehicle_number": vehicleNumber,
        "start_dist": startDist,
        "end_dist": endDist,
      },
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> endMeterPost({
    required String lpId,
    required String userId,
    required String rideID,
    required String endTime,
    int? endDist,
  }) async {
    final response = await ApiClient().post(
      ApiRoutes.mutateRideDistMeter,
      body: {
        "lp_id": lpId,
        "user_id": userId,
        "user": AppNames.appName,
        "ride_id": rideID,
        "end_dist": endDist,
        "end_time": endTime,
      },
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getRideFinalDetails({
    required String lpId,
    required String userId,
    required String rideID,
  }) async {
    final response = await ApiClient().get(
      ApiRoutes.getRideFinalDetails,
      queryParams: {
        "lp_id": lpId,
        "user_id": userId,
        "user": AppNames.appName,
        "ride_id": rideID,
      },
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> acceptDriverMutateRide({
    required String lpId,
    required String userId,
    required String user,
    required String firstName,
    required String countryCode,
    required String phoneNumber,
    required DriverPosition position,
    required String deviceToken,
    required String rideID,
    required String rideStatus,
    required String mutationReason,
    required String vehicleModel,
    required String vehicleName,
    required String vehicleNumber,
    User? userData,
    Payment? payment,
    ride.RideCommn? rideCommn,
  }) async {
    final response = await ApiClient().post(
      ApiRoutes.mutateRides,
      body: {
        "lp_id": lpId,
        "user_id": userId,
        "user": user,
        "first_name": firstName,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "position": position.toJson(),
        "device_token": deviceToken,
        "ride_id": rideID,
        "ride_status": rideStatus,
        "mutation_reason": mutationReason,
        "ride_user": userData?.toJson(),
        "payment": payment?.toJson(),
        "mutate_by": "book_ride",
        "mode": "book_ride",
        "vehicle_model": vehicleModel,
        "vehicle_name": vehicleName,
        "vehicle_number": vehicleNumber,
        "ride_commn": rideCommn?.toJson(),
      },
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getDistanceMetrix({
    required bool onRoute,
    required DriverPosition sourceLatLng,
    required DriverPosition destinationLatLng,
    String? travelMode,
  }) async {
    final response =
        await ApiClient().get(ApiRoutes.getDirectionDistance, queryParams: {
      'source_lat': sourceLatLng.latitude,
      'source_lng': sourceLatLng.longitude,
      'dest_lat': destinationLatLng.latitude,
      'dest_lng': destinationLatLng.longitude,
      'on_route': onRoute,
      if (travelMode != null) 'travel_mode': "book_ride",
    });
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> fetchManualRides({
    required String lpId,
    required String userId,
    required String user,
    required String countryCode,
    required LatLng currentPosition,
    required int searchRadius,
    required String unit,
    required String profile,
    required String url,
    required String vechileType,
    required String rideType,
    required String feature,
    required String accountStatus,
  }) async {
    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "user": user,
      "country_code": countryCode,
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
      "search_radius": searchRadius,
      "unit": unit,
      "profile": profile,
      "vehicle_type": vechileType,
      "ride_type": rideType,
      "ride_date": "today",
      "ride_search_for": rideType,
      "ride_feature": feature,
      "account_status": accountStatus
    };
    final response = await ApiClient().get(url, queryParams: queryData);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getUpcomingOnTripRideData({
    required String lpId,
    required String userId,
    required String user,
  }) async {
    final response =
        await ApiClient().get(ApiRoutes.getUpcomingOnTripRide, queryParams: {
      'lp_id': lpId,
      'user_id': userId,
      'user': user,
    });
    return response as Map<String, dynamic>;
  }
}
