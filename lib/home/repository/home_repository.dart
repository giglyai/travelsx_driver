import 'package:travelx_driver/global_variables.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/home/models/post_userdata_params.dart';
import 'package:travelx_driver/home/models/ride_response_model.dart' as user;
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/api_client/api_client.dart';

class HomeRepository {
  static String? refreshToken;
  static Future<Map<String, dynamic>> postUserData(
    PostUserDataParams params,
  ) async {
    final response = await ApiClient().postLocations(
      ApiRoutes.updateUserLocation,
      body: params.toJson(),
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

  static Future<Map<String, dynamic>> fetchRide({
    required String lpId,
    required String userId,
    required String countryCode,
    required LatLng currentPosition,
    required String accountStatus,
    required String unit,
    required String url,
    required String rideId,
    required String vehicleType,
    required String actingDriverRide,
  }) async {
    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "account_status": accountStatus,
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
      "vehicle_type": vehicleType,
      "ride_id": rideId,
      "acting_driver_ride": actingDriverRide,
    };
    final response = await ApiClient().get(url, queryParams: queryData);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> fetchRides({
    required String lpId,
    required String userId,
    required String countryCode,
    required LatLng currentPosition,
    required int searchRadius,
    required String unit,
    required String profile,
    required String accountStatus,
    required String url,
    required String vechileType,
  }) async {
    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
      "search_radius": searchRadius,
      "unit": unit,
      "profile": profile,
      "vehicle_type": vechileType,
      "account_status": accountStatus,
      "ride_type": "all",
      "ride_date": "today",
    };
    final response = await ApiClient().get(url, queryParams: queryData);
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
    required String accountStatus,
    required String rideType,
    required String feature,
  }) async {
    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "user": user,
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
      "search_radius": searchRadius,
      "unit": unit,
      "profile": profile,
      "account_status": accountStatus,
      "vehicle_type": vechileType,
      "ride_type": "all",
      "ride_date": "today",
      "ride_search_for": rideType,
      "ride_feature": feature,
    };
    final response = await ApiClient().get(url, queryParams: queryData);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getTripsMetrics({
    required String lpId,
    required String userId,
  }) async {
    final queryData = {"lp_id": lpId, "user_id": userId};
    final response = await ApiClient().get(
      ApiRoutes.getTripsMetrics,
      queryParams: queryData,
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getPromotionsData({
    required String lpId,
    required String userId,
    required LatLng currentPosition,
    required int offSet,
    required int limit,
  }) async {
    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
      "offset": offSet,
      "limit": limit,
    };
    final response = await ApiClient().get(
      ApiRoutes.activeRidePromotion,
      queryParams: queryData,
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> toggleDriverStatus({
    required String lpId,
    required String userId,
    required String user,
    required bool onlineStatus,
    required String deviceToken,
    required String phoneNumber,
    required bool rideStatus,
  }) async {
    final response = await ApiClient().postLocations(
      ApiRoutes.toggleDriverStatus,
      body: {
        "lp_id": lpId,
        "user_id": userId,
        "user": user,
        "device_token": deviceToken,
        "phone_number": phoneNumber,
        "profile": {
          "online_status": onlineStatus ? "ON" : "OFF",
          "ride_status": rideStatus ? "ON" : "OFF",
        },
      },
    );
    if (response is Map) {
      return response as Map<String, dynamic>;
    }
    return {};
  }

  static Future<Map<String, dynamic>> toggleDriverDetails({
    required String phoneNumber,
    required bool rideStatus,
    required bool deliveryStatus,
    required bool onlineStatus,
  }) async {
    final response = await ApiClient().post(
      ApiRoutes.updateUserDetail,
      body: {
        "profile": {
          "online_status": onlineStatus ? "ON" : "OFF",
          "ride_status": rideStatus ? "ON" : "OFF",
          "delivery_status": deliveryStatus ? "ON" : "OFF",
        },
        "phone_number": phoneNumber,
      },
    );
    return response as Map<String, dynamic>;
  }

  // static Future<Map<String, dynamic>> mutateDeliveryStatus({
  //   required String lpId,
  //   required String userId,
  //   required DriverPosition position,
  //   required String deliveryId,
  //   required String priceId,
  //   required String deliveryStatus,
  //   required String mutationReason,
  //   required String playerId,
  //   required String tripId,
  // }) async {
  //   log(jsonEncode({
  //     "trip_id": tripId,
  //     "lp_id": lpId,
  //     "user_id": userId,
  //     "position": position.toJson(),
  //     "delivery_id": deliveryId,
  //     "rate_id": priceId,
  //     "delivery_status": deliveryStatus,
  //     "mutation_reason": mutationReason,
  //     "player_id": playerId
  //   }));
  //   final response = await ApiClient().post(ApiRoutes.mutateTrips, body: {
  //     "trip_id": tripId,
  //     "lp_id": lpId,
  //     "user_id": userId,
  //     "user": 'travelsx-driver',
  //     "position": position.toJson(),
  //     "delivery_id": deliveryId,
  //     "rate_id": priceId,
  //     "delivery_status": deliveryStatus,
  //     "mutation_reason": mutationReason,
  //     "player_id": playerId
  //   });

  //   return response as Map<String, dynamic>;
  // }

  static Future<Map<String, dynamic>> mutateRideStatus({
    required String lpId,
    required String userId,
    required String user,
    String? firstName,
    required String countryCode,
    required String phoneNumber,
    required DriverPosition position,
    required String deviceToken,
    required String rideID,
    required String rideStatus,
    String? vehicleModel,
    String? vehicleName,
    String? vehicleNumber,
    required String mutationReason,
    String? bookedFor,
    user.User? userData,
    user.Payment? payment,
  }) async {
    final response = await ApiClient().post(
      ApiRoutes.mutateRides,
      body: {
        "lp_id": lpId,
        "user_id": userId,
        "user": user,
        "first_name": firstName,
        "phone_number": phoneNumber,
        "position": position.toJson(),
        "device_token": deviceToken,
        "vehicle_model": vehicleModel,
        "vehicle_name": vehicleName,
        "vehicle_number": vehicleNumber,
        "ride_id": rideID,
        "ride_status": rideStatus,
        "mutation_reason": mutationReason,
        "ride_user": userData?.toJson(),
        "payment": payment?.toJson(),
        "mute_ride_for": bookedFor,
      },
      headers: header,
    );

    return response as Map<String, dynamic>;
  }

  // static Future<Map<String, dynamic>> mutateDeliveryStatusWithImage(
  //     {required String driverId,
  //     required String deliveryId,
  //     required String priceId,
  //     required String lpId,
  //     required String deliveryStatus,
  //     required String mutationReason,
  //     required DriverPosition? position,
  //     required String imagePath,
  //     required String playerId,
  //     required String tripId}) async {
  //   final Map<String, dynamic> mutationData = {
  //     "trip_id": tripId,
  //     "driver_id": driverId,
  //     "rate_id": priceId,
  //     "lp_id": lpId,
  //     "delivery_id": deliveryId,
  //     "delivery_status": deliveryStatus,
  //     "mutation_reason": mutationReason,
  //     "position": position?.toJson(),
  //     "player_id": playerId
  //   };

  //   final FormData formdata = FormData();

  //   formdata.fields.add(MapEntry('mutation_data', jsonEncode(mutationData)));

  //   formdata.files
  //       .add(MapEntry('delivery_image', MultipartFile.fromFileSync(imagePath)));

  //   final response =
  //       await ApiClient().post(ApiRoutes.mutateTripsImage, body: formdata);
  //   return response as Map<String, dynamic>;
  // }

  static Future<Map<String, dynamic>> getTripFullRoute({
    required String lpId,
    required String userId,
    required String deliveryId,
    required DriverPosition position,
    required String url,
  }) async {
    final response = await ApiClient().get(
      url,
      queryParams: {
        "lp_id": lpId,
        "user_id": userId,
        "ride_ids": deliveryId,
        "latitude": position.latitude,
        "longitude": position.longitude,
      },
    );
    return response as Map<String, dynamic>;
  }

  // static Future<Map<String, dynamic>> getDeliveryFullRoute(
  //     {required String lpId,
  //     required String driverId,
  //     required String deliveryId,
  //     required DriverPosition position,
  //     required String url}) async {
  //   final response = await ApiClient().get(url, queryParams: {
  //     "lp_id": lpId,
  //     "driver_id": driverId,
  //     "delivery_ids": deliveryId,
  //     "latitude": position.latitude,
  //     "longitude": position.longitude
  //   });
  //   return response as Map<String, dynamic>;
  // }

  static Future<Map<String, dynamic>> getDistanceMetrix({
    required bool onRoute,
    required DriverPosition sourceLatLng,
    required DriverPosition destinationLatLng,
  }) async {
    final response = await ApiClient().get(
      ApiRoutes.getDirectionDistance,
      queryParams: {
        'source_lat': sourceLatLng.latitude,
        'source_lng': sourceLatLng.longitude,
        'dest_lat': destinationLatLng.latitude,
        'dest_lng': destinationLatLng.longitude,
        'on_route': onRoute,
      },
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getUpcomingOnTripRideData({
    required String lpId,
    required String userId,
    required String user,
  }) async {
    final response = await ApiClient().get(
      ApiRoutes.getUpcomingOnTripRide,
      queryParams: {'lp_id': lpId, 'user_id': userId, 'user': user},
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> updateDriverRate({
    required String lpId,
    required String userId,
    required String countryCode,
    required String rideType,
    required String vehicleType,
    required String baseDistance,
    required String baseRate,
    required String perUnitRate,
    required String currency,
  }) async {
    final response = await ApiClient().post(
      ApiRoutes.updateDriverRate,
      body: {
        "lp_id": lpId,
        "user_id": userId,
        "ride_type": rideType,
        "vehicle_type": vehicleType,
        "base_distance": baseDistance,
        "base_rate": baseRate,
        "per_unit_rate": perUnitRate,
        "currency": currency,
      },
    );
    if (response is Map) {
      return response as Map<String, dynamic>;
    }
    return {};
  }

  static Future<Map<String, dynamic>> getAppVersion({
    required String appName,
  }) async {
    final response = await ApiClient().getWithoutBottomSheet(
      ApiRoutes.appVersion,
      queryParams: {"app_name": appName},
    );
    return response as Map<String, dynamic>;
  }
}
