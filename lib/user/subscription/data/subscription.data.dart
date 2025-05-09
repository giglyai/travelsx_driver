import 'package:travelx_driver/global_variables.dart';

import '../../../shared/api_client/api_client.dart';
import '../../../shared/routes/api_routes.dart';

class SubscriptionData {
  static Future<Map<String, dynamic>> getSubscriptionData({
    required lpId,
    required userId,
    required user,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "user": 'driver-ride',
      "sub_type": "rides-count"
    };

    final response = await ApiClient().get(
      ApiRoutes.getSubscription,
      headers: requestHeaders,
      queryParams: queryData,
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> createSubscriptionData({
    required lpId,
    required userId,
    required user,
    required totalRides,
    required subPlan,
    required price,
    required subName,
    required currency,
    required subType,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final body = {
      "lp_id": lpId,
      "user_id": userId,
      "user": 'driver-ride',
      "subscription": {
        "sub_name": subName,
        "sub_plan": subPlan,
        "sub_type": subType,
        "total_rides": totalRides,
        "price": price,
        "currency": currency,
      }
    };

    final response = await ApiClient().post(
      ApiRoutes.accountUpdate,
      body: body,
      headers: requestHeaders,
    );

    return response as Map<String, dynamic>;
  }
}
