import '../../../../core/error/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import 'auth_repository.dart';
import '../../../../core/utils/result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<Result<String>> login(String countryCode, String phone) async {
    try {
      final data = await remoteDataSource.login(countryCode, phone);
      final accessToken = data['access'];

      await sharedPreferences.setString('access_token', accessToken);

      return Success(accessToken);
    } on Failure catch (e) {
      return FailureResult(e);
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }
}
