import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';
import 'package:soundspace/features/auth/presentation/widgets/auth_display_field.dart';
import 'package:soundspace/features/auth/presentation/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: AuthBackground(
            children: <Widget>[
              ReturnButton(),
              SizedBox(height: 106,),
              Padding(
                padding: EdgeInsets.only(right: 60),
                child: Text(
                  'Welcome back!', 
                  style: TextStyle(
                    color: AppPallete.whiteColor, 
                    fontFamily: 'Orbitron', 
                    fontSize: 30, 
                    fontWeight: FontWeight.w700),),
              ),
              SizedBox(height: 40,),
              AuthDisplayField(
                label: 'Your email address', 
                child: Text(
                  'empty', 
                  style: TextStyle(
                    color: AppPallete.whiteColor),
                  ) 
                ),
              SizedBox(height: 30,),
              AuthTextField(label: 'Your password (min. 6 charecters)'),
              SizedBox(height: 13,),
              Padding(
                padding: EdgeInsets.only(left: 170),
                child: Text(
                  'Forget your password?', 
                  style: TextStyle(
                    color: AppPallete.gradient4, 
                    fontSize: 12, 
                    fontFamily: 'Orbitron'
                    )
                  ),
              ),
              SizedBox(height: 330,),
              AuthButton(
                buttonName: "Continue", 
                buttonColor: AppPallete.whiteColor, 
                textColor: AppPallete.gradient4),
              AuthHelper()
            ],
          ) 
    );
  }
}