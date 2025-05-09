import '../../../shared/api_client/api_client.dart';
import '../../../shared/routes/api_routes.dart';

class MyAgencyData {
  static Future<Map<String, dynamic>> getMyAgencyData(
      {required lpId,
      required userId,
      required user,
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
      "offset": offset,
      "limit": limit,
    };

    final response = await ApiClient().get(
      ApiRoutes.getMyAgency,
      headers: requestHeaders,
      queryParams: queryData,
    );

    return response as Map<String, dynamic>;
  }
}
