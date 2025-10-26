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

class HomeSurveysLoadedError extends HomeState {
  final String message;
  const HomeSurveysLoadedError({required this.message});
}

class HomeSurveysDeletedSuccess extends HomeState {}

final class HomeLoggedOutSuccess extends HomeState {}
