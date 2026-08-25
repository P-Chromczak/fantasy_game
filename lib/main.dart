import 'package:flutter/material.dart';

import 'screens/game_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_state.dart';

void main() {
  runApp(FantasyGameApp());
}

class FantasyGameApp extends StatefulWidget {
  const FantasyGameApp({super.key});

  @override
  State<FantasyGameApp> createState() => _FantasyGameAppState();
}

class _FantasyGameAppState extends State<FantasyGameApp> {
  late final AuthState authState;

  @override
  void initState() {
    super.initState();

    authState = AuthState();

    authState.stream.listen((status) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    authState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fantasy Game',
      home: authState.status == AuthStatus.authenticated
          ? const GameScreen()
          : LoginScreen(
              authState: authState,
            ),
    );
  }
}