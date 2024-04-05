import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';
import 'package:soundspace/features/auth/presentation/widgets/widgets.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBackground(
        child: Column(
          children: <Widget>[
            ReturnButton(),
            SizedBox(height: 106,),
            Text('''Sign in 
or
Create an account''', style: TextStyle(color: AppPallete.whiteColor, fontFamily: 'Orbitron', fontSize: 30, fontWeight: FontWeight.w700)),
            SizedBox(height: 40,),
            AuthField(label: "Your email address"),
          ],
        ),
      ),
    );
  }
}

