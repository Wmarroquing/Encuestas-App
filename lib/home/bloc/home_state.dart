part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => <Object>[];
}

final class HomeInitial extends HomeState {}

final class HomeInProgress extends HomeState {}

class HomeSurveysLoadedSuccess extends HomeState {
  final List<SurveyModel> surveys;
  const HomeSurveysLoadedSuccess({required this.surveys});
}

class HomeCompleteSurveysLoadedSuccess extends HomeState {
  final List<SurveyModel> surveys;
  const HomeCompleteSurveysLoadedSuccess({required this.surveys});
}

class HomeSurveysException extends HomeState {
  final String message;
  const HomeSurveysException({required this.message});
}

final class SurveyObtainedSuccess extends HomeState {
  final SurveyModel survey;
  const SurveyObtainedSuccess({required this.survey});
}

class HomeSurveysDeletedSuccess extends HomeState {}

final class HomeLoggedOutSuccess extends HomeState {}
