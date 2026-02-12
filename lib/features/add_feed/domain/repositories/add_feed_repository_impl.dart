import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/error/failures.dart';
import 'add_feed_repository.dart';
import '../../data/datasources/add_feed_remote_datasource.dart';

class AddFeedRepositoryImpl implements AddFeedRepository {
  final AddFeedRemoteDataSource remoteDataSource;

  AddFeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<String>> uploadFeed({
    required XFile video,
    required XFile image,
    required String desc,
    required List<int> categoryIds,
    required void Function(int, int) onSendProgress,
  }) async {
    try {
      final result = await remoteDataSource.uploadFeed(
        video: video,
        image: image,
        desc: desc,
        categoryIds: categoryIds,
        onSendProgress: onSendProgress,
      );
      return Success(result);
    } on ServerFailure catch (e) {
      return FailureResult(e);
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }
}
