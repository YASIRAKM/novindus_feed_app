import 'package:get_it/get_it.dart';

import 'package:novindus_feed_app/core/network/dio_client.dart';
import 'package:novindus_feed_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:novindus_feed_app/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:novindus_feed_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:novindus_feed_app/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:novindus_feed_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:novindus_feed_app/features/feed/data/datasources/feed_remote_datasource.dart';
import 'package:novindus_feed_app/features/feed/data/datasources/feed_remote_datasource_impl.dart';
import 'package:novindus_feed_app/features/feed/domain/repositories/feed_repository.dart';
import 'package:novindus_feed_app/features/feed/domain/repositories/feed_repository_impl.dart';
import 'package:novindus_feed_app/features/feed/presentation/providers/feed_provider.dart';
import 'package:novindus_feed_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:novindus_feed_app/features/home/data/datasources/home_remote_datasource_impl.dart';
import 'package:novindus_feed_app/features/home/domain/repositories/home_repository.dart';
import 'package:novindus_feed_app/features/home/domain/repositories/home_repository_impl.dart';
import 'package:novindus_feed_app/features/home/presentation/providers/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => DioClient());
  sl.registerFactory(() => AuthProvider(authRepository: sl()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), sharedPreferences: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: sl()),
  );
  sl.registerFactory(() => HomeProvider(homeRepository: sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dioClient: sl()),
  );
 sl.registerFactory(
    () => FeedProvider(feedRepository: sl(), homeRepository: sl()),
  );

  
  sl.registerLazySingleton<FeedRepository>(
    () => FeedRepositoryImpl(remoteDataSource: sl()),
  );

  
  sl.registerLazySingleton<FeedRemoteDataSource>(
    () => FeedRemoteDataSourceImpl(dioClient: sl()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
}
