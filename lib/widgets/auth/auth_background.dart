import 'dart:ui';
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:[
                Color(0xFF171717),
                Color(0xFF292524),
                Color(0xFF4A1D1D),
              ],
            ),
          ),
        ),

        Positioned(
          top: -100,
          right: -80,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: 100,
              sigmaY: 100,
            ),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.35),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -140,
          left: -100,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: 120,
              sigmaY: 120,
            ),
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: const Color(0xFFF97316).withOpacity(0.30),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.45),
              ],
              radius: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}