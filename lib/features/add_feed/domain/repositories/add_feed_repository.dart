import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/result.dart';

abstract class AddFeedRepository {
  Future<Result<String>> uploadFeed({
    required XFile video,
    required XFile image,
    required String desc,
    required List<int> categoryIds,
    required void Function(int, int) onSendProgress,
  });
}
