import 'package:devel_app/common/model/survey_model.dart';
import 'package:devel_app/common/validations/empty_field_validator.dart';
import 'package:flutter/material.dart';

class SurveyQuestions extends StatefulWidget {
  final GlobalKey<FormState> surveyFormKey;
  final List<SurveyQuestionModel> questions;
  final bool isOnlyView;

  const SurveyQuestions({
    super.key,
    required this.surveyFormKey,
    required this.questions,
    required this.isOnlyView,
  });

  @override
  State<SurveyQuestions> createState() => _SurveyQuestionsState();
}

class _SurveyQuestionsState extends State<SurveyQuestions> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.surveyFormKey,
      child: ListView(
        children: List<Widget>.generate(widget.questions.length, (int index) {
          final SurveyQuestionModel currentQuestion = widget.questions[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 22.0,
                horizontal: 12.0,
              ),
              child: Column(
                spacing: 10.0,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${currentQuestion.text} ${currentQuestion.isRequired ? '*' : ''}',
                  ),
                  _handleQuestionType(question: currentQuestion),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _handleQuestionType({required SurveyQuestionModel question}) {
    switch (question.type) {
      case 'text':
        return TextFormField(
          enabled: !widget.isOnlyView,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: question.answer ?? 'Ingresa tu respuesta',
          ),
          validator: question.isRequired ? emptyFieldValidator : null,
          onChanged: (String value) => question.answer = value,
        );
      case 'boolean':
        return SwitchListTile(
          title: Text(question.text),
          value: question.answer ?? false,
          onChanged:
              widget.isOnlyView
                  ? null
                  : (bool value) {
                    setState(() => question.answer = value);
                  },
        );
      case 'number':
        return TextFormField(
          enabled: !widget.isOnlyView,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: question.answer ?? 'Ingresa un valor numerico',
          ),
          validator: question.isRequired ? emptyFieldValidator : null,
          onChanged: (String value) => question.answer = value,
        );
      case 'option':
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: question.answer ?? 'Selecciona una opción',
          ),
          items:
              question.options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
          onChanged:
              widget.isOnlyView
                  ? null
                  : (String? value) => question.answer = value,
          validator: question.isRequired ? emptyFieldValidator : null,
        );
      default:
        return Container();
    }
  }
}
