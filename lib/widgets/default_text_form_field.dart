import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tabs/settings/settings_provider.dart';
import '../utils/app_theme.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: settingsProvider.isDark ? AppTheme.white : AppTheme.black),
      ),
    );
  }
}
