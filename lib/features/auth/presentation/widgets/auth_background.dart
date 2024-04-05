import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';

class AuthBackground extends StatelessWidget {
  final List<Widget> children;
  const AuthBackground({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
              AppPallete.gradient4
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: Column(
          children: children,
        ),
    );
  }
}