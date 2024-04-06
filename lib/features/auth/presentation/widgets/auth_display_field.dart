import 'package:flutter/material.dart';

class AuthDisplayField extends StatelessWidget {
  final Widget child;
  final String label;
  const AuthDisplayField({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
        ),
        child: child,
      ),
    );
  }
}
