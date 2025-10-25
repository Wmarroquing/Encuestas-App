import 'package:devel_app/common/resources/app_constants.dart';
import 'package:devel_app/common/routes/landing_routes.dart';
import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:devel_app/common/validations/email_validator.dart';
import 'package:devel_app/common/validations/empty_field_validator.dart';
import 'package:flutter/material.dart';

part 'login_form.dart';
part 'survey_code_modal.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _surveyFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppConstants.appPadding),
          child: Column(
            spacing: 30.0,
            children: [
              Image.asset('${AppConstants.imagesPath}logo.jpg', height: 150.0),
              Text(
                'Encuestas ACME',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              LoginForm(
                loginFormKey: _loginFormKey,
                emailController: _emailController,
                passwordController: _passwordController,
                fnOnPressButton: _loginWithFirebase,
              ),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('Completa una encuesta'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              OutlinedButton.icon(
                onPressed: _openSurveyCodeModal,
                label: Text('Completar de forma anónima'),
                icon: Icon(Icons.person_off),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginWithFirebase() {
    if (_loginFormKey.currentState!.validate()) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        LandingRoutes.homeRoute,
        (Route<dynamic> route) => false,
      );
    }
  }

  void _verifySurveyCode() {
    if (_surveyFormKey.currentState!.validate()) {
      Navigator.pop(context);
    }
  }

  void _openSurveyCodeModal() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SurveyCodeModal(
          surveyFormKey: _surveyFormKey,
          fnOnPressButton: _verifySurveyCode,
        );
      },
    );
  }
}
