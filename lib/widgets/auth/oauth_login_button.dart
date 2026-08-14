import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OAuthLoginButton extends StatelessWidget {
  final String buttonText;
  final String buttonImage;

  const OAuthLoginButton({
    super.key,
    required this.buttonText,
    required this.buttonImage,
  });

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child:ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 15,
          ),
          backgroundColor: const Color(0xFFFDE68A).withOpacity(0.08),
          overlayColor: const Color(0xFFFDE68A).withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26), 
            side: BorderSide(
              color: const Color(0xFFFDE68A).withOpacity(0.30),                  
              width: 1.5,
            )
          )
        ),
        onPressed: () {},
        
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: SvgPicture.asset(
                  buttonImage,
                  width: 32,
                  height: 32,
                ),
              ),
            ),

            SizedBox(width: 10),

            Text(
              buttonText,
              style: TextStyle(
                color: const Color.fromARGB(255, 207, 207, 207),
                fontSize: 20,
              ),
            )
          ],
        ),
      )
    );
  }
}