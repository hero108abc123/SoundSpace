import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/auth/presentation/screens/auth_screens.dart';
import 'package:soundspace/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:soundspace/features/home/presentation/bloc/user/user_bloc.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/setting_widget/language_option.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/setting_widget/setting_item.dart';
import '../../../../../config/theme/app_pallete.dart';
import 'package:provider/provider.dart';
import '../../provider/language_provider.dart';

class SettingTab extends StatelessWidget {
  const SettingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLogoutSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            LoginScreen.route(),
            (route) => false, // Clear the navigation stack
          );
        } else if (state is UserLogoutFailure) {
          showSnackBar(context, state.message);
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

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
                    _showLanguageDialog(context, languageProvider);
                  },
                  child: SettingItem(
                    title: languageProvider.translate('language'),
                    iconPath: 'assets/images/icon/user_setting/language.png',
                  ),
                ),
                SettingItem(
                  title: languageProvider.translate('night_mode'),
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
        _logOut(context, languageProvider),
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
              Provider.of<LanguageProvider>(context).translate('settings'),
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

  Widget _logOut(BuildContext context, LanguageProvider languageProvider) {
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
                _showLogoutDialog(context, languageProvider);
              },
              child: Text(
                languageProvider.translate('log_out'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              languageProvider.translate('privacy_policy'),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              languageProvider.translate('version'),
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

  void _showLanguageDialog(
      BuildContext context, LanguageProvider languageProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            languageProvider.translate('select_language'),
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
                  groupValue: languageProvider.selectedLanguage,
                  onChanged: (value) {
                    languageProvider.changeLanguage(value!);
                    Navigator.of(context).pop();
                    _showConfirmationDialog(context, value);
                  },
                ),
                LanguageOption(
                  language: 'Vietnamese',
                  flagImagePath: 'assets/images/icon/user_setting/vietnam.png',
                  value: 'vi',
                  groupValue: languageProvider.selectedLanguage,
                  onChanged: (value) {
                    languageProvider.changeLanguage(value!);
                    Navigator.of(context).pop();
                    _showConfirmationDialog(context, value);
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
                languageProvider.translate('cancel'),
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
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            languageProvider.translate('language_changed'),
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          content: Text(
            '${languageProvider.translate('you_have_selected')} $language',
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
                languageProvider.translate('ok'),
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

  void _showLogoutDialog(
      BuildContext context, LanguageProvider languageProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return AlertDialog(
              title: Text(
                languageProvider.translate('log_out'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              content: Text(
                languageProvider.translate('log_out_confirmation'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    languageProvider.translate('cancel'),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 21, 3, 39),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                ),
                TextButton(
                  child: Text(
                    languageProvider.translate('yes'),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 28, 6, 82),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<UserBloc>().add(UserLogoutRequested(
                          homeBloc: context.read<HomeBloc>(),
                        ));
                    // Dismiss the dialog
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
