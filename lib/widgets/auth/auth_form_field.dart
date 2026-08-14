import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget  {

  final bool obscureText;
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AuthFormField({
    super.key,
    this.obscureText = false,
    this.labelText = "",
    this.hintText = "",
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: TextStyle(
          color: const Color.fromARGB(255, 207, 207, 207),
          fontSize: 17,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(
            color: const Color.fromARGB(255, 207, 207, 207),
          ),
          hintStyle: TextStyle(
            color: const Color.fromARGB(255, 207, 207, 207),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
            borderSide: BorderSide(
              color: Color.fromARGB(195, 253, 230, 138),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
            borderSide: BorderSide(
              color: Color(0x66FDE68A),
              width: 2,
            ),
          ),  
        ),
      ),
    );
  }  
}