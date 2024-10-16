import 'package:flutter/material.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';

import '../../utils/app_theme.dart';
import 'language.dart';

class LanguageDropDownMenu extends StatelessWidget {
  const LanguageDropDownMenu({
    super.key,
    required this.provider,
    required this.screenWidth,
    required this.screenHeight,
    required this.languages,
    required this.textTheme,
  });

  final SettingsProvider provider;
  final double screenWidth;
  final double screenHeight;
  final List<Language> languages;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        decoration: BoxDecoration(
          color: provider.isDark ? AppTheme.backgroundDark : AppTheme.white,
          border: Border.all(color: AppTheme.primary),
        ),
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: screenWidth * 0.02),
        margin: EdgeInsetsDirectional.only(
            top: screenHeight * 0.02,
            start: screenWidth * 0.05,
            end: screenWidth * 0.05),
        child: DropdownButton<Language>(
          iconDisabledColor: AppTheme.primary,
          iconEnabledColor: AppTheme.primary,
          dropdownColor: AppTheme.white,
          value: languages.firstWhere(
            (language) {
              return language.code == provider.languageCode;
            },
          ),
          style: textTheme.headlineSmall
              ?.copyWith(color: AppTheme.primary, fontSize: 14),
          items: List.generate(
            languages.length,
            (index) {
              return DropdownMenuItem(
                value: languages[index],
                child: Text(languages[index].name),
              );
            },
          ),
          onChanged: (selectedLanguage) {
            if (selectedLanguage != null) {
              provider.changeLanguage(selectedLanguage.code);
            }
          },
        ),
      ),
    );
  }
}
