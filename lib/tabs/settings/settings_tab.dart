import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/firebase_services/firebase_services.dart';
import 'package:todo_app/tabs/settings/language.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/settings/theme_drop_down_menu_item.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

import '../../utils/app_theme.dart';
import 'language_drop_down_menu_button.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  List<Language> languages = [
    Language(name: 'English', code: 'en'),
    Language(name: 'Arabic', code: 'ar'),
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
          LanguageDropDownMenu(
              provider: provider,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              languages: languages,
              textTheme: textTheme),
          Padding(
            padding: EdgeInsetsDirectional.only(
                top: screenHeight * 0.02, start: screenWidth * 0.03),
            child: Text(
              AppLocalizations.of(context)!.mode,
              style: textTheme.titleSmall,
            ),
          ),
          ThemeModeDropDownMenu(
              provider: provider,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              textTheme: textTheme),
          const Spacer(
            flex: 5,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.logout,
                  style: textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: () {
                    FirebaseServices.logout();
                    Provider.of<TasksProvider>(context, listen: false)
                        .resetData();
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                    Provider.of<UserProvider>(context, listen: false)
                        .updateUser(null);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: AppTheme.primary,
                    size: 28,
                  ),
                )
              ],
            ),
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
