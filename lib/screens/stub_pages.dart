import 'package:flutter/material.dart';

/// Shared placeholder screen for routes that exist for navigation but
/// have no real content built yet. Honest stand-in rather than pretending
/// these are finished - see README "Known issues and next steps".
class _StubPage extends StatelessWidget {
  final String title;
  final String description;

  const _StubPage({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.construction, size: 48, color: Colors.grey),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) => const _StubPage(
        title: 'Register',
        description: 'Account registration is not built yet. '
            'This screen is a placeholder for now.',
      );
}

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  @override
  Widget build(BuildContext context) => const _StubPage(
        title: 'Forgot Password',
        description: 'Password recovery is not built yet. '
            'This screen is a placeholder for now.',
      );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => const _StubPage(
        title: 'Settings',
        description: 'Settings are not built yet. '
            'This screen is a placeholder for now.',
      );
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const _StubPage(
        title: 'Edit Profile',
        description: 'Profile editing is not built yet. '
            'This screen is a placeholder for now.',
      );
}
