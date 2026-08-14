import 'package:flutter/material.dart';

import '../widgets/auth/auth_background.dart';
import '../widgets/auth/auth_glass_card.dart';

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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
