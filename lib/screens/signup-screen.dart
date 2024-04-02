import 'package:flutter/material.dart';
import '../widgets/widgets.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({required this. email});
  final String email;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _passwordController = TextEditingController();
  
  bool passwordVisible=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible=true;
  }

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
            const Text('Create an account', style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontSize: 30, fontWeight: FontWeight.w700),),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InputDecorator(
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.shade800,
                  labelText: 'Your email address',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12
                  ),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none
                  ),
                ),
                child: Text(widget.email, style: const TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.shade800,
                    labelText: 'Your password (min. 8 charecters)',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 12
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    alignLabelWithHint: false,
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () async{
                  },
                  validator: validatePassword,
                )
              
              ),
            ),
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


String? validatePassword(String? value) {
    const pattern = r'^.{8,}$' ;
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}