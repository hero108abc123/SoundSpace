import 'package:flutter/material.dart';
import '../widgets/widgets.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
        child: Column(
          children: <Widget>[
            const ReturnButton(),
            const SizedBox(height: 106,),
            Text('Create an account', style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontSize: 30, fontWeight: FontWeight.w700),),
            const SizedBox(height: 40,),
            const EmailBox(),
            const SizedBox(height: 30,),
            const PasswordBox(),
            const SizedBox(height: 360,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                print('button pressed!');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14,horizontal: 100),
                child: Text('Continue', style: TextStyle(color: Color(0xff20f2ff), fontSize: 18, fontFamily: 'Orbitron', fontWeight: FontWeight.w500)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20,right: 200),
              child: Text('Need help?', style: TextStyle(color: Color(0xff9F05C5), fontSize: 15, fontFamily: 'Orbitron')),
            )
        ],),
      ),
    );
  }
}


