
import 'package:flutter/material.dart';
import 'package:soundspace/screens/login-screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

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
            stops: [0.1, 0.4, 0.9]
          )
        ),
        child: Column(children: <Widget>[
          const SizedBox(height: 111,),
          RichText(text: const TextSpan(
            text: 'Sound',
            style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontWeight: FontWeight.w500, fontSize: 50),
              children: <TextSpan>[
                TextSpan(text: 'Space',style: TextStyle(color: Color(0xff20f2ff), fontFamily: 'Orbitron', fontWeight: FontWeight.w500, fontSize: 50),)
              ]
            ),
          ),
          const SizedBox(height: 12,),
          const Text("Let music paint your soul", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Orbitron', fontWeight: FontWeight.w500),),
          const SizedBox(height: 76,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff20f2ff)),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                )
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Text('Get started', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Orbitron', fontWeight: FontWeight.w500),),
            ),
          ),
          Container(
              height:555,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/image1.png'),
                  fit: BoxFit.fitHeight,
                )
              ),
            ),
        ],),
      ),
    );
  }
}
