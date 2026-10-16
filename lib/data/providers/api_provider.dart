import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/services/storage_service.dart';
import 'api_endpoints.dart';

/// Thin Dio wrapper used by all repositories (MVVM → Repository → Provider).
class ApiProvider {
  ApiProvider._();

  static late final Dio dio;

  /// Point this to your backend. When [useMock] is true the repositories
  /// serve local mock data instead (offline demo mode).
  static const String baseUrl = 'https://api.shoestore.app/v1';
  static const bool useMock = true;

  static Future<void> init() async {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      contentType: 'application/json',
    );

    dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          debugPrint('→ ${options.method} ${options.path}');
          handler.next(options);
        },
        onError: (error, handler) {
          debugPrint(
              '← ${error.response?.statusCode} ${error.requestOptions.path}: '
              '${error.message}');
          handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  static Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
  }) =>
      dio.get(path, queryParameters: query, options: options);

  static Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  }) =>
      dio.post(path, data: data, queryParameters: query);

  static Future<Response<dynamic>> put(String path, {dynamic data}) =>
      dio.put(path, data: data);

  static Future<Response<dynamic>> delete(String path) => dio.delete(path);

  /// Example helper showing the generic request surface.
  static Future<T> request<T>(
    String path, {
    String method = 'GET',
    dynamic data,
    Map<String, dynamic>? query,
    required T Function(dynamic json) parser,
  }) async {
    final response = await dio.request<dynamic>(
      path,
      data: data,
      queryParameters: query,
      options: Options(method: method),
    );
    return parser(response.data);
  }

  static String productsPath() => ApiEndpoints.products;
}
