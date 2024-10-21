import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/utils/app_theme.dart';

import '../settings/settings_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: settingsProvider.isDark ? AppTheme.dark : AppTheme.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin:
          const EdgeInsetsDirectional.symmetric(vertical: 15, horizontal: 10),
      padding: const EdgeInsetsDirectional.all(20),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 12),
            height: 62,
            width: 4,
            color: AppTheme.primary,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Play basket ball',
                style: textTheme.titleMedium
                    ?.copyWith(color: AppTheme.primary, fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Task Description',
                style: textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w400, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 34,
            width: 64,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.check,
              color: AppTheme.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
