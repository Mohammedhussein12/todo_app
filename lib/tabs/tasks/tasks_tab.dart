import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_services/firebase_services.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/task_item.dart';

import '../../utils/app_theme.dart';
import '../settings/settings_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  List<TaskModel> tasks = [];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    var provider = Provider.of<SettingsProvider>(context);
    final textTheme = Theme.of(context).textTheme;
    if (tasks.isEmpty) {
      getTasks();
    }
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight * 0.20,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
              ),
              PositionedDirectional(
                start: 20,
                top: 15,
                child: SafeArea(
                  child: Text(
                    AppLocalizations.of(context)!.to_do_list,
                    style: textTheme.titleLarge,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: screenHeight * 0.155),
                child: EasyInfiniteDateTimeLine(
                  locale: provider.languageCode,
                  dayProps: EasyDayProps(
                    height: 79,
                    width: 58,
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: provider.isDark ? AppTheme.dark : AppTheme.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dayNumStyle: textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: provider.isDark
                              ? AppTheme.white
                              : AppTheme.black),
                      dayStrStyle: textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: provider.isDark
                              ? AppTheme.white
                              : AppTheme.black),
                    ),
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: provider.isDark ? AppTheme.dark : AppTheme.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dayStrStyle: textTheme.titleMedium
                          ?.copyWith(fontSize: 15, color: AppTheme.primary),
                      dayNumStyle: textTheme.titleMedium
                          ?.copyWith(fontSize: 15, color: AppTheme.primary),
                    ),
                    dayStructure: DayStructure.dayStrDayNum,
                  ),
                  showTimelineHeader: false,
                  firstDate: DateTime.now().subtract(
                    const Duration(days: 365),
                  ),
                  focusDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsetsDirectional.only(top: 15),
              itemBuilder: (context, index) => TaskItem(
                task: tasks[index],
              ),
              itemCount: tasks.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getTasks() async {
    tasks = await FirebaseServices.getTasksFromFireStore();
    setState(() {});
  }
}
