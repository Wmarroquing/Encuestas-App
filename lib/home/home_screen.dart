import 'package:devel_app/home/widgets/home_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final User authenticatedUser;

  const HomeScreen({super.key, required this.authenticatedUser});

  @override
  Widget build(BuildContext context) {
    return HomeBody();
  }
}
