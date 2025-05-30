import 'package:flutter/material.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/features/auth/presentation/screens/email_screen.dart';
import '../widgets/auth_widgets.dart';

class LoginScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthBackground(children: <Widget>[
        const SizedBox(
          height: 247,
        ),
        RichText(
          text: const TextSpan(
              text: 'Sound',
              style: TextStyle(
                color: AppPallete.whiteColor,
                fontFamily: 'Orbitron',
                fontWeight: FontWeight.w500,
                fontSize: 50,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Space',
                  style: TextStyle(
                    color: AppPallete.gradient4,
                    fontFamily: 'Orbitron',
                    fontWeight: FontWeight.w500,
                    fontSize: 50,
                  ),
                )
              ]),
        ),
        const SizedBox(
          height: 127,
        ),
        AuthButton(
          buttonName: "Login",
          onPressed: () {
            Navigator.push(context, EmailScreen.route());
          },
        ),
        const SizedBox(
          height: 18,
        ),
        AuthButton(
          buttonName: "Sign up",
          buttonColor: AppPallete.gradient4,
          textColor: AppPallete.whiteColor,
          onPressed: () {
            Navigator.push(context, EmailScreen.route());
          },
        ),
      ]),
    );
  }
}
