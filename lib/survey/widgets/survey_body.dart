import 'package:devel_app/common/dialogs/custom_alert_dialog.dart';
import 'package:devel_app/common/resources/app_constants.dart';
import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:devel_app/common/validations/empty_field_validator.dart';
import 'package:devel_app/survey/model/survey_model.dart';
import 'package:flutter/material.dart';

part 'app_bar.dart';
part 'bottom_sheet.dart';
part 'survey_title_form.dart';
part 'survey_fields_list.dart';
part 'survey_field_form.dart';

class SurveyBody extends StatefulWidget {
  const SurveyBody({super.key});

  @override
  State<SurveyBody> createState() => _SurveyBodyState();
}

class _SurveyBodyState extends State<SurveyBody> {
  final GlobalKey<FormState> _surveyFormKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<SurveyQuestionModel> _questionsFields = <SurveyQuestionModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SurveyAppBar(),
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
        fnOnCancelPressed: _showConfirmCancelSurvey,
        fnOnCreatePressed: _generateNewSurveyForm,
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
    }
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
}
