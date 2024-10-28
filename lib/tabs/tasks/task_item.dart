import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_services/firebase_services.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:todo_app/utils/app_theme.dart';

import '../settings/settings_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var settingsProvider = Provider.of<SettingsProvider>(context);
    var tasksProvider = Provider.of<TasksProvider>(context, listen: false);

    return Container(
      margin:
          const EdgeInsetsDirectional.symmetric(vertical: 15, horizontal: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  FirebaseServices.deleteTaskFromFireStore(task.id).timeout(
                      const Duration(microseconds: 100), onTimeout: () {
                    tasksProvider.getTasks();
                  }).catchError(() {
                    Fluttertoast.showToast(
                      msg: "Oops! Something went wrong. Please try again.",
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 5,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: AppTheme.red,
                    );
                  });
                },
                backgroundColor: AppTheme.red,
                foregroundColor: AppTheme.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: settingsProvider.isDark ? AppTheme.dark : AppTheme.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
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
                      task.title,
                      style: textTheme.titleMedium
                          ?.copyWith(color: AppTheme.primary, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      task.description,
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
          ),
        ),
      ),
    );
  }
}
