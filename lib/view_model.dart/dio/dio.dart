import 'package:dio/dio.dart';
import 'package:promina/view_model.dart/dio/end_points.dart';

import '../local/CacheService.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: BaseRULAPP.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    return await dio.post(
      url,
      queryParameters: queryParameters,
      data: data,
    );
  }

  static Future<Response> getData({
    required String url,
    required String token,
    Map<String, dynamic>? queryParameters,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    return await dio.get(
      url,
      queryParameters: queryParameters,
    );
  }
}
