
import 'package:dio/dio.dart';
import 'package:novindus_feed_app/core/constants/api_constnts.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/error/failures.dart';

import '../../../home/data/models/home_models.dart';
import 'feed_remote_datasource.dart';

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final DioClient dioClient;

  FeedRemoteDataSourceImpl({required this.dioClient});


  @override
  Future<List<FeedModel>> getMyFeeds({int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.myFeed,
        queryParameters: {
          'page': page,
          'count': 10, 
        },
      );
      if (response.statusCode == 200) {
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
      throw e.getFailure();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
