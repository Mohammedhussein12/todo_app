import 'package:flutter/material.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';

import '../../utils/app_theme.dart';

class ThemeModeDropDownMenu extends StatelessWidget {
  const ThemeModeDropDownMenu({
    super.key,
    required this.provider,
    required this.screenWidth,
    required this.screenHeight,
    required this.textTheme,
  });

  final SettingsProvider provider;
  final double screenWidth;
  final double screenHeight;
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
        child: DropdownButton(
          iconDisabledColor: AppTheme.primary,
          iconEnabledColor: AppTheme.primary,
          dropdownColor:
              provider.isDark ? AppTheme.backgroundDark : AppTheme.white,
          value: provider.themeMode,
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
          onChanged: (themeMode) {
            if (themeMode != null) {
              provider.changeThemeMode(themeMode);
            }
          },
        ),
      ),
    );
  }
}