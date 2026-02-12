import 'package:flutter/material.dart';
import '../../features/add_feed/presentation/pages/add_feed_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/feed/presentation/pages/my_feeds_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import 'routes.dart';

import '../../features/splash/presentation/pages/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.myFeeds:
        return MaterialPageRoute(builder: (_) => const MyFeedsScreen());
      case Routes.addFeed:
        return MaterialPageRoute(builder: (_) => const AddFeedScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
