import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

extension Errror on DioException {
  Failure getFailure() {
    switch (type) {
      case DioExceptionType.connectionError:
        return NetworkFailure('Network Connection Error');
      case DioExceptionType.connectionTimeout:
        return NetworkFailure('Connection Timeout');
      case DioExceptionType.sendTimeout:
        return NetworkFailure('Send Timeout');
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Receive Timeout');
      case DioExceptionType.unknown:
        return ServerFailure('Unexpected Error Occurred');
      case DioExceptionType.cancel:
        return NetworkFailure('Request Cancelled');
      case DioExceptionType.badResponse:
        try {
          if (response?.data != null && response?.data is Map) {
            final data = response?.data;
            if (data['message'] != null) {
              return ServerFailure(data['message']);
            } else if (data['error'] != null) {
              return ServerFailure(data['error']);
            }
          }
        } catch (e) {
          return ServerFailure('Server Error: ${response?.statusCode}');
        }
        return ServerFailure('Server Error: ${response?.statusCode}');
      default:
        return NetworkFailure('Unknown Network Error');
    }
  }
}
