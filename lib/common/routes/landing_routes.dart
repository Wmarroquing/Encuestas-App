import 'package:devel_app/home/home_screen.dart';
import 'package:devel_app/login/login_screen.dart';
import 'package:flutter/material.dart';

class LandingRoutes {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String surveyRoute = '/survey';

  static Route<dynamic> appRoutes(final RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute<LoginScreen>(
          builder: (_) => const LoginScreen(),
        );
      case homeRoute:
        return MaterialPageRoute<HomeScreen>(
          builder: (_) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
