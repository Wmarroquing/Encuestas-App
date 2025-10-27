import 'dart:convert';

import 'package:devel_app/common/model/survey_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _firebaseDB = FirebaseDatabase.instance.ref();

  Stream<List<SurveyModel>> getSurveys() {
    return _firebaseDB.child('surveys').onValue.map((DatabaseEvent event) {
      final Object? apiResponse = event.snapshot.value;
      if (apiResponse == null) return <SurveyModel>[];

      final Map<Object?, Object?> parse = apiResponse as Map<Object?, Object?>;
      return parse.entries.map((MapEntry<Object?, Object?> entry) {
        final Map<String, dynamic> surveyMap =
            jsonDecode(jsonEncode(entry.value)) as Map<String, dynamic>;
        surveyMap['id'] = entry.key;
        return SurveyModel.fromJson(surveyMap);
      }).toList();
    });
  }

  Stream<List<SurveyModel>> getCompleteSurveys() {
    return _firebaseDB.child('completeSurveys').onValue.map((
      DatabaseEvent event,
    ) {
      final Object? apiResponse = event.snapshot.value;
      if (apiResponse == null) return <SurveyModel>[];

      final Map<Object?, Object?> parse = apiResponse as Map<Object?, Object?>;
      return parse.entries.map((MapEntry<Object?, Object?> entry) {
        final Map<String, dynamic> surveyMap =
            jsonDecode(jsonEncode(entry.value)) as Map<String, dynamic>;
        surveyMap['id'] = entry.key;
        return SurveyModel.fromJson(surveyMap);
      }).toList();
    });
  }

  Future<void> deleteSurvey({required String surveyId}) async {
    await _firebaseDB.child('surveys/$surveyId').remove();
  }

  Future<void> deleteCompleteSurvey({required String surveyId}) async {
    await _firebaseDB.child('completeSurveys/$surveyId').remove();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
