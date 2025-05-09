import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:travelx_driver/shared/api_client/api_exception.dart';
import 'package:travelx_driver/shared/api_client/header_interceptor.dart';

import '../../main.dart';
import '../widgets/exceptional_handling_bottomsheet/exceptional_handling_bottomsheet.dart';
import 'api_result.dart';

typedef JsonMap = Map<String, dynamic>;

enum Backend { main, reporting }

enum ApiStatus {
  init,
  loading,
  success,
  failure,
  empty,
  onTrip,
}

extension ApiExtensions on ApiStatus? {
  bool get isLoading {
    return this == ApiStatus.loading ? true : false;
  }

  bool get success {
    return this == ApiStatus.success ? true : false;
  }

  bool get failure {
    return this == ApiStatus.failure ? true : false;
  }

  bool get empty {
    return this == ApiStatus.empty ? true : false;
  }
}

class ApiClient {
  String? token;

  static final ApiClient _instance = ApiClient.internal();
  static late Dio _dio;
  static ApiResult apiResult = ApiResult();
  ApiClient.internal() {
    _dio = Dio(
      BaseOptions(),
    )
      ..interceptors.add(AuthInterceptor())
      ..interceptors.add(LogInterceptor(
          responseBody: true,
          logPrint: _log,
          requestBody: true,
          request: true));
  }
  factory ApiClient() => _instance;
  final CancelToken _cancelToken = CancelToken();
  Future get(url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams}) async {
    try {
      Response response = await _dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: queryParams,
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      // return CustomExceptionBottomSheet()
      //     .customBottomSheet(context: navigatorKey.currentState!.context);

      return _handleError(url, error);
    }
  }

  Future getRefersh(url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams}) async {
    try {
      Response response = await _dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: queryParams,
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return CustomExceptionBottomSheet()
          .customBottomSheet(context: navigatorKey.currentState!.context);

      // return _handleError(url, error);
    }
  }

  Future getWithoutBottomSheet(url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams}) async {
    try {
      Response response = await _dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: queryParams,
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future<dynamic> post(url,
      {required dynamic body, Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      // return CustomExceptionBottomSheet()
      //     .customBottomSheet(context: navigatorKey.currentState!.context);
      return _handleError(url, error);
    }
  }

  Future<dynamic> postLocations(url,
      {required dynamic body, Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future update(
    String url, {
    required JsonMap body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await _dio.put(
        url,
        data: body,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future delete(
    String url, {
    required JsonMap body,
    Map<String, dynamic>? header,
  }) async {
    try {
      Response response = await _dio.delete(
        url,
        data: body,
        options: Options(headers: header),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future<Map<String, dynamic>> _handleError(String path, Object error) {
    if (error is DioError) {
      final method = error.requestOptions.method;
      final response = error.response;

      apiResult.setStatusCode(response?.statusCode);

      final data = response?.data;
      int? statusCode = response?.statusCode;
      if (statusCode == 401) {
      } else {}

      if (error.type == DioErrorType.connectTimeout ||
          error.type == DioErrorType.sendTimeout ||
          error.type == DioErrorType.receiveTimeout) {
        statusCode = HttpStatus
            .requestTimeout; //Set the error code to 408 in case of timeout
      }
      throw ApiException(
        errorMessage: response?.data != null ? response?.data['message'] : '',
        path: path,
        message: 'received server error $statusCode while $method data',
        response: data.toString(),
        statusCode: statusCode,
        method: method,
      );
    } else {
      int errorCode = 0; //We will send a default error code as 0

      throw ApiException(
        path: path,
        message: 'received server error $errorCode',
        response: error.toString(),
        statusCode: errorCode,
        method: '',
      );
    }
  }

  void _log(Object object) {
    log("$object");
  }
}
