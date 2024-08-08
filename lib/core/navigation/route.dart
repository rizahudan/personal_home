import 'package:flutter/material.dart';
import 'package:personal_home/presentation/page/form_device_page.dart';
import 'package:personal_home/presentation/page/home_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case FormDevicePage.routeName:
        return MaterialPageRoute(builder: (context) => FormDevicePage());
      default:
        return MaterialPageRoute(builder: ((ctx) {
          return const Scaffold(
            body: Center(
              child: Text("No Routes Found"),
            ),
          );
        }));
    }
  }
}
