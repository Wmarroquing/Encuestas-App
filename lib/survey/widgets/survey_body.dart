import 'dart:math';

import 'package:devel_app/common/dialogs/custom_alert_dialog.dart';
import 'package:devel_app/common/loader/custom_loader.dart';
import 'package:devel_app/common/resources/app_constants.dart';
import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:devel_app/common/validations/empty_field_validator.dart';
import 'package:devel_app/survey/bloc/survey_bloc.dart';
import 'package:devel_app/common/model/survey_request.dart';
import 'package:devel_app/common/model/survey_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_bar.dart';
part 'bottom_sheet.dart';
part 'survey_title_form.dart';
part 'survey_fields_list.dart';
part 'survey_field_form.dart';

class SurveyBody extends StatefulWidget {
  final SurveyArguments surveyArguments;
  const SurveyBody({super.key, required this.surveyArguments});

  @override
  State<SurveyBody> createState() => _SurveyBodyState();
}

class _SurveyBodyState extends State<SurveyBody> {
  final GlobalKey<FormState> _surveyFormKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<SurveyQuestionModel> _questionsFields = <SurveyQuestionModel>[];

  late SurveyBloc _surveyBloc;
  bool _isEditView = false;

  @override
  void initState() {
    super.initState();
    _surveyBloc = context.read<SurveyBloc>();
    if (widget.surveyArguments.surveyModel != null) {
      final SurveyModel editSurvey = widget.surveyArguments.surveyModel!;
      setState(() {
        _isEditView = true;
        _titleController.text = editSurvey.title;
        _descriptionController.text = editSurvey.description;
        _questionsFields.clear();
        _questionsFields.addAll(editSurvey.questions);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SurveyBloc, SurveyState>(
      listener: (BuildContext context, SurveyState state) {
        switch (state) {
          case SurveyCreationSuccess(:final String accessCode):
            Navigator.pop(context);
            _showSurveyCreatedDialog(accessCode);
            break;
          case SurveyUpdatedSuccess():
            Navigator.pop(context);
            _showAlertDialog(
              title: 'Completado',
              message: 'Encuesta editada correctamente',
            );
            break;
          case SurveyCreationError(:final String message):
            _showAlertDialog(title: 'Error de creación', message: message);
            break;
          default:
        }
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: SurveyAppBar(isEditView: _isEditView),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(AppConstants.appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SurveyTitleForm(
                    surveyFormKey: _surveyFormKey,
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                  ),
                  OutlinedButton.icon(
                    onPressed: _showSurveyFieldModal,
                    label: Text('Agregar campo'),
                    icon: Icon(Icons.add),
                  ),
                  SurveyFieldsList(
                    questionsFields: _questionsFields,
                    fnOnEditPressed: _showSurveyFieldModal,
                    fnOnDeletePressed: _removeSurveyField,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomSheet(
              isEditView: _isEditView,
              fnOnCancelPressed: _showConfirmCancelSurvey,
              fnOnCreatePressed: _generateNewSurveyForm,
            ),
          ),
          BlocBuilder<SurveyBloc, SurveyState>(
            builder: (BuildContext context, SurveyState state) {
              if (state is SurveyInProgress) {
                return const CustomLoader();
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  void _showSurveyFieldModal([SurveyQuestionModel? questionField]) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SurveyFieldForm(
          questionField: questionField,
          fnOnAddPressed: _createNewSurveyField,
          fnOnEditPressed: _editSurveyField,
        );
      },
    );
  }

  void _createNewSurveyField(SurveyQuestionModel newField) {
    setState(() {
      _questionsFields.add(newField);
    });
  }

  void _editSurveyField(SurveyQuestionModel edittedField) {
    final int index = _questionsFields.indexWhere(
      (SurveyQuestionModel field) => field.id == edittedField.id,
    );
    if (index != -1) {
      setState(() {
        _questionsFields[index] = edittedField;
      });
    }
  }

  void _removeSurveyField(SurveyQuestionModel questionField) {
    setState(() {
      _questionsFields.remove(questionField);
    });
  }

  void _generateNewSurveyForm() {
    if (_surveyFormKey.currentState!.validate()) {
      if (_questionsFields.isEmpty) {
        _showNeedQuestionFieldsMessage();
        return;
      }
      if (_isEditView) {
        _editSurvey();
      } else {
        _createSurvey();
      }
    }
  }

  void _createSurvey() {
    final SurveyModel newSurveyForm = SurveyModel(
      id: '',
      title: _titleController.text,
      description: _descriptionController.text,
      authorId: widget.surveyArguments.authenticatedUser.email,
      code: _generateSurveyCode(),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      questions: _questionsFields,
    );
    _surveyBloc.add(SurveyCreationRequested(surveyModel: newSurveyForm));
  }

  void _editSurvey() {
    final SurveyModel updateSurveyForm = SurveyModel(
      id: widget.surveyArguments.surveyModel!.id,
      title: _titleController.text,
      description: _descriptionController.text,
      authorId: widget.surveyArguments.authenticatedUser.email,
      code: widget.surveyArguments.surveyModel!.code,
      createdAt: widget.surveyArguments.surveyModel!.createdAt,
      questions: _questionsFields,
    );
    _surveyBloc.add(SurveyUpdatedRequested(updatedSurvey: updateSurveyForm));
  }

  void _showConfirmCancelSurvey() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Descartar encuesta',
          description:
              'Deseas descartar esta encuesta? todos los datos se perderán',
          isConfirmDialog: true,
          fnOnConfirmPressed: () => Navigator.pop(context),
        );
      },
    );
  }

  void _showNeedQuestionFieldsMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Agrega campos a esta encuesta para poder continuar'),
      ),
    );
  }

  void _showSurveyCreatedDialog(String code) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CustomColors.background,
          title: Text('Encuesta creada', textAlign: TextAlign.center),
          content: Column(
            spacing: 16.0,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Tu código de acceso es:'),
              ListTile(
                title: Text(code),
                trailing: IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Texto copiado al portapapeles')),
                    );
                  },
                  icon: Icon(Icons.copy),
                ),
                titleTextStyle: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAlertDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(title: title, description: message);
      },
    );
  }

  String _generateSurveyCode() {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random rand = Random();
    return List<String>.generate(
      6,
      (_) => chars[rand.nextInt(chars.length)],
    ).join();
  }
}
