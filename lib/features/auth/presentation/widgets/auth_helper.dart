import 'package:flutter/material.dart';

class AuthHelper extends StatelessWidget {
  const AuthHelper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20,right: 230),
      child: Text('Need help?', style: TextStyle(color: Color(0xff9F05C5), fontSize: 15, fontFamily: 'Orbitron')),
    );
  }
}
