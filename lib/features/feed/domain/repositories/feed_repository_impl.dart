
import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/home_entities.dart';
import '../../data/datasources/feed_remote_datasource.dart';
import 'feed_repository.dart';
import '../../../../core/utils/result.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Result<List<Feed>>> getMyFeeds({int page = 1}) async {
    try {
      final result = await remoteDataSource.getMyFeeds(page: page);
      return Success(result);
    } on Failure catch (e) {
      return FailureResult(e);
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }
}
