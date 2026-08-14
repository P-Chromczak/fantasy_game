import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget{
  final String buttonText;
  final VoidCallback? onPressed;

  const AuthButton({
    super.key,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFDE68A).withOpacity(0.08),
        overlayColor: const Color(0xFFFDE68A).withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), 
          side: BorderSide(
            color: const Color(0xFFFDE68A).withOpacity(0.30),                  
            width: 1.5,
          )
        )
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: const Color.fromARGB(255, 207, 207, 207),
          fontSize: 20,
        ),
      ),
    );
  }
}