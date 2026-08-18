import 'package:flutter/material.dart';

import '../exceptions/network_exception.dart';
import '../widgets/auth/auth_background.dart';
import '../widgets/auth/auth_glass_card.dart';
import '../widgets/auth/auth_form_field.dart';
import '../widgets/auth/auth_button.dart';
import '../widgets/auth/oauth_login_button.dart';
import '../widgets/auth/auth_safearea.dart';
import '../api/api_client.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService(
    apiClient: ApiClient(baseUrl: 'http://testtesttest'),
  );

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
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

  Future<void> login() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  try {
    await _authService.login(
      username: _usernameController.text.trim(),
      password: _passwordController.text,
    );
  } on NetworkException catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.message),
      ),
    );
  }
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
                      "Welcome Back, Hero",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w200,
                        color: Color.fromARGB(255, 207, 207, 207),
                      ),
                    ),

                    const SizedBox(height: 15),

                    AuthFormField(
                      controller: _usernameController,
                      validator: validateUsername,
                      labelText: "Username",
                      hintText: "Enter your username",
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

                    AuthButton(
                      buttonText: "Log in",
                      onPressed: login,
                    ),

                    const SizedBox(height: 30),

                    OAuthLoginButton(
                      buttonText: "Log in with Google",
                      buttonImage: "assets/images/google.svg",
                    ),

                    const SizedBox(height: 5),

                    OAuthLoginButton(
                      buttonText: "Log in with Discord",
                      buttonImage: "assets/images/discord.svg",
                    ),

                    const SizedBox(height: 5),

                    OAuthLoginButton(
                      buttonText: "Log in with Apple",
                      buttonImage: "assets/images/apple.svg",
                    ),

                    const SizedBox(height: 5),

                    OAuthLoginButton(
                      buttonText: "Log in with Facebook",
                      buttonImage: "assets/images/facebook.svg",
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 207, 207, 207),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
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
