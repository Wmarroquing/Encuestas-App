part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => <Object>[];
}

class SubscribeSurveys extends HomeEvent {}

class SubscribeCompleteSurveys extends HomeEvent {}

class SurveysUpdatedEvent extends HomeEvent {
  final List<SurveyModel> surveys;
  const SurveysUpdatedEvent({required this.surveys});
}

class CompleteSurveysUpdatedEvent extends HomeEvent {
  final List<SurveyModel> surveys;
  const CompleteSurveysUpdatedEvent({required this.surveys});
}

class SurveysErrorEvent extends HomeEvent {
  final String message;
  const SurveysErrorEvent({required this.message});
}

class SurveyDeletedEvent extends HomeEvent {
  final String surveyId;
  const SurveyDeletedEvent({required this.surveyId});
}

class CompleteSurveyDeletedEvent extends HomeEvent {
  final String surveyId;
  const CompleteSurveyDeletedEvent({required this.surveyId});
}

class SurveyGetByCodeEvent extends HomeEvent {
  final String code;
  final List<SurveyModel> currentSurveys;

  const SurveyGetByCodeEvent({
    required this.code,
    required this.currentSurveys,
  });
}

class FirebaseAuthLoggedOut extends HomeEvent {}
