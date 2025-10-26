part 'survey_question_model.dart';

class SurveyModel {
  final String id;
  final String title;
  final String description;
  final String? authorId;
  final String code;
  final int createdAt;
  final List<SurveyQuestionModel> questions;

  SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    required this.code,
    required this.createdAt,
    required this.questions,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
    id: json['id'] ?? '',
    title: json['title'],
    description: json['description'],
    authorId: json['authorId'],
    code: json['code'],
    createdAt: json['createdAt'],
    questions: List<SurveyQuestionModel>.from(
      json['questions'].map((x) => SurveyQuestionModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'description': description,
    'authorId': authorId,
    'code': code,
    'createdAt': createdAt,
    'questions': List<dynamic>.from(
      questions.map((SurveyQuestionModel question) => question.toJson()),
    ),
  };
}
