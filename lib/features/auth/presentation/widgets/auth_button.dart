import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonName;
  final Color textColor;
  const AuthButton({super.key, required this.buttonName, required this.buttonColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            fixedSize: const Size(350,55)
          ),
          onPressed: () {
            print("Button pressed!");
          },
          child: Text(buttonName, style: TextStyle(color: textColor, fontSize: 18, fontFamily: 'Orbitron', fontWeight: FontWeight.w500))
        );
  }
}