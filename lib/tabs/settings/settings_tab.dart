import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/tabs/settings/language.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';

import '../../utils/app_theme.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  List<Language> languages = [
    Language(name: 'English', code: 'en'),
    Language(name: 'Arabic', code: 'ar')
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsetsDirectional.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
            width: double.infinity,
            height: screenHeight * 0.2,
            color: AppTheme.primary,
            child: SafeArea(
              child: Text(
                AppLocalizations.of(context)!.settings,
                style: textTheme.titleLarge,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
                top: screenHeight * 0.02, start: screenWidth * 0.03),
            child: Text(
              AppLocalizations.of(context)!.language,
              style: textTheme.titleSmall,
            ),
          ),
          DropdownButtonHideUnderline(
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: screenWidth * 0.02),
              margin: EdgeInsetsDirectional.only(
                  top: screenHeight * 0.02,
                  start: screenWidth * 0.05,
                  end: screenWidth * 0.05),
              color: AppTheme.white,
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
                items: languages.map(
                  (language) {
                    return DropdownMenuItem(
                      value: language,
                      child: Text(language.name),
                    );
                  },
                ).toList(),
                onChanged: (selectedLanguage) {
                  if (selectedLanguage == null) return;
                  provider.changeLanguage(selectedLanguage.code);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
                top: screenHeight * 0.02, start: screenWidth * 0.03),
            child: Text(
              AppLocalizations.of(context)!.mode,
              style: textTheme.titleSmall,
            ),
          ),
          DropdownButtonHideUnderline(
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: screenWidth * 0.02),
              margin: EdgeInsetsDirectional.only(
                  top: screenHeight * 0.02,
                  start: screenWidth * 0.05,
                  end: screenWidth * 0.05),
              color: AppTheme.white,
              child: DropdownButton(
                iconDisabledColor: AppTheme.primary,
                iconEnabledColor: AppTheme.primary,
                dropdownColor: AppTheme.white,
                value: provider.themeMode == ThemeMode.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
                style: textTheme.headlineSmall
                    ?.copyWith(color: AppTheme.primary, fontSize: 14),
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Dark'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  provider.changeThemeMode(value);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
