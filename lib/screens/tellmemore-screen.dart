import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class TellMeMoreScreen extends StatefulWidget {
  const TellMeMoreScreen({super.key});

  @override
  State<TellMeMoreScreen> createState() => _TellMeMoreScreenState();
}

class _TellMeMoreScreenState extends State<TellMeMoreScreen> {
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
        child: const Column(
          children: <Widget>[
            ReturnButton(),
            SizedBox(height: 106,),
            Padding(
              padding: EdgeInsets.only(right: 60),
              child: Text('Tell me more', style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontSize: 30, fontWeight: FontWeight.w700),),
            ),
            SizedBox(height: 40,),
            GetDisplayName(),
            SizedBox(height: 30,),
            GetAge(),
            SizedBox(height: 30,),
          ]
        )
      )
    );
   }
}

class GetAge extends StatelessWidget {
  const GetAge({
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
          labelText: 'Age (required)',
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

class GetDisplayName extends StatelessWidget {
  const GetDisplayName({
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
          labelText: 'Display name',
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