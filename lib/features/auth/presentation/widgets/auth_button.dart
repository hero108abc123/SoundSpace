import 'package:flutter/material.dart';
import 'package:soundspace/config/theme/app_pallete.dart';

class AuthButton extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  const AuthButton({
    super.key,
    required this.buttonName,
    this.buttonColor = AppPallete.whiteColor,
    this.textColor = AppPallete.gradient4,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          fixedSize: const Size(350, 55),
        ),
        onPressed: onPressed,
        child: Text(buttonName,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontFamily: 'Orbitron',
              fontWeight: FontWeight.w500,
            )));
  }
}
