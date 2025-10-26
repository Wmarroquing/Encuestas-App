part of 'survey_request.dart';

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
    required this.options,
    this.isRequired = false,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'text': text,
    'type': type,
    'isRequired': isRequired,
    'options': List<dynamic>.from(options.map((String option) => option)),
  };

  factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) =>
      SurveyQuestionModel(
        id: json['id'],
        text: json['text'],
        type: json['type'],
        options:
            json['options'] != null
                ? List<String>.from(json['options'])
                : <String>[],
        isRequired: json['isRequired'],
      );
}
