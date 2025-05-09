import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';
import 'package:travelx_driver/user/account/enitity/upload.dart';

class BookingRegistrationRepo {
  static Future<Map<String, dynamic>> uploadCarDocuments({
    required PostUserData params,
    FileState<String>? selfie,
    FileState<String>? exteriorFront,
    FileState<String>? exteriorRight,
    FileState<String>? exteriorLeft,
    FileState<String>? exteriorRear,
  }) async {
    // String p = params.toJson();

    var data = FormData.fromMap({
      "files": [
        await MultipartFile.fromFile(
          selfie!.file!,
          filename: selfie.type,
        ),
        await MultipartFile.fromFile(
          exteriorFront!.file!,
          filename: exteriorFront.type,
        ),
        await MultipartFile.fromFile(
          exteriorRight!.file!,
          filename: exteriorRight.type,
        ),
        await MultipartFile.fromFile(
          exteriorLeft!.file!,
          filename: exteriorLeft.type,
        ),
        await MultipartFile.fromFile(
          exteriorRear!.file!,
          filename: exteriorRear.type,
        ),
      ],
      // 'user_data': '\"${jsonEncode(params.toJson()).replaceAll('"', '\\"')}\"'
      'user_data': params.toJson(),
    });

    final response = await ApiClient().post(
      "${ApiRoutes.baseUrlV1}user/vehicle/images/upload",
      body: data,
      headers: {'Content-Type': 'multipart/form-data'},
    );

    return response as Map<String, dynamic>;
  }
}
