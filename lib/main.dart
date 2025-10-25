import 'package:devel_app/common/resources/app_constants.dart';
import 'package:devel_app/common/routes/landing_routes.dart';
import 'package:devel_app/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class SurveyApp extends StatelessWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: CustomTheme.lightTheme,
      initialRoute: LandingRoutes.loginRoute,
      onGenerateRoute: LandingRoutes.appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
