import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:travelx_driver/home/models/post_userdata_params.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';

class DocumentsRepository {
  static Future<Map<String, dynamic>> updateUserDocument(
      {required PostUserDataParams params, required String imagePath}) async {
    final FormData formdata = FormData();

    formdata.fields.add(MapEntry('user_data', jsonEncode(params)));

    formdata.files
        .add(MapEntry('user_doc', MultipartFile.fromFileSync(imagePath)));

    final response =
        await ApiClient().post(ApiRoutes.postUserDoc, body: formdata);

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getDocStatus() async {
    final response = await ApiClient().get(
      ApiRoutes.getDocStatus,
    );
    return response as Map<String, dynamic>;
  }
}
