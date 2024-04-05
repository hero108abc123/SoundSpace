import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';
import 'package:soundspace/features/auth/presentation/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBackground(
          children: <Widget>[
            ReturnButton(),
            SizedBox(height: 106,),
            Text(
              'Create an account', 
              style: TextStyle(
                color: AppPallete.whiteColor, 
                fontFamily: 'Orbitron', 
                fontSize: 30, 
                fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 40,),
            AuthDisplayField(
              label: 'Your email address', 
              child: Text(
                'empty', 
                style: TextStyle(
                  color: AppPallete.whiteColor
                ),
              ) 
            ),
            SizedBox(height: 30,),
            AuthTextField(label: 'Your password (min. 8 charecters)'),
            SizedBox(height: 13,),
            SizedBox(height: 347,),
            AuthButton(
              buttonName: "Continue", 
              buttonColor: AppPallete.whiteColor, 
              textColor: AppPallete.gradient4
            ),
            AuthHelper()
          ],
        ) 
    );
  }
}