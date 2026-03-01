import 'package:flutter/material.dart';
import 'package:pagnation_usecase/home/home_screen.dart';
import 'package:pagnation_usecase/login/widgets/identifier_field.dart';
import 'package:pagnation_usecase/login/widgets/password_field.dart';
import 'package:pagnation_usecase/providers/auth_provider.dart';
import 'package:pagnation_usecase/Helper/auth_error_message.dart';
import 'package:pagnation_usecase/login/widgets/login_button.dart';
import 'package:provider/provider.dart';
// This widget is the login form that appears on the login screen.

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _typeController = TextEditingController();
  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.login(
      identifier: _identifierController.text,
      password: _passwordController.text,
      type: _typeController.text,
    );
    if (!mounted) return;
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login successful!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Optional later :  add logo / title here
              const SizedBox(height: 32),
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              IdentifierField(controller: _identifierController),
              const SizedBox(height: 20),

              PasswordField(controller: _passwordController),

              const SizedBox(height: 32),

              AuthErrorMessage(error: auth.errorMessage),

              const SizedBox(height: 16),

              LoginButton(
                isLoading: auth.isLoading,
                onPressed: auth.isLoading ? null : _handleLogin,
              ),

              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
