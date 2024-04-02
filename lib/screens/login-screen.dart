import 'package:flutter/material.dart';
import 'package:soundspace/screens/email-screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
        child: Column(children: <Widget>[
          const SizedBox(height: 247,),
          RichText(text: const TextSpan(
            text: 'Sound',
            style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontWeight: FontWeight.w500, fontSize: 50),
              children: <TextSpan>[
                TextSpan(text: 'Space',style: TextStyle(color: Color(0xff20f2ff), fontFamily: 'Orbitron', fontWeight: FontWeight.w500, fontSize: 50),)
              ]
            ),
          ),
          const SizedBox( height: 127,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff20f2ff)),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const EmailScreen(),
                )
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 14,bottom: 14,right: 43.7,left: 43.7),
              child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Orbitron', fontWeight: FontWeight.w500),),
            ),
          ),
          const SizedBox( height: 18,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const EmailScreen(),
                )
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 14,bottom: 14,right: 34.8,left: 34.8),
              child: Text('Sign up', style: TextStyle(color: Color(0xff20f2ff), fontSize: 18, fontFamily: 'Orbitron', fontWeight: FontWeight.w500),),
            ),
          ),
        ]),
      ),
    );
  }
}