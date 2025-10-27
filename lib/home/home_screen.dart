import 'package:devel_app/home/bloc/home_bloc.dart';
import 'package:devel_app/home/widgets/home_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final User authenticatedUser;

  const HomeScreen({super.key, required this.authenticatedUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(),
      child: HomeBody(authenticatedUser: authenticatedUser),
    );
  }
}
