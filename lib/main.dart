import 'package:city_move/core/routing/app_router.dart';
import 'package:city_move/core/routing/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CityMove());
}

class CityMove extends StatelessWidget {
  const CityMove({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().onGenerate,
      initialRoute: Routes.splashScreen,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black
      ),
    );
  }
}

