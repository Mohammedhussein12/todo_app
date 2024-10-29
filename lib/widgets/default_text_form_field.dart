import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tabs/settings/settings_provider.dart';
import '../utils/app_theme.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField(
      {super.key,
      required this.hintText,
      this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
      this.initialValue,
      this.onChanged});

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? initialValue;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return TextFormField(
      onChanged: onChanged,
      initialValue: initialValue,
      maxLines: maxLines,
      keyboardType: keyboardType,
      cursorColor: settingsProvider.isDark ? AppTheme.white : AppTheme.black,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: Theme.of(context).textTheme.titleMedium,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
