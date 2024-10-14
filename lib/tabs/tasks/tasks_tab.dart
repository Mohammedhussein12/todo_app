import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/tabs/tasks/task_item.dart';

import '../../utils/app_theme.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final textTheme = Theme.of(context).textTheme;
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
                    'ToDo List',
                    style: textTheme.titleLarge,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: screenHeight * 0.155),
                child: EasyInfiniteDateTimeLine(
                  dayProps: EasyDayProps(
                    height: 79,
                    width: 58,
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dayNumStyle: textTheme.titleMedium
                          ?.copyWith(fontSize: 15, color: AppTheme.black),
                      dayStrStyle: textTheme.titleMedium
                          ?.copyWith(fontSize: 15, color: AppTheme.black),
                    ),
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: AppTheme.white,
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
              itemBuilder: (context, index) => const TaskItem(),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
