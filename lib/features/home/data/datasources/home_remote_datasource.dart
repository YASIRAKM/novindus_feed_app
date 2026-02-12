import '../models/home_models.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<FeedModel>> getFeeds();
}
