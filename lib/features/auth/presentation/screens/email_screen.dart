import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soundspace/features/auth/presentation/screens/auth_screens.dart';
import 'package:soundspace/features/auth/presentation/widgets/auth_widgets.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is EmailSuccess) {
          Navigator.push(
            context,
            SignInScreen.route(
              _emailController.text.trim(),
            ),
          );
        } else if (state is EmailFailure) {
          showSnackBar(context, state.message);
          Navigator.push(
            context,
            SignUpScreen.route(
              _emailController.text.trim(),
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              height: 250,
            ),
            AuthButton(
              buttonName: "Continue",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthBloc>().add(
                        AuthEmailValidation(
                          email: _emailController.text.trim(),
                        ),
                      );
                }
              },
            ),
            const AuthHelper(),
          ],
        ),
      ),
    );
  }
}
