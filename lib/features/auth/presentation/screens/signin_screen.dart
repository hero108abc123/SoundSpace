import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';
import 'package:soundspace/features/auth/presentation/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      );
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
      formKey: _formKey,
      children: <Widget>[
        const ReturnButton(),
        const SizedBox(
          height: 106,
        ),
        const Padding(
          padding: EdgeInsets.only(right: 60),
          child: Text(
            'Welcome back!',
            style: TextStyle(
              color: AppPallete.whiteColor,
              fontFamily: 'Orbitron',
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const AuthDisplayField(
            label: 'Your email address',
            child: Text(
              'empty',
              style: TextStyle(
                color: AppPallete.whiteColor,
              ),
            )),
        const SizedBox(
          height: 30,
        ),
        AuthTextField(
          label: 'Your password (min. 6 charecters)',
          controller: _passwordController,
          passwordVisible: true,
        ),
        const SizedBox(
          height: 13,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 170),
          child: Text('Forget your password?',
              style: TextStyle(
                color: AppPallete.gradient4,
                fontSize: 12,
                fontFamily: 'Orbitron',
              )),
        ),
        const SizedBox(
          height: 330,
        ),
        AuthButton(
          buttonName: "Continue",
          onPressed: () {
            if (_formKey.currentState!.validate()) {}
          },
        ),
        const AuthHelper(),
      ],
    ));
  }
}
