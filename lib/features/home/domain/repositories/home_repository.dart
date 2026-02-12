import '../entities/home_entities.dart';
import '../../../../core/utils/result.dart';

abstract class HomeRepository {
  Future<Result<List<Category>>> getCategories();
  Future<Result<List<Feed>>> getFeeds();
}
