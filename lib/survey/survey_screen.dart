import 'package:devel_app/common/model/survey_args.dart';
import 'package:devel_app/survey/bloc/survey_bloc.dart';
import 'package:devel_app/survey/widgets/survey_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurveyScreen extends StatelessWidget {
  final SurveyArgs surveyArgs;

  const SurveyScreen({super.key, required this.surveyArgs});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SurveyBloc>(
      create: (BuildContext context) => SurveyBloc(),
      child: SurveyBody(surveyArgs: surveyArgs),
    );
  }
}
