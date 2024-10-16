import 'package:flutter/material.dart';
import 'package:todo_app/cache/cache_helper.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';

  void loadSettings() {
    String? themeModeType = CacheData.getData(key: 'theme');
    if (themeModeType != null) {
      themeMode = themeModeType == 'light' ? ThemeMode.light : ThemeMode.dark;
    }
    languageCode = CacheData.getData(key: 'language');
    notifyListeners();
  }

  void changeThemeMode(ThemeMode selectedThemeMode) {
    if (themeMode == selectedThemeMode) return;
    themeMode = selectedThemeMode;
    CacheData.setData(
        key: 'theme', value: selectedThemeMode == themeMode ? 'light' : 'dark');
    notifyListeners();
  }

  void changeLanguage(String selectedLanguageCode) {
    if (languageCode == selectedLanguageCode) return;
    languageCode = selectedLanguageCode;
    CacheData.setData(key: 'language', value: selectedLanguageCode);
    notifyListeners();
  }
}
