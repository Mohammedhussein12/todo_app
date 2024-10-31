import 'package:flutter/cupertino.dart';

import '../../firebase_services/firebase_services.dart';
import '../../models/task_model.dart';

class TasksProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getTasks(String userId) async {
    tasks = await FirebaseServices.getTasksFromFireStore(userId);
    tasks = tasks
        .where(
          (task) =>
              task.date.day == selectedDate.day &&
              task.date.month == selectedDate.month &&
              task.date.year == selectedDate.year,
        )
        .toList();

    tasks.sort(
      (TaskModel task1, TaskModel task2) => task1.date.compareTo(task2.date),
    );
    notifyListeners();
  }

  void getSelectedDateTasks(DateTime date, String userId) {
    selectedDate = date;
    getTasks(userId);
  }

  void resetData() {
    tasks = [];
    selectedDate = DateTime.now();
  }
}
