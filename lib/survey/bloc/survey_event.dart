part of 'survey_bloc.dart';

sealed class SurveyEvent extends Equatable {
  const SurveyEvent();

  @override
  List<Object> get props => <Object>[];
}

final class SurveyCreationRequested extends SurveyEvent {
  final SurveyModel surveyModel;

  const SurveyCreationRequested({required this.surveyModel});
}

final class SurveyUpdatedRequested extends SurveyEvent {
  final SurveyModel updatedSurvey;

  const SurveyUpdatedRequested({required this.updatedSurvey});
}
