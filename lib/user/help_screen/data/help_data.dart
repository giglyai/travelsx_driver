import '../../../shared/api_client/api_client.dart';
import '../../../shared/routes/api_routes.dart';

class HelpData {
  static Future<Map<String, dynamic>> getHelpData({
    required String lpId,
    required String userId,
    required String user,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var params = {
      "lp_id": lpId,
      "user_id": userId,
      "user": user,
    };

    final response = await ApiClient().get(
      ApiRoutes.userHelp,
      queryParams: params,
      headers: requestHeaders,
    );

    return response as Map<String, dynamic>;
  }
}
