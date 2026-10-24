import 'package:city_move/core/routing/router.dart';
import 'package:city_move/features/login/presentation/login_screen.dart';
import 'package:city_move/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:city_move/core/helper/routing_extension.dart';

class AppRouter {
  Route<dynamic>? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(
            onFinished: () {
              context.pushNamedAndRemoveUntil(Routes.loginScreen);
            },
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: const Center(child: Text("No Route"))),
        );
    }
  }
}
