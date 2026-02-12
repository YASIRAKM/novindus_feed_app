import 'package:dio/dio.dart';
import 'package:novindus_feed_app/core/constants/api_constnts.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/error/failures.dart';

import '../models/home_models.dart';
import 'home_remote_datasource.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.categoryList);
      if (response.statusCode == 202) {
        List<dynamic> data;
        if (response.data is Map<String, dynamic> &&
            (response.data as Map<String, dynamic>).containsKey('categories')) {
          data = response.data['categories'];
        } else if (response.data is List) {
          data = response.data;
        } else {
          data = [];
        }
        return data.map((e) => CategoryModel.fromJson(e)).toList();
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

  @override
  Future<List<FeedModel>> getFeeds() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.home);
      if (response.statusCode == 202) {
        List<dynamic> data;
        if (response.data is Map<String, dynamic> &&
            (response.data as Map<String, dynamic>).containsKey('results')) {
          data = response.data['results'];
        } else if (response.data is List) {
          data = response.data;
        } else {
          data = [];
        }
        return data.map((e) => FeedModel.fromJson(e)).toList();
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
