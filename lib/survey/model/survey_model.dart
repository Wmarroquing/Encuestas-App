part 'survey_question_model.dart';

class SurveyModel {
  final String title;
  final String description;
  final String authorId;
  final int createdAt;
  final List<SurveyQuestionModel> questions;

  SurveyModel({
    required this.title,
    required this.description,
    required this.authorId,
    required this.createdAt,
    required this.questions,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
    title: json['title'],
    description: json['description'],
    authorId: json['authorId'],
    createdAt: json['createdAt'],
    questions: List<SurveyQuestionModel>.from(
      json['questions'].map((x) => SurveyQuestionModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'description': description,
    'authorId': authorId,
    'createdAt': createdAt,
    'questions': List<dynamic>.from(
      questions.map((SurveyQuestionModel x) => x.toJson()),
    ),
  };
}
