import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentLocal with ChangeNotifier {
  Locale _currentLocal = Locale('en', 'US');
  Locale get local => _currentLocal;

  CurrentLocal() {
    _loadFromPreference();
  }

  void changeLanguageToEnglish() {
    _currentLocal = Locale('en', 'US');
    notifyListeners();

    _saveToPreference();
  }

  void changeLanguageToBengali() {
    _currentLocal = Locale('bn', 'BD');
    notifyListeners();

    _saveToPreference();
  }

  void _loadFromPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String localLanguageCode = prefs.getString('current-local-languagecode');
    String localCountryCode = prefs.getString('current-local-countrycode');

    _currentLocal = Locale(localLanguageCode, localCountryCode);
    notifyListeners();
  }

  void _saveToPreference() async { 
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
    await prefs.setString('current-local-languagecode', _currentLocal.languageCode);
    await prefs.setString('current-local-countrycode', _currentLocal.countryCode); 
  }
}
