import 'package:devel_app/common/model/survey_model.dart';
import 'package:devel_app/surveyAdmin/bloc/survey_bloc.dart';
import 'package:devel_app/surveyAdmin/widgets/survey_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurveyAdminScreen extends StatelessWidget {
  final SurveyModel? survey;

  const SurveyAdminScreen({super.key, required this.survey});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SurveyBloc>(
      create: (BuildContext context) => SurveyBloc(),
      child: SurveyAdminBody(survey: survey),
    );
  }
}
