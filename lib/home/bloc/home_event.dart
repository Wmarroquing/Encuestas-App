part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => <Object>[];
}

class SubscribeSurveys extends HomeEvent {}

class SurveysUpdatedEvent extends HomeEvent {
  final List<SurveyModel> surveys;
  const SurveysUpdatedEvent({required this.surveys});
}

class SurveysErrorEvent extends HomeEvent {
  final String message;
  const SurveysErrorEvent({required this.message});
}

class SurveyDeletedEvent extends HomeEvent {
  final String surveyId;
  const SurveyDeletedEvent({required this.surveyId});
}

class FirebaseAuthLoggedOut extends HomeEvent {}
