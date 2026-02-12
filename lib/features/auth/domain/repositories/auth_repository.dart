import 'package:novindus_feed_app/core/utils/result.dart';


abstract class AuthRepository {
  Future<Result<String>> login(String countryCode, String phone);
}
