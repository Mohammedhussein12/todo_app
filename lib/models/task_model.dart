import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  static String collectionName = 'tasks';
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;

  TaskModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: (json['date'] as Timestamp).toDate(),
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': Timestamp.fromDate(date),
    'isDone': isDone
  };
}
