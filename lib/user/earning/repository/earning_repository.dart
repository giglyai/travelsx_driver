import '../../../shared/api_client/api_client.dart';
import '../../../shared/routes/api_routes.dart';

class EarningRepository {
  static Future<Map<String, dynamic>> getEarningData(
      {required lpId,
      required userId,
      required user,
      required String dateFilter,
      required String dateRange,
      required int offset,
      required int limit}) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "user": 'driver-ride',
      "date_filter": dateFilter,
      // "date_range": dateRange,
      "offset": offset,
      "limit": limit,
    };

    final response = await ApiClient().get(
      ApiRoutes.getEarning,
      headers: requestHeaders,
      queryParams: queryData,
    );

    return response as Map<String, dynamic>;
  }
}
