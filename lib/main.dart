import 'package:flutter/material.dart';
import 'screens/course_page.dart';
import 'theme.dart';

void main() {
  runApp(const RateMyProfessorHauApp());
}

class RateMyProfessorHauApp extends StatelessWidget {
  const RateMyProfessorHauApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RateMyProfessorHAU',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const CoursePage(),
    );
  }
}
