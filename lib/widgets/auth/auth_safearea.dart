import 'package:flutter/material.dart';

class AuthSafeArea extends StatelessWidget {
  final Widget child;

  const AuthSafeArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
