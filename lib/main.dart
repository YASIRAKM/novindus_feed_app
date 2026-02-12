import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/utils/snack_bar_utils.dart';
import 'package:novindus_feed_app/features/add_feed/presentation/providers/add_feed_provider.dart';
import 'package:novindus_feed_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:novindus_feed_app/features/feed/presentation/providers/feed_provider.dart';
import 'package:novindus_feed_app/features/home/presentation/providers/home_provider.dart';
import 'package:novindus_feed_app/core/routes/routes.dart';
import 'package:novindus_feed_app/core/routes/app_router.dart';
import 'package:novindus_feed_app/injection_container.dart' as di;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<HomeProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<FeedProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<AddFeedProvider>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: SnackbarUtils.messengerKey,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        initialRoute: Routes.login,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
