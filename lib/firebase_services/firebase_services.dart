import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/task_model.dart';

import '../models/user_model.dart';

class FirebaseServices {
  static CollectionReference<UserModel> getUsersCollection() {
    CollectionReference<UserModel> usersCollection = FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (documentSnapshot, options) =>
              UserModel.fromJson(documentSnapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
    return usersCollection;
  }

  static CollectionReference<TaskModel> getTasksCollection(String userId) {
    return getUsersCollection()
        .doc(userId)
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: (documentSnapshot, options) =>
              TaskModel.fromJson(documentSnapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toJson(),
        );
  }

  static Future<void> addTaskToFireStore(TaskModel task, String userId) {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userId);
    DocumentReference<TaskModel> doc = tasksCollection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModel>> getTasksFromFireStore(String userId) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userId);
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs
        .map((queryDocSnapshot) => queryDocSnapshot.data())
        .toList();
  }

  static deleteTaskFromFireStore(String taskId, String userId) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userId);
    return tasksCollection.doc(taskId).delete();
  }

  static updateTaskToFireStore(TaskModel task, String userID) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userID);
    return tasksCollection.doc(task.id).update(task.toJson());
  }

  static Future<void> updateTaskStatus(
      String taskId, bool isDone, String userId) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userId);
    return tasksCollection.doc(taskId).update({'isDone': isDone});
  }

  static Future<UserModel> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user =
        UserModel(id: credential.user!.uid, name: name, email: email);
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    await usersCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login(
      {required String email, required String password}) async {
    UserCredential credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentSnapshot<UserModel> documentSnapShot =
        await usersCollection.doc(credential.user!.uid).get();
    return documentSnapShot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();
}
