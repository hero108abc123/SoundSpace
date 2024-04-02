import 'package:flutter/material.dart';
import 'package:soundspace/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? user;
  const HomeScreen({required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff000000),
              Color(0xff35005d),
              Color(0xff20f2ff)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
           Text(widget.user!.name, style: const TextStyle(color: Colors.white),),
           Text(widget.user!.token, style: const TextStyle(color: Colors.white)),
        ],
        ),
      
      )
    );
  }
}