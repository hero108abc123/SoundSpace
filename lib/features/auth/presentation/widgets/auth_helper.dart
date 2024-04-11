import 'package:flutter/material.dart';
import 'package:soundspace/config/theme/app_pallete.dart';

class AuthHelper extends StatelessWidget {
  const AuthHelper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20, right: 230),
      child: Text('Need help?',
          style: TextStyle(
            color: AppPallete.gradient3,
            fontSize: 15,
            fontFamily: 'Orbitron',
          )),
    );
  }
}
