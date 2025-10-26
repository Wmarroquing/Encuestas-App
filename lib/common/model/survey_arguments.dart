import 'package:devel_app/common/model/survey_request.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SurveyArguments {
  final User authenticatedUser;
  final SurveyModel? surveyModel;

  SurveyArguments({required this.authenticatedUser, this.surveyModel});
}
