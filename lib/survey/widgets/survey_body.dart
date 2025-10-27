import 'package:devel_app/common/dialogs/custom_alert_dialog.dart';
import 'package:devel_app/common/model/survey_args.dart';
import 'package:devel_app/common/model/survey_model.dart';
import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:devel_app/survey/bloc/survey_bloc.dart';
import 'package:devel_app/survey/widgets/questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_bar.dart';
part 'bottom_sheet.dart';

class SurveyBody extends StatefulWidget {
  final SurveyArgs surveyArgs;

  const SurveyBody({super.key, required this.surveyArgs});

  @override
  State<SurveyBody> createState() => _SurveyBodyState();
}

class _SurveyBodyState extends State<SurveyBody> {
  final GlobalKey<FormState> _surveyFormKey = GlobalKey<FormState>();
  late SurveyModel _surveyAnswers;
  late SurveyBloc _surveyBloc;

  @override
  void initState() {
    super.initState();
    _surveyAnswers = widget.surveyArgs.surveyModel;
    _surveyBloc = context.read<SurveyBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SurveyBloc, SurveyState>(
      listener: (BuildContext context, SurveyState state) {
        switch (state) {
          case SurveyCreationSuccess():
            Navigator.pop(context);
            _showAlertDialog(
              title: 'Completada',
              message: 'Encuesta completada correctamente',
            );
            break;
          case SurveyUpdatedSuccess():
            Navigator.pop(context);
            _showAlertDialog(
              title: 'Editada',
              message: 'Encuesta editada correctamente',
            );
            break;
          case SurveyCreationError(:final String message):
            _showAlertDialog(title: 'Error de creación', message: message);
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: SurveyAppBar(
          surveyTitle: _surveyAnswers.title,
          surveySubtitile: _surveyAnswers.description,
        ),
        body: SurveyQuestions(
          surveyFormKey: _surveyFormKey,
          questions: _surveyAnswers.questions,
          isOnlyView: widget.surveyArgs.isOnlyView,
        ),
        bottomNavigationBar: SurveyBottomSheet(
          fnOnCompletePressed:
              widget.surveyArgs.isOnlyView ? null : _completeSurvey,
        ),
      ),
    );
  }

  void _completeSurvey() {
    if (_surveyFormKey.currentState!.validate()) {
      final SurveyModel newSurveyForm = SurveyModel(
        id: _surveyAnswers.id,
        title: _surveyAnswers.title,
        description: _surveyAnswers.description,
        code: _surveyAnswers.code,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        questions: _surveyAnswers.questions,
      );
      if (widget.surveyArgs.surveyId != null) {
        _surveyBloc.add(SurveyUpdatedRequested(updatedSurvey: newSurveyForm));
      } else {
        _surveyBloc.add(SurveyCreationRequested(surveyModel: newSurveyForm));
      }
    }
  }

  void _showAlertDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(title: title, description: message);
      },
    );
  }
}
