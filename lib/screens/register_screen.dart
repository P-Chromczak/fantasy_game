import 'package:flutter/material.dart';

import '../widgets/auth/auth_safearea.dart';
import '../widgets/auth/auth_background.dart';
import '../widgets/auth/auth_glass_card.dart';
import '../widgets/auth/auth_form_field.dart';
import '../widgets/auth/auth_button.dart';
import '../api/api_client.dart';
import '../services/auth_service.dart';
import '../services/token_storage_provider.dart';
import '../services/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  final AuthState authState;

  const RegisterScreen({super.key, required this.authState});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final _tokenStorage = createTokenStorage();
  late final _authService = AuthService(
    apiClient: ApiClient(
      baseUrl: 'http://testtesttest',
      tokenStorage: _tokenStorage,
      authState: widget.authState,
    ),
    tokenStorage: _tokenStorage,
    authState: widget.authState,
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (!value.contains('@')) {
      return "Enter a valid email";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must contain at least 8 characters";
    }

    return null;
  }

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await _authService.register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AuthBackground(),

          AuthSafeArea(
            child: AuthGlassCard(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Create Your Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w200,
                        color: Color.fromARGB(255, 207, 207, 207),
                      ),
                    ),

                    const SizedBox(height: 15),

                    AuthFormField(
                      controller: _emailController,
                      validator: validateEmail,
                      labelText: "Email",
                      hintText: "Enter your email",
                    ),

                    const SizedBox(height: 10),

                    AuthFormField(
                      controller: _passwordController,
                      validator: validatePassword,
                      obscureText: true,
                      labelText: "Password",
                      hintText: "Enter your password",
                    ),

                    const SizedBox(height: 10),

                    AuthButton(buttonText: "Sign up", onPressed: register),

                    const SizedBox(height: 20),

                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 207, 207, 207),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFDE68A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
