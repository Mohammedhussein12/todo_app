import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_services/firebase_services.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:todo_app/utils/app_theme.dart';

import '../../helper_methods/show_toast.dart';
import '../settings/settings_provider.dart';
import 'edit_task_screen.dart';

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
                backgroundColor: AppTheme.red,
                foregroundColor: AppTheme.white,
                icon: Icons.delete,
                onPressed: (context) async {
                  await FirebaseServices.deleteTaskFromFireStore(task.id)
                      .timeout(const Duration(microseconds: 100),
                          onTimeout: () {
                    tasksProvider.getTasks();
                  }).catchError(() {
                    showToast(
                        msg: 'oops! Something went wrong.',
                        backgroundColor: AppTheme.red);
                  });
                },
              ),
              SlidableAction(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.white,
                icon: Icons.edit,
                onPressed: (context) {
                  Navigator.pushNamed(
                    context,
                    EditTaskScreen.routeName,
                    arguments: task,
                  );
                },
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
            padding: const EdgeInsetsDirectional.all(15),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 12),
                  height: 62,
                  width: 4,
                  color: task.isDone ? AppTheme.green : AppTheme.primary,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: task.isDone
                          ? textTheme.titleMedium
                              ?.copyWith(color: AppTheme.green, fontSize: 16)
                          : textTheme.titleMedium
                              ?.copyWith(color: AppTheme.primary, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      task.description,
                      style: task.isDone
                          ? textTheme.titleMedium
                              ?.copyWith(color: AppTheme.green, fontSize: 12)
                          : textTheme.titleMedium
                              ?.copyWith(color: AppTheme.primary, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    task.isDone = !task.isDone;
                    await FirebaseServices.updateTaskStatus(
                            task.id, task.isDone)
                        .timeout(
                      const Duration(microseconds: 100),
                      onTimeout: () {
                        tasksProvider.getTasks();
                        print(task.isDone);
                      },
                    );
                  },
                  child: task.isDone
                      ? Text(
                          AppLocalizations.of(context)!.done,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppTheme.green),
                        )
                      : Container(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
