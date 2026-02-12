
import '../../../home/domain/entities/home_entities.dart';
import '../../../../core/utils/result.dart';

abstract class FeedRepository {
 

  Future<Result<List<Feed>>> getMyFeeds({int page = 1});
}
