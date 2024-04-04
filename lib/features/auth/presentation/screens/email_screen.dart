import 'package:flutter/material.dart';
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
            ReturnButton()
          ],
        ),
      ),
    );
  }
}

