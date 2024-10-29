import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_services/firebase_services.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:todo_app/widgets/default_text_form_field.dart';

import '../../helper_methods/show_toast.dart';
import '../../models/task_model.dart';
import '../../utils/app_theme.dart';
import '../../widgets/default_elevated_button.dart';
import '../settings/settings_provider.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = '/edit_task_screen';

  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TaskModel task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.to_do_list,
          style: TextStyle(
            color: settingsProvider.isDark ? AppTheme.black : AppTheme.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: settingsProvider.isDark ? AppTheme.black : AppTheme.white,
          ),
        ),
        backgroundColor: AppTheme.primary,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: AppTheme.primary,
              height: screenHeight * 0.08,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(
                color: settingsProvider.isDark ? AppTheme.dark : AppTheme.white,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.04),
              height: screenHeight * 0.70,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.edit_task,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      DefaultTextFormField(
                        onChanged: (value) {
                          task.title = value;
                        },
                        initialValue: task.title,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Title cannot be empty';
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.this_is_title,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormField(
                        initialValue: task.description,
                        onChanged: (value) {
                          task.description = value;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Description cannot be empty';
                          }
                          return null;
                        },
                        maxLines: 2,
                        hintText: AppLocalizations.of(context)!.task_details,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.select_date,
                        style: Theme.of(context).textTheme.headlineSmall,
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
                          task.date = tasksProvider.selectedDate;
                        },
                        child: Text(
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: 16),
                          dateFormat.format(tasksProvider.selectedDate),
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      DefaultElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await FirebaseServices.updateTaskToFireStore(task)
                                  .timeout(const Duration(microseconds: 100),
                                      onTimeout: () {
                                tasksProvider.getTasks();
                                Navigator.pop(context);
                                showToast(
                                    msg: 'Task updated successfully!',
                                    backgroundColor: AppTheme.green);
                              }).catchError((error) {
                                showToast(
                                    msg: 'oops! Something went wrong.',
                                    backgroundColor: AppTheme.red);
                              });
                            }
                          },
                          label: AppLocalizations.of(context)!.save_changes),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
