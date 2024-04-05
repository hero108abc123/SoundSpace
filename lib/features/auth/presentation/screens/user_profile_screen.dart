import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';
import 'package:soundspace/features/auth/presentation/widgets/widgets.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBackground(
          children: <Widget>[
            ReturnButton(),
            SizedBox(height: 106,),
            Padding(
              padding: EdgeInsets.only(right: 60),
              child: Text(
                'Tell me more', 
                style: TextStyle(
                  color: AppPallete.whiteColor, 
                  fontFamily: 'Orbitron', 
                  fontSize: 30, 
                  fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 40,),
            AuthTextField(label: 'Display name'),
            SizedBox(height: 30,),
            AuthTextField(label: 'Age (required)'),
            SizedBox(height: 30,),
            AuthDisplayField(
              label: 'Gender (required)', 
              child: AuthSelectionBox(
                list: [
                  'Female', 
                  'Male',
                  'Others', 
                  'Prefer not to say'
                ],
              )
            ),
            SizedBox(height: 238,),
            AuthButton(
              buttonName: "Continue", 
              buttonColor: AppPallete.whiteColor, 
              textColor: AppPallete.gradient4
            ),
            AuthHelper()
          ],
        )
    );
  }
}