import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/services/todo_models/todo_model.dart';

class DoneTodoService with ChangeNotifier {
  /// get current user
  User? get _currentUser => FirebaseAuth.instance.currentUser;

  /// get user done todos collection ref
  CollectionReference<Map<String, dynamic>> _userTodosRef() {
    final userId = _currentUser?.uid;
    final ref = FirebaseFirestore.instance.collection('users/$userId/doneTodo');
    return ref;
  }

  Stream<List<TodoModel>> readDoneTodo() => _userTodosRef().snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => TodoModel.fromJson(doc.data())).toList(),
      );

  addToDone(TodoModel todoModel) async {
    final docTodo = _userTodosRef().doc();
    final todo = TodoModel(
      id: docTodo.id,
      title: todoModel.title,
      createdAt: [DateTime.now().toString().split('.')[0]].join(''),
      isChecked: false,
      priority: todoModel.priority,
    );
    final json = todo.toJson();
    await docTodo.set(json);

    notifyListeners();
  }

  removeDoneTodo(idTodo) async {
    final docTodo = _userTodosRef().doc(idTodo);
    await docTodo.delete();

    notifyListeners();
  }
}
