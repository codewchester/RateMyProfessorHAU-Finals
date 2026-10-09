import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/app_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  String? _errorText;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorText = 'Please enter both your email and password.');
      return;
    }

    if (!email.toLowerCase().endsWith('@student.hau.edu.ph')) {
      setState(() => _errorText = 'Use your @student.hau.edu.ph email address.');
      return;
    }

    setState(() => _errorText = null);
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Stack(
        children: [
          // Background placeholder standing in for the campus photo in
          // the mockup. No real asset has been added yet (see
          // SECURITY-CHECKLIST.md row 24 - no custom assets yet).
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFBFD7E6), Color(0xFFE8E2D5)],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/logo-login.png', height: 150, width: 150),
                      const SizedBox(height: AppSpacing.xs),
                      Text('Welcome, Angelite!', style: textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(
                        'Please enter your details',
                        style: textTheme.labelSmall,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      AppInputField(
                        label: 'HAU Email',
                        controller: _emailController,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      AppInputField(
                        label: 'Password',
                        controller: _passwordController,
                        obscureText: true,
                      ),

                      if (_errorText != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          _errorText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ],

                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            activeColor: primary,
                            onChanged: (value) {
                              setState(() => _rememberMe = value ?? false);
                              // TODO: persist a remember-me flag /
                              // auth token locally once Firebase Auth
                              // exists.
                            },
                          ),
                          Expanded(
                            child: Text('Remember for 30 days', style: textTheme.bodyMedium),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/forgot-password'),
                            child: const Text('Forgot password?'),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xs),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _signIn,
                          child: const Text('Sign in'),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Not a member? '),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed('/register'),
                            child: Text(
                              'Register now',
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
