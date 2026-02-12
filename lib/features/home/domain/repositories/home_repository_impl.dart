import '../../../../core/error/failures.dart';
import '../entities/home_entities.dart';
import '../../data/datasources/home_remote_datasource.dart';
import 'home_repository.dart';
import '../../../../core/utils/result.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Success(categories);
    } on Failure catch (e) {
      return FailureResult(e);
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Feed>>> getFeeds() async {
    try {
      final feeds = await remoteDataSource.getFeeds();
      return Success(feeds);
    } on Failure catch (e) {
      return FailureResult(e);
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }
}
