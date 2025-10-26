part of 'survey_model.dart';

class SurveyQuestionModel {
  final int id;
  final String text;
  final String type;
  bool isRequired;
  final List<String> options;

  SurveyQuestionModel({
    required this.id,
    required this.text,
    required this.type,
    this.isRequired = false,
    required this.options,
  });

  factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) =>
      SurveyQuestionModel(
        id: json['id'],
        text: json['text'],
        type: json['type'],
        isRequired: json['isRequired'],
        options: List<String>.from(json['options'].map((option) => option)),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'text': text,
    'type': type,
    'options': List<dynamic>.from(options.map((String option) => option)),
  };
}
