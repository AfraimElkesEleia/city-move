import 'package:city_move/core/routing/router.dart';
import 'package:city_move/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route<dynamic>? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: const Center(child: Text("No Route"))),
        );
    }
  }
}
