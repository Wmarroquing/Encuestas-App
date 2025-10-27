import 'package:devel_app/common/model/survey_args.dart';
import 'package:devel_app/common/model/survey_model.dart';
import 'package:devel_app/home/home_screen.dart';
import 'package:devel_app/login/login_screen.dart';
import 'package:devel_app/survey/survey_screen.dart';
import 'package:devel_app/surveyAdmin/survey_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingRoutes {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String surveyAdminRoute = '/surveyAdmin';
  static const String surveyRoute = '/survey';

  static Route<dynamic> appRoutes(final RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute<LoginScreen>(
          builder: (_) => const LoginScreen(),
        );
      case homeRoute:
        return MaterialPageRoute<HomeScreen>(
          builder: (_) => HomeScreen(authenticatedUser: args! as User),
        );
      case surveyRoute:
        return MaterialPageRoute<SurveyScreen>(
          builder: (_) => SurveyScreen(surveyArgs: args! as SurveyArgs),
        );
      case surveyAdminRoute:
        return MaterialPageRoute<SurveyAdminScreen>(
          builder: (_) => SurveyAdminScreen(survey: args as SurveyModel?),
        );
      default:
        return MaterialPageRoute<dynamic>(builder: (_) => Container());
    }
  }
}
