import 'package:flutter/material.dart';
import 'package:personal_home/core/presentation/home/home_default.dart';

Route onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
    case 'home':
      return MaterialPageRoute(
          builder: (context) => const HomeDefaultPage(title: 'Test Routing'));
    default:
      return MaterialPageRoute(builder: ((context) {
        return const Scaffold(
          body: Center(
            child: Text("No Routes Found"),
          ),
        );
      }));
  }
}
