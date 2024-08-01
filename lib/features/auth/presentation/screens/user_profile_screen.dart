import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soundspace/features/auth/presentation/screens/auth_screens.dart';
import 'package:soundspace/features/auth/presentation/screens/email_screen.dart';
import 'package:soundspace/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:soundspace/features/home/presentation/screens/home_screen.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';

class UserProfileScreen extends StatefulWidget {
  static route(
    String email,
    String password,
  ) =>
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(
          email: email,
          password: password,
        ),
      );
  final String email;
  final String password;
  const UserProfileScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _ageController = TextEditingController();
  String? currentItem;
  List<String> list = [
    'Female',
    'Male',
    'Others',
    'Prefer not to say',
  ];
  @override
  void dispose() {
    _ageController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
            } else if (state is AuthFailure) {
              showSnackBar(context, state.message);
              Navigator.push(
                context,
                EmailScreen.route(),
              );
            }
          },
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AccountSuccess) {
                context.read<AuthBloc>().add(
                      AuthLogin(
                        email: widget.email.trim(),
                        password: widget.password.trim(),
                      ),
                    );
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
                      'Tell me more',
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
                  AuthTextField(
                    label: 'Display name',
                    controller: _displayNameController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthTextField(
                    label: 'Age (required)',
                    controller: _ageController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthDisplayField(
                    label: 'Gender (required)',
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      isDense: true,
                      hint: const Text(
                        "Select your gender",
                        style: TextStyle(
                          color: AppPallete.whiteColor,
                        ),
                      ),
                      value: currentItem,
                      style: const TextStyle(
                        color: AppPallete.borderColor,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          currentItem = value!;
                        });
                      },
                      dropdownColor: AppPallete.boxColor,
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 238,
                  ),
                  AuthButton(
                    buttonName: "Continue",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthCreateProfile(
                              displayName: _displayNameController.text.trim(),
                              age: int.parse(_ageController.text.trim()),
                              gender: currentItem!.trim(),
                            ));
                      }
                    },
                  ),
                  const AuthHelper(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
