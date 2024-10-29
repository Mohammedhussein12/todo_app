import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_services/firebase_services.dart';
import 'package:todo_app/helper_methods/show_toast.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
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
  late TasksProvider tasksProvider;

  @override
  Widget build(BuildContext context) {
    final titleMediumTextTheme = Theme.of(context).textTheme.titleMedium;
    final headlineSmallTextTheme = Theme.of(context).textTheme.headlineSmall;
    var settingsProvider = Provider.of<SettingsProvider>(context);
    tasksProvider = Provider.of<TasksProvider>(context, listen: false);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: settingsProvider.isDark ? AppTheme.dark : AppTheme.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.58,
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
                  hintText:
                      AppLocalizations.of(context)!.enter_task_description,
                  controller: descriptionController),
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
                    initialDate: tasksProvider.selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                  );
                  if (dateTime != null &&
                      dateTime != tasksProvider.selectedDate) {
                    tasksProvider.selectedDate = dateTime;
                  }
                  setState(() {});
                },
                child: Text(
                  style: headlineSmallTextTheme?.copyWith(fontSize: 16),
                  dateFormat.format(tasksProvider.selectedDate),
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
      ),
    );
  }

  addTask() async {
    TaskModel task = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      date: tasksProvider.selectedDate,
    );
    await FirebaseServices.addTaskToFireStore(task)
        .timeout(const Duration(milliseconds: 10), onTimeout: () {
      Provider.of<TasksProvider>(context, listen: false).getTasks();
      Navigator.pop(context);
      showToast(
          msg: 'Task Added successfully!', backgroundColor: AppTheme.green);
    }).catchError((error) {
      showToast(
          msg: 'oops! something went wrong', backgroundColor: AppTheme.red);
    });
  }
}
