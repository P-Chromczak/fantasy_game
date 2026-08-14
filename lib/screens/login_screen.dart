import 'package:flutter/material.dart';

import '../widgets/auth/auth_background.dart';
import '../widgets/auth/auth_glass_card.dart';
import '../widgets/auth/auth_form_field.dart';
import '../widgets/auth/auth_button.dart';
import '../widgets/auth/oauth_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AuthBackground(),

          Center(
            child: AuthGlassCard(
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
                  labelText: "Name",
                  hintText: "Enter your name",
                ),

                AuthFormField(
                  obscureText: true,
                  labelText: "Password",
                  hintText: "Enter your Password",
                ),

                const SizedBox(height: 10),

                AuthButton(
                  buttonText: "Log in",
                  onPressed: () {},
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
                  onTap: () {},
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
        ],
      ),
    );
  }
}
