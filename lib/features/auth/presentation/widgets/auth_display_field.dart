import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';

class AuthDisplayField extends StatelessWidget {
  final Widget child;
  final String label;
  const AuthDisplayField({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label, 
          labelStyle: const TextStyle(
            color: AppPallete.whiteColor,
            fontSize: 12
          ),
        ),
        child: child
      ),
    );
  }
}