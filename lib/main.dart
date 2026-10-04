import 'package:flutter/material.dart';
import 'screens/course_page.dart';
import 'screens/form_page.dart';
import 'screens/login_page.dart';
import 'screens/profile_page.dart';
import 'screens/reviews_page.dart';
import 'screens/stub_pages.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/home': (context) => const CoursePage(),
        '/reviews': (context) => const ReviewsPage(),
        '/profile': (context) => const ProfilePage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/form': (context) => const FormPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
