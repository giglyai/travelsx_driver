import '../../../shared/api_client/api_client.dart';
import '../../../shared/routes/api_routes.dart';

class WalletRepository {
  static Future<Map<String, dynamic>> getWalletData({
    required lpId,
    required userId,
    required user,
    required String dateFilter,
    String? dateRange,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "user": user,
      "date_filter": dateFilter,
      // "date_range": dateRange,
    };

    final response = await ApiClient().get(
      ApiRoutes.getWalletData,
      headers: requestHeaders,
      queryParams: queryData,
    );

    return response;
  }
}
