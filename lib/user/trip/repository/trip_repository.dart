import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';

import '../../../shared/api_client/api_client.dart';
import '../../../shared/routes/api_routes.dart';

class TripRepository {
  static Future<Map<String, dynamic>> getSingleTripData({
    required lpId,
    required userId,
    required String dateFilter,
    required String tripStatus,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "date_filter": dateFilter,
      "trip_status": tripStatus,
      "user": AppNames.appName,
    };

    final response = await ApiClient().get(
      ApiRoutes.getUserTrip,
      headers: requestHeaders,
      queryParams: queryData,
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getTripData({
    required lpId,
    required userId,
    required String dateFilter,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "date_filter": dateFilter,
      "user": AppNames.appName,
    };

    final response = await ApiClient().get(
      ApiRoutes.getRidesMatrix,
      headers: requestHeaders,
      queryParams: queryData,
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> cancelRide({
    required int lpId,
    required int userId,
    required String rideID,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final body = {
      "lp_id": lpId,
      "user_id": userId,
      "user": AppNames.appName,
      "ride_id": rideID,
      "ride_status": RideStatus.cancel.getRideStatusString,
      "driver_lp_id": "",
      "driver_user_id": "",
      "driver_device_token": "",
      "mutation_reason": "driver cancel ride",
    };

    final response = await ApiClient().post(
      ApiRoutes.mutateRides,
      headers: requestHeaders,
      body: body,
    );

    return response as Map<String, dynamic>;
  }
}
