import 'package:devel_app/common/model/survey_model.dart';

class SurveyArgs {
  final String? surveyId;
  final bool isOnlyView;
  final SurveyModel surveyModel;

  SurveyArgs({
    this.surveyId,
    required this.isOnlyView,
    required this.surveyModel,
  });
}
