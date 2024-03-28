import 'package:flutter/material.dart';

class EmailBox extends StatelessWidget {
  const EmailBox({
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade800,
          labelText: 'Your email address',
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none
          )
        ),
      ),
    );
  }
}
