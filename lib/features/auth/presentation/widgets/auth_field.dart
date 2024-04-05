import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';

class AuthField extends StatelessWidget {
  final String label;
  const AuthField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label, 
        labelStyle: const TextStyle(
          color: AppPallete.whiteColor,
          fontSize: 12
        ),
      ),
    );
  }
}