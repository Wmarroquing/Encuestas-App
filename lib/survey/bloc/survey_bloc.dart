import 'package:bloc/bloc.dart';
import 'package:devel_app/common/model/survey_model.dart';
import 'package:devel_app/survey/service/survey_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  SurveyBloc() : super(SurveyInitial()) {
    on<SurveyCreationRequested>(_onCreateSurvey);
    on<SurveyUpdatedRequested>(_onUpdateSurvey);
  }

  final SurveyService _surveyService = SurveyService();

  Future<void> _onCreateSurvey(
    SurveyCreationRequested event,
    Emitter<SurveyState> emit,
  ) async {
    emit(SurveyInProgress());
    try {
      await _surveyService.createSurvey(survey: event.surveyModel);
      emit(SurveyCreationSuccess());
    } on FirebaseException catch (exception) {
      emit(SurveyCreationError(message: exception.message ?? 'Error'));
    } catch (_) {
      emit(SurveyCreationError(message: 'Ocurrió un error inesperado'));
    }
  }

  Future<void> _onUpdateSurvey(
    SurveyUpdatedRequested event,
    Emitter<SurveyState> emit,
  ) async {
    emit(SurveyInProgress());
    try {
      await _surveyService.updateSurvey(updatedSurvey: event.updatedSurvey);
      emit(SurveyUpdatedSuccess());
    } catch (_) {
      emit(SurveyCreationError(message: 'Error al actualizar encuesta'));
    }
  }
}
