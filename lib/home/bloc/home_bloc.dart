import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devel_app/common/model/survey_model.dart';
import 'package:devel_app/home/service/firebase_service.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<SubscribeSurveys>(_onSubscribeSurveys);
    on<SubscribeCompleteSurveys>(_onSubscribeCompleteSurveys);
    on<SurveysUpdatedEvent>(_onSurveysUpdated);
    on<CompleteSurveysUpdatedEvent>(_onCompleteSurveysUpdated);
    on<SurveysErrorEvent>(_onSurveysError);
    on<SurveyDeletedEvent>(_onSurveyDeleted);
    on<SurveyGetByCodeEvent>(_onSurveyObtained);
    on<FirebaseAuthLoggedOut>(_onLoggedOut);
  }

  final FirebaseService _firebaseService = FirebaseService();
  StreamSubscription? _surveySubscription;
  StreamSubscription? _completeSurveySubscription;

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

  Future<void> _onSubscribeCompleteSurveys(
    SubscribeCompleteSurveys event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeInProgress());

    await _completeSurveySubscription?.cancel();

    _completeSurveySubscription = _firebaseService.getCompleteSurveys().listen(
      (List<SurveyModel> surveys) =>
          add(CompleteSurveysUpdatedEvent(surveys: surveys)),
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
      emit(HomeSurveysException(message: 'Error al eliminar encuesta'));
    }
  }

  void _onSurveysUpdated(SurveysUpdatedEvent event, Emitter<HomeState> emit) {
    emit(HomeSurveysLoadedSuccess(surveys: event.surveys));
  }

  void _onCompleteSurveysUpdated(
    CompleteSurveysUpdatedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeCompleteSurveysLoadedSuccess(surveys: event.surveys));
  }

  void _onSurveysError(SurveysErrorEvent event, Emitter<HomeState> emit) {
    emit(HomeSurveysException(message: event.message));
  }

  Future<void> _onSurveyObtained(
    SurveyGetByCodeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeInProgress());
    try {
      final int surveyIndex = event.currentSurveys.indexWhere(
        (SurveyModel survey) => survey.code.contains(event.code),
      );
      if (surveyIndex == -1) {
        emit(HomeSurveysException(message: 'La enuesta no existe'));
      } else {
        emit(SurveyObtainedSuccess(survey: event.currentSurveys[surveyIndex]));
      }
    } catch (_) {
      emit(HomeSurveysException(message: 'Ocurrió un error inesperado'));
    }
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
    _completeSurveySubscription?.cancel();
    return super.close();
  }
}
