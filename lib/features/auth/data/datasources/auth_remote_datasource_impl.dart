import 'package:dio/dio.dart';
import 'package:novindus_feed_app/core/constants/api_constnts.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/error/failures.dart';

import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Map<String, dynamic>> login(String countryCode, String phone) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.otpVerified,
        data: FormData.fromMap({'country_code': countryCode, 'phone': phone}),
      );
      if (response.statusCode == 202) {
        final data = response.data;
        if (data is Map<String, dynamic> && data.containsKey('token')) {
          final tokenData = data['token'];
          if (tokenData is Map<String, dynamic> &&
              tokenData.containsKey('access')) {
            return {'access': tokenData['access']};
          }
        }
        throw ServerFailure('Invalid response format');
      } else {
        throw ServerFailure('Server Error: ${response.statusCode}');  
      }
    } on DioException catch (e) {
      throw ServerFailure(e.getFailure().message);
    } catch (e) {
      throw ServerFailure(
        'An unexpected error occurred. Please try again later.',
      );
    }
  }
}
