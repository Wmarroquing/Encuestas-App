import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devel_app/common/model/survey_request.dart';
import 'package:devel_app/home/service/firebase_service.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<SubscribeSurveys>(_onSubscribeSurveys);
    on<SurveysUpdatedEvent>(_onSurveysUpdated);
    on<SurveysErrorEvent>(_onSurveysError);
    on<SurveyDeletedEvent>(_onSurveyDeleted);
    on<FirebaseAuthLoggedOut>(_onLoggedOut);
  }

  final FirebaseService _firebaseService = FirebaseService();
  StreamSubscription? _surveySubscription;

  Future<void> _onSubscribeSurveys(
    SubscribeSurveys event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeInProgress());

    await _surveySubscription?.cancel();

    _surveySubscription = _firebaseService.getSurveys().listen(
      (List<SurveyModel> surveys) => add(SurveysUpdatedEvent(surveys: surveys)),
      onError: (error) => add(SurveysErrorEvent(message: error.toString())),
    );
  }

  Future<void> _onSurveyDeleted(
    SurveyDeletedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeInProgress());
    try {
      await _firebaseService.deleteSurvey(surveyId: event.surveyId);
    } catch (_) {
      emit(HomeSurveysLoadedError(message: 'Error al eliminar encuesta'));
    }
  }

  void _onSurveysUpdated(SurveysUpdatedEvent event, Emitter<HomeState> emit) {
    emit(HomeSurveysLoadedSuccess(surveys: event.surveys));
  }

  void _onSurveysError(SurveysErrorEvent event, Emitter<HomeState> emit) {
    emit(HomeSurveysLoadedError(message: event.message));
  }

  Future<void> _onLoggedOut(
    FirebaseAuthLoggedOut event,
    Emitter<HomeState> emit,
  ) async {
    await _firebaseService.signOut();
    emit(HomeLoggedOutSuccess());
  }

  @override
  Future<void> close() {
    _surveySubscription?.cancel();
    return super.close();
  }
}
