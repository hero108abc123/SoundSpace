import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _selectedLanguage = 'en';
  Map<String, String> _localizedStrings = {};

  LanguageProvider() {
    loadLanguage(_selectedLanguage);
  }

  String get selectedLanguage => _selectedLanguage;

  Future<void> loadLanguage(String languageCode) async {
    String jsonString = await rootBundle.loadString('l10n/intl.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = Map<String, String>.from(jsonMap[languageCode]);
    notifyListeners();
  }

  void changeLanguage(String languageCode) {
    _selectedLanguage = languageCode;
    loadLanguage(languageCode);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
