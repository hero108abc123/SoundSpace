import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  const AuthTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label, 
          labelStyle: const TextStyle(
            color: AppPallete.whiteColor,
            fontSize: 12
          ),
        ),
      ),
    );
  }
}