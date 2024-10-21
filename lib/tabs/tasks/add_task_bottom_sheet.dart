import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/widgets/default_elevated_button.dart';
import 'package:todo_app/widgets/default_text_form_field.dart';

import '../../models/task_model.dart';
import '../../utils/app_theme.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final titleMediumTextTheme = Theme.of(context).textTheme.titleMedium;
    final headlineSmallTextTheme = Theme.of(context).textTheme.headlineSmall;
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.58,
      color: settingsProvider.isDark ? AppTheme.dark : AppTheme.white,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.add_new_task,
              style: titleMediumTextTheme,
            ),
            const SizedBox(height: 16),
            DefaultTextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
                hintText: AppLocalizations.of(context)!.enter_your_task,
                controller: titleController),
            const SizedBox(
              height: 16,
            ),
            DefaultTextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description cannot be empty';
                  }
                  return null;
                },
                hintText: AppLocalizations.of(context)!.enter_task_description,
                controller: titleController),
            const SizedBox(
              height: 16,
            ),
            Text(
              AppLocalizations.of(context)!.select_date,
              style: headlineSmallTextTheme,
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () async {
                DateTime? dateTime = await showDatePicker(
                  locale: Locale(settingsProvider.languageCode),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ),
                );
                if (dateTime != null && dateTime != selectedDate) {
                  selectedDate = dateTime;
                }
                setState(() {});
              },
              child: Text(
                style: headlineSmallTextTheme?.copyWith(fontSize: 16),
                dateFormat.format(selectedDate),
              ),
            ),
            const Spacer(),
            DefaultElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addTask();
                  }
                },
                label: AppLocalizations.of(context)!.add),
          ],
        ),
      ),
    );
  }

  addTask() {
    TaskModel task = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      date: selectedDate,
    );
  }
}