import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/utils/snack_bar_utils.dart';
import 'package:novindus_feed_app/features/auth/presentation/pages/login_screen.dart';
import 'package:novindus_feed_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:novindus_feed_app/features/feed/presentation/pages/my_feeds_screen.dart';
import 'package:novindus_feed_app/features/feed/presentation/providers/feed_provider.dart';
import 'package:novindus_feed_app/features/home/presentation/pages/home_screen.dart';
import 'package:novindus_feed_app/features/home/presentation/providers/home_provider.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: SnackbarUtils.messengerKey,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LoginScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/my_feeds': (context) => const MyFeedsScreen(),
        },
      ),
    );
  }
}
