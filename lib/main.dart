import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const FantasyGameApp());
}

class FantasyGameApp extends StatelessWidget {
  const FantasyGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fantasy Game',
      home: const LoginScreen(),
    );
  }
}
