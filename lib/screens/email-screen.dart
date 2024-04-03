import 'package:flutter/material.dart';
import 'package:soundspace/core/api_client.dart';
import 'package:soundspace/interface/interfaces.dart';
import 'package:soundspace/screens/screens.dart';
import '../widgets/widgets.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final IEmailCheck _emailCheck = EmailCheckService();
  final _emailController = TextEditingController();
  late String email;
  final _formKey = GlobalKey<FormState>();

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
            const ReturnButton(),
            const SizedBox(height: 106,),
            const Text('''Sign in 
or 
create an account''', style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontSize: 30, fontWeight: FontWeight.w700),),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailController,
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
                    )
                  ),
                  style: const TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () async{
                    if(_formKey.currentState!.validate()){
                      email = await _emailCheck.EmailCheck(_emailController.text);
                      if (email != "Email not found!"){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignInScreen(email: email)));
                      } else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignUpScreen(email: _emailController.text)));
                      }
                    }
                    
                  },
                  validator: validateEmail,
                ),
              )
            ),
            const SizedBox(height: 336,),
            ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () async{
              if(_formKey.currentState!.validate()){
                  email = await _emailCheck.EmailCheck(_emailController.text);
                  if (email != "Email not found!"){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignInScreen(email: email)));
                  } else{
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignUpScreen(email: _emailController.text)));
                  }
              }
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


String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Please enter a valid email address'
      : null;
}