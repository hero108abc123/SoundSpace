import 'package:flutter/material.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/features/auth/presentation/screens/auth_screens.dart';
import 'package:soundspace/features/auth/presentation/widgets/auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  static route(
    String email,
  ) =>
      MaterialPageRoute(
        builder: (context) => SignUpScreen(
          email: email,
        ),
      );
  final String email;
  const SignUpScreen({
    super.key,
    required this.email,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        const Text(
          'Create an account',
          style: TextStyle(
            color: AppPallete.whiteColor,
            fontFamily: 'Orbitron',
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        AuthDisplayField(
            label: 'Your email address',
            child: Text(
              widget.email,
              style: const TextStyle(
                color: AppPallete.whiteColor,
              ),
            )),
        const SizedBox(
          height: 30,
        ),
        AuthTextField(
          label: 'Your password (min. 8 charecters)',
          controller: _passwordController,
          passwordVisible: true,
        ),
        const SizedBox(
          height: 13,
        ),
        const SizedBox(
          height: 347,
        ),
        AuthButton(
          buttonName: "Continue",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                  context,
                  UserProfileScreen.route(
                    widget.email,
                    _passwordController.text.trim(),
                  ));
            }
          },
        ),
        const AuthHelper(),
      ],
    ));
  }
}
