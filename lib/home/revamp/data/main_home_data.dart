import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/home/models/post_userdata_params.dart' as Params;
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';

import '../../hire_driver_bloc/entity/accepted_hire_ride.dart';

class MainHomeData {
  static Future<Map<String, dynamic>> getDriverBusinessOverview({
    required String lpId,
    required String userId,
    required String date,
  }) async {
    final response = await ApiClient().get(
      ApiRoutes.getDriverBusinessOverview,
      queryParams: {
        'lp_id': lpId,
        'user_id': userId,
        'user_type': AppNames.appName,
        "date_filter": date,
        "offset": 0,
        "limit": 100,
      },
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getRideHomeData({
    required LatLng currentPosition,
    required lpId,
    required userId,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
      "user": AppNames.appName,
    };

    final response = await ApiClient().getWithoutBottomSheet(
      ApiRoutes.getDriverRideHomeData,
      headers: requestHeaders,
      queryParams: queryData,
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getAppVersion() async {
    final response = await ApiClient().getWithoutBottomSheet(
      ApiRoutes.appVersion,
      queryParams: {"app_name": AppNames.appName},
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getProfileData({
    required lpId,
    required userId,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "user": AppNames.appName,
    };

    final response = await ApiClient().getWithoutBottomSheet(
      ApiRoutes.getUserProfileData,
      headers: requestHeaders,
      queryParams: queryData,
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getUpcomingOnTripRideData({
    required String lpId,
    required String userId,
  }) async {
    final response = await ApiClient().get(
      ApiRoutes.getUpcomingOnTripRide,
      queryParams: {'lp_id': lpId, 'user_id': userId, 'user': AppNames.appName},
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getRidesMatrix({
    required String lpId,
    required String userId,
    required String date,
  }) async {
    final response = await ApiClient().get(
      ApiRoutes.getRidesMatrix,
      queryParams: {
        'lp_id': lpId,
        'user_id': userId,
        'user': AppNames.appName,
        "date_filter": date,
      },
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> hireDriverMutateRide({
    required String lpId,
    required String userId,
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
  }) async {
    final response = await ApiClient().post(
      ApiRoutes.mutateRides,
      body: {
        "lp_id": lpId,
        "user_id": userId,
        "user": AppNames.appName,
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
      },
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> postUserData(
    Params.PostUserDataParams params,
  ) async {
    final response = await ApiClient().postLocations(
      ApiRoutes.updateUserLocation,
      body: params.toJson(),
    );
    return response as Map<String, dynamic>;
  }
}
