

import '../../../home/data/models/home_models.dart';

abstract class FeedRemoteDataSource {
 

  Future<List<FeedModel>> getMyFeeds({int page = 1});
}
