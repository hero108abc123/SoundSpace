import 'package:flutter/material.dart';
import 'package:soundspace/core/api_client.dart';
import 'package:soundspace/models/models.dart';
import 'package:soundspace/screens/screens.dart';
import '../interface/interfaces.dart';
import '../widgets/widgets.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final ILogin _loginService = LoginService();
  final _emailController = TextEditingController();
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
            const Padding(
              padding: EdgeInsets.only(right: 60),
              child: Text('Welcome back!', style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontSize: 30, fontWeight: FontWeight.w700),),
            ),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
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
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.shade800,
                  labelText: 'Your password (min. 6 charecters)',
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
                  UserModel? user = await _loginService.login(_emailController.text, _passwordController.text);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(user: user) 
                      )
                  );

                },
              ),
            ),
            const SizedBox(height: 13,),
            const Padding(
              padding: EdgeInsets.only(left: 170),
              child: Text('Forget your password?', style: TextStyle(color: Color(0xff20f2ff), fontSize: 12, fontFamily: 'Orbitron')),
            ),
            const SizedBox(height: 330,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () async{
                UserModel? user = await _loginService.login(_emailController.text, _passwordController.text);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(user: user) 
                      )
                  );
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