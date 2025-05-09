import 'package:dio/dio.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';
import 'package:travelx_driver/user/account/enitity/upload.dart';

import '../../../../../shared/widgets/text_form_field/custom_textform_field.dart';

class DriverAccountData {
  static Future<Map<String, dynamic>> uploadDriverId({
    required PostProfileData params,
    FileState<String>? frontFiles,
    FileState<String>? backFiles,
    required bool isSingleDocUpload,
  }) async {
    var getList = [];
    if (isSingleDocUpload == false) {
      getList = [
        await MultipartFile.fromFile(frontFiles!.file!,
            filename: frontFiles.type),
        await MultipartFile.fromFile(backFiles!.file!, filename: backFiles.type)
      ];
    } else {
      getList = [
        await MultipartFile.fromFile(frontFiles!.file!,
            filename: frontFiles.type),
      ];
    }

    var data = FormData.fromMap({
      "files": getList,
      'user_data': params.toJson(),
    });

    final response = await ApiClient().post(
      "${ApiRoutes.baseUrlV1}user/files/upload",
      body: data,
      headers: {'Content-Type': 'multipart/form-data'},
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getProfileData({
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
      "user": AppNames.appName,
    };

    final response = await ApiClient().getWithoutBottomSheet(
      ApiRoutes.getUserProfileData,
      headers: requestHeaders,
      queryParams: queryData,
    );
    return response as Map<String, dynamic>;
  }
}
