import 'package:flutter/cupertino.dart';

import '../../firebase_services/firebase_services.dart';
import '../../models/task_model.dart';

class TasksProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getTasks() async {
    tasks = await FirebaseServices.getTasksFromFireStore();
    tasks = tasks
        .where(
          (task) =>
              task.date.day == selectedDate.day &&
              task.date.month == selectedDate.month &&
              task.date.year == selectedDate.year,
        )
        .toList();

    tasks.sort(
      (TaskModel task1, TaskModel task2) => task2.date.compareTo(task1.date),
    );
    notifyListeners();
  }

  getSelectedDateTasks(DateTime date) {
    selectedDate = date;
    getTasks();
  }
}
