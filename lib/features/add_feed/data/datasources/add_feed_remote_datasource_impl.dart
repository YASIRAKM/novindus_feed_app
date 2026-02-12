import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:novindus_feed_app/core/constants/api_constnts.dart';
import 'package:novindus_feed_app/core/error/failures.dart';
import 'package:novindus_feed_app/core/network/dio_client.dart';
import 'package:novindus_feed_app/features/add_feed/data/datasources/add_feed_remote_datasource.dart';

class AddFeedRemoteDataSourceImpl implements AddFeedRemoteDataSource {
  final DioClient dioClient;

  AddFeedRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<String> uploadFeed({
    required XFile video,
    required XFile image,
    required String desc,
    required List<int> categoryIds,
    required void Function(int, int) onSendProgress,
  }) async {
    try {
      final String videoMimeType = lookupMimeType(video.path) ?? 'video/mp4';
      final String imageMimeType = lookupMimeType(image.path) ?? 'image/jpeg';

      FormData formData = FormData.fromMap({
        "desc": desc,
        "category": categoryIds,
        "video": await MultipartFile.fromFile(
          video.path,
          contentType: MediaType.parse(videoMimeType),
        ),
        "image": await MultipartFile.fromFile(
          image.path,
          contentType: MediaType.parse(imageMimeType),
        ),
      });

      final response = await dioClient.dio.post(
        ApiConstants.myFeed,
        data: formData,
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        return 'Upload Successful';
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
