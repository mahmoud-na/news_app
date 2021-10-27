import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init({required String baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    String lang = 'ar',
    String authorization='',
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': authorization,
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String authorization='',
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': authorization,
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
