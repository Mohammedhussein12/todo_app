import 'package:flutter/material.dart';
import 'package:todo_app/cache/cache_helper.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';

  SettingsProvider() {
    loadSettings();
  }

  void loadSettings() {
    String? themeModeType = CacheData.getData(key: 'theme') ?? 'light';
    if (themeModeType != null) {
      if (themeModeType == 'light') {
        themeMode = ThemeMode.light;
      } else if (themeModeType == 'dark') {
        themeMode = ThemeMode.dark;
      }
    }
    languageCode = CacheData.getData(key: 'language') ?? 'en';
    notifyListeners();
  }

  get isDark => themeMode == ThemeMode.dark;

  void changeThemeMode(ThemeMode selectedThemeMode) {
    if (themeMode == selectedThemeMode) return;
    themeMode = selectedThemeMode;
    CacheData.setData(
        key: 'theme',
        value: selectedThemeMode == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  void changeLanguage(String selectedLanguageCode) {
    if (languageCode == selectedLanguageCode) return;
    languageCode = selectedLanguageCode;
    CacheData.setData(key: 'language', value: selectedLanguageCode);
    notifyListeners();
  }
}
