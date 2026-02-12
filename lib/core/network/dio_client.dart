import 'package:dio/dio.dart';
import 'package:novindus_feed_app/core/constants/api_constnts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../error/failures.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 05),
        receiveTimeout: const Duration(seconds: 05),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          
          print('Request: ${options.method} ${options.path}');
          print('Headers: ${options.headers}');
          print('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
        
          print('Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
         
          final failure = e.getFailure();
          print('Error: ${e.response?.statusCode} ${failure.message}');
          if (e.response != null) {
            print('Error Data: ${e.response?.data}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
