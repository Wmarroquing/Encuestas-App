import 'package:devel_app/common/dialogs/custom_alert_dialog.dart';
import 'package:devel_app/common/dialogs/survey_code_modal.dart';
import 'package:devel_app/common/loader/custom_loader.dart';
import 'package:devel_app/common/model/survey_args.dart';
import 'package:devel_app/common/model/survey_model.dart';
import 'package:devel_app/common/resources/app_constants.dart';
import 'package:devel_app/common/routes/landing_routes.dart';
import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:devel_app/common/validations/email_validator.dart';
import 'package:devel_app/common/validations/empty_field_validator.dart';
import 'package:devel_app/login/bloc/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_form.dart';

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
  final TextEditingController _codeController = TextEditingController();

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        switch (state) {
          case UserAuthenticated(:final User user):
            Navigator.of(context).pushNamedAndRemoveUntil(
              LandingRoutes.homeRoute,
              arguments: user,
              (Route<dynamic> route) => false,
            );
            break;
          case UserUnauthenticated(:final String message):
            _showExceptionMessage(message);
            break;
          case LoginException(:final String message):
            _showExceptionMessage(message);
          case SurveyObtainedSuccess(:final SurveyModel survey):
            Navigator.pushNamed(
              context,
              LandingRoutes.surveyRoute,
              arguments: SurveyArgs(isOnlyView: false, surveyModel: survey),
            );
            break;
          default:
        }
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: CustomColors.background,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppConstants.appPadding),
                child: Column(
                  spacing: 30.0,
                  children: <Widget>[
                    Image.asset(
                      '${AppConstants.imagesPath}logo.jpg',
                      height: 150.0,
                    ),
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
                      children: <Widget>[
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
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (BuildContext context, LoginState state) {
              if (state is AuthentincationInProgress) {
                return const CustomLoader();
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  void _loginWithFirebase() {
    if (_loginFormKey.currentState!.validate()) {
      _loginBloc.add(
        FirebaseAuthLoggedIn(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  void _verifySurveyCode() {
    if (_surveyFormKey.currentState!.validate()) {
      Navigator.pop(context);
      _loginBloc.add(FirebaseGetSurveyByCode(code: _codeController.text));
    }
  }

  void _openSurveyCodeModal() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SurveyCodeModal(
          surveyFormKey: _surveyFormKey,
          codeController: _codeController,
          fnOnPressButton: _verifySurveyCode,
        );
      },
    );
  }

  void _showExceptionMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Ocurrió un error',
          description: message,
        );
      },
    );
  }
}
