import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/features/auth/presentation/screens/login_home_screen.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/setting_widget/language_option.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/setting_widget/setting_item.dart';
import '../../../../../config/theme/app_pallete.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
              AppPallete.gradient4,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Setting(),
      ),
    );
  }
}

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    _showLanguageDialog(context);
                  },
                  child: const SettingItem(
                    title: 'Language',
                    iconPath: 'assets/images/icon/user_setting/language.png',
                  ),
                ),
                SettingItem(
                  title: 'Night Mode',
                  iconPath: 'assets/images/icon/user_setting/nightmode.png',
                  trailing: Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _logOut(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/icon/playlist/icon Back.png',
            width: 26,
            height: 25.08,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Settings',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _logOut(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                _showLogoutDialog(context);
              },
              child: Text(
                'Log Out',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Privacy Policy - Terms of Service',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Version : Beta 0.1',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    String? selectedLanguage = 'en'; // Default selection

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Language',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                LanguageOption(
                  language: 'English',
                  flagImagePath: 'assets/images/icon/user_setting/england.png',
                  value: 'en',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    selectedLanguage = value;
                    Navigator.of(context).pop();
                    _showConfirmationDialog(context, selectedLanguage);
                  },
                ),
                LanguageOption(
                  language: 'Vietnamese',
                  flagImagePath: 'assets/images/icon/user_setting/vietnam.png',
                  value: 'vi',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    selectedLanguage = value;
                    Navigator.of(context).pop();
                    _showConfirmationDialog(context, selectedLanguage);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: const Color.fromARGB(255, 28, 6, 82)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, String? language) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Language Changed',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          content: Text(
            'You have selected: $language',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: const Color.fromARGB(255, 28, 6, 82)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Log Out?',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromARGB(255, 21, 3, 39),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromARGB(255, 28, 6, 82),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
