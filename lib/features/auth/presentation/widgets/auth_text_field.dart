import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool passwordVisible;
  const AuthTextField(
      {super.key,
      required this.label,
      required this.controller,
      this.passwordVisible = false});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isObsureText = false;
  Widget? icon;
  bool? isAlign;

  get label => widget.label;
  get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    if (widget.passwordVisible == true) {
      isObsureText = true;
      icon = IconButton(
        icon: Icon(isObsureText ? Icons.visibility : Icons.visibility_off),
        color: AppPallete.whiteColor,
        onPressed: () {
          setState(() {
            isObsureText = !isObsureText;
          });
        },
      );
      isAlign = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: controller,
        obscureText: isObsureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: AppPallete.whiteColor,
            fontSize: 12,
          ),
          suffixIcon: icon,
          alignLabelWithHint: isAlign,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "$label is missing!";
          }
          return null;
        },
      ),
    );
  }
}
