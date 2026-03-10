import 'package:flutter/material.dart';
import 'package:pagnation_usecase/login/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
