import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soundspace/features/auth/presentation/widgets/widgets.dart';

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

  @override
  void dispose() {
    _ageController.dispose();
    _displayNameController.dispose();
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
          child: AuthSelectionBox(
            list: const [
              'Female',
              'Male',
              'Others',
              'Prefer not to say',
            ],
            child: currentItem,
          ),
        ),
        const SizedBox(
          height: 238,
        ),
        AuthButton(
          buttonName: "Continue",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthBloc>().add(AuthSignUp(
                    email: widget.email,
                    password: widget.password,
                    displayName: _displayNameController.text.trim(),
                    age: int.parse(_ageController.text.trim()),
                    gender: currentItem!.trim(),
                  ));
            }
          },
        ),
        const AuthHelper(),
      ],
    ));
  }
}
