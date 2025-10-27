import 'package:devel_app/common/model/survey_model.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  final DatabaseReference _firebaseDB = FirebaseDatabase.instance.ref();

  Future<void> createSurvey({required SurveyModel survey}) async {
    await _firebaseDB.child('surveys/${survey.code}').set(survey.toJson());
  }

  Future<void> updateSurvey({required SurveyModel updatedSurvey}) async {
    await _firebaseDB
        .child('surveys/${updatedSurvey.id}')
        .set(updatedSurvey.toJson());
  }
}
