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
    switch (error) {
      case DioExceptionType.connectionError:
        return NetworkFailure('Connection Error');
      case DioExceptionType.connectionTimeout:
        return NetworkFailure('Connection Timeout');
      case DioExceptionType.sendTimeout:
        return NetworkFailure('Send Timeout');
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Receive Timeout');
      case DioExceptionType.unknown:
        return ServerFailure('Server Error');
      case DioExceptionType.cancel:
        return NetworkFailure('Cancel');
      case DioExceptionType.badResponse:
        return ServerFailure('Bad Response');
      default:
        return NetworkFailure('Unknown Error');
    }
  }
}
