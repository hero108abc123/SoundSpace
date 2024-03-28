import 'package:flutter/material.dart';

class PasswordBox extends StatefulWidget {
  const PasswordBox({super.key});

  @override
  State<PasswordBox> createState() => _PasswordBoxState();
}

class _PasswordBoxState extends State<PasswordBox> {
  bool passwordVisible=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible=true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        obscureText: passwordVisible,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade800,
          labelText: 'Your password (min. 6 charecters)',
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none
          ),
          suffixIcon: IconButton(
            icon: Icon(passwordVisible
                ? Icons.visibility
                : Icons.visibility_off),
            color: Colors.white,
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
          alignLabelWithHint: false,
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}