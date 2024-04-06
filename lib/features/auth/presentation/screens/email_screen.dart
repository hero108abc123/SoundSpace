import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';
import 'package:soundspace/features/auth/presentation/widgets/widgets.dart';

class EmailScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const EmailScreen(),
      );
  const EmailScreen({
    super.key,
  });

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
          const Text('''Sign in 
or
Create an account''',
              style: TextStyle(
                color: AppPallete.whiteColor,
                fontFamily: 'Orbitron',
                fontSize: 30,
                fontWeight: FontWeight.w700,
              )),
          const SizedBox(
            height: 40,
          ),
          AuthTextField(
            label: "Your email address",
            controller: _emailController,
          ),
          const SizedBox(
            height: 356,
          ),
          AuthButton(
            buttonName: "Continue",
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
          ),
          const AuthHelper(),
        ],
      ),
    );
  }
}
