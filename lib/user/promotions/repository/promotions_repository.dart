import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/api_client/api_client.dart';
import '../../../shared/routes/api_routes.dart';

class PromotionRepository {
  static Future<Map<String, dynamic>> activePromotion(
      {required lpId,
      required userId,
      required user,
      required LatLng currentPosition,
      required int offset,
      required int limit}) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "user": user,
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
      "offset": offset,
      "limit": limit
    };

    final response = await ApiClient().get(ApiRoutes.activeRidePromotion,
        headers: requestHeaders, queryParams: queryData);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> completedPromotion(
      {required lpId,
      required userId,
      required user,
      required LatLng currentPosition,
      required int offset,
      required int limit}) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "user": user,
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
      "offset": offset,
      "limit": limit
    };

    final response = await ApiClient().get(ApiRoutes.completedRidePromotion,
        headers: requestHeaders, queryParams: queryData);
    return response as Map<String, dynamic>;
  }
}
