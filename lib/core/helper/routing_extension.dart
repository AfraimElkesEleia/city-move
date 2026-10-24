import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void pushNamed(String route,{Object? arguments}) {
    Navigator.of(this).pushNamed(route,arguments: arguments);
  }

  void pushReplacementNamed(String route,{Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(route,arguments: arguments);
  }

  void popAndPushNamed(String route,{Object? arguments}) {
    Navigator.of(this).popAndPushNamed(route,arguments: arguments);
  }

  void popUntilRouteName(String routeName) {
    Navigator.of(this).popUntil((route) => route.settings.name == routeName);
  }

  void pushNamedAndRemoveUntil(String routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => route.settings.name == routeName,
    );
  }
}