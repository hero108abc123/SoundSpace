import 'package:flutter/material.dart';
import 'package:soundspace/core/api_client.dart';
import 'package:soundspace/interface/interfaces.dart';
import 'package:soundspace/screens/screens.dart';

import '../widgets/widgets.dart';


class TellMeMoreScreen extends StatefulWidget {
  const TellMeMoreScreen({required this.email, required this.password});
  final String email;
  final String password;

  @override
  State<TellMeMoreScreen> createState() => _TellMeMoreScreenState();
}

class _TellMeMoreScreenState extends State<TellMeMoreScreen> {
  List<String> list = <String>['Female', 'Male','Others', 'Prefer not to say'];
  final _displayNameController = TextEditingController();
  final _ageController = TextEditingController();
  late String currentItem;
  final IRegister _registerService = RegisterService();
  String? response;

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
              child: Text('Tell me more', style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontSize: 30, fontWeight: FontWeight.w700),),
            ),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _displayNameController,
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
                style: const TextStyle(color: Colors.white),
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _ageController,
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
                style: const TextStyle(color: Colors.white),
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InputDecorator(
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.shade800,
                    labelText: 'Gender (required)',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 12
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      isDense: true,
                      hint: const Text("Select your gender", style: TextStyle(color: Colors.white),),
                      value: currentItem,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          currentItem = value!;
                        });
                      },
                      dropdownColor: Colors.grey.shade800,
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),  
                  ),
                ),
            ),
            const SizedBox(height: 256,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () async{
                response = await _registerService.Register(widget.email, widget.password, _displayNameController.text, int.parse(_ageController.text), currentItem);
                if(response == "Successfully created") {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SignInScreen(email: widget.email)));
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

          ]
        )
      )
    );
   }
}

