import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackground(
          children: <Widget>[
            const SizedBox(height: 247,),
            RichText(text: const TextSpan(
            text: 'Sound',
            style: TextStyle(
              color: AppPallete.whiteColor, 
              fontFamily: 'Orbitron', 
              fontWeight: FontWeight.w500, 
              fontSize: 50
            ),
            children: <TextSpan>[
                  TextSpan(
                    text: 'Space',
                    style: TextStyle(
                      color: AppPallete.gradient4, 
                      fontFamily: 'Orbitron', 
                      fontWeight: FontWeight.w500, 
                      fontSize: 50
                    ),
                  )
                ]
              ),
            ),
            const SizedBox( height: 127,),
            const AuthButton(
                buttonName: "Login", 
                buttonColor: AppPallete.whiteColor, 
                textColor: AppPallete.gradient4,
              ),
            const SizedBox( height: 18,),
            const AuthButton(
                buttonName: "Sign up",
                buttonColor: AppPallete.gradient4, 
                textColor: AppPallete.whiteColor,
              ),
          ]
        ),
    );
  }
}
