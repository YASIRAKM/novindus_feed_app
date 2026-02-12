import 'package:get_it/get_it.dart';

import 'package:novindus_feed_app/core/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  
  sl.registerLazySingleton(() => DioClient());

 
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}