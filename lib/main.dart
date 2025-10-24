import 'package:devel_app/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SurveyApp());
}

class SurveyApp extends StatelessWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devel Systems S.A',
      theme: CustomTheme.lightTheme,
      home: Example(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          spacing: 16.0,
          children: [
            Image.asset('assets/images/logo.jpg'),
            Text('data'),
            TextFormField(),
            ElevatedButton(onPressed: () {}, child: Text('button')),
            OutlinedButton(onPressed: () {}, child: Text('button')),
          ],
        ),
      ),
    );
  }
}
