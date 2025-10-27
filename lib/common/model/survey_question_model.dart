part of 'survey_model.dart';

class SurveyQuestionModel {
  final int id;
  final String text;
  final String type;
  final List<String> options;
  dynamic answer;
  bool isRequired;

  SurveyQuestionModel({
    required this.id,
    required this.text,
    required this.type,
    required this.options,
    this.answer,
    this.isRequired = false,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'text': text,
    'type': type,
    'answer': answer,
    'isRequired': isRequired,
    'options': List<dynamic>.from(options.map((String option) => option)),
  };

  factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) =>
      SurveyQuestionModel(
        id: json['id'],
        text: json['text'],
        type: json['type'],
        answer: json['answer'],
        options:
            json['options'] != null
                ? List<String>.from(json['options'])
                : <String>[],
        isRequired: json['isRequired'],
      );
}
