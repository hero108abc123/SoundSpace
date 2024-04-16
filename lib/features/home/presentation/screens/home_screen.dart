import 'package:flutter/material.dart';
import 'package:soundspace/config/theme/app_pallete.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.gradient2,
        elevation: 1,
      ),
      body: Container(),
    );
  }
}
