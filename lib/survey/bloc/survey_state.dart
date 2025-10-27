part of 'survey_bloc.dart';

sealed class SurveyState extends Equatable {
  const SurveyState();

  @override
  List<Object> get props => <Object>[];
}

final class SurveyInitial extends SurveyState {}

final class SurveyInProgress extends SurveyState {}

final class SurveyCreationSuccess extends SurveyState {}

final class SurveyUpdatedSuccess extends SurveyState {}

final class SurveyCreationError extends SurveyState {
  final String message;

  const SurveyCreationError({required this.message});
}
