import 'dart:convert';

import 'package:devel_app/common/model/survey_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseLoginServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _firebaseDB = FirebaseDatabase.instance.ref();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<SurveyModel?> getSurveyByCode({required String code}) async {
    final DataSnapshot apiResp = await _firebaseDB.child('surveys/$code').get();

    if (!apiResp.exists) return null;

    final Map<String, dynamic> data =
        jsonDecode(jsonEncode(apiResp.value)) as Map<String, dynamic>;

    return SurveyModel.fromJson(data);
  }
}
