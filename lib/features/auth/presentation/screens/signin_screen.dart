import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soundspace/features/auth/presentation/widgets/auth_widgets.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../home/presentation/screens/home_screen.dart';

class SignInScreen extends StatefulWidget {
  static route(
    String email,
  ) =>
      MaterialPageRoute(
        builder: (context) => SignInScreen(
          email: email,
        ),
      );
  final String email;
  const SignInScreen({
    super.key,
    required this.email,
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
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserLoggedIn;
      },
      builder: (context, isLoggedIn) {
        if (isLoggedIn) {
          return const HomeScreen();
        }
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.read<AuthBloc>().add(AuthIsUserLoggedIn());
            }
          },
          child: Scaffold(
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
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            AuthLogin(
                              email: widget.email.trim(),
                              password: _passwordController.text.trim(),
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
      },
    );
  }
}
