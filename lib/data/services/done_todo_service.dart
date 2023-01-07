import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo_models/todo_model.dart';

class DoneTodoService with ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<TodoModel>> readDoneTodo() =>
      FirebaseFirestore.instance.collection('doneTodo').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => TodoModel.fromJson(doc.data()))
                .toList(),
          );

  addToDone(TodoModel todoModel) async {
    final docTodo = FirebaseFirestore.instance.collection('doneTodo').doc();
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
    final docTodo = firebaseFirestore.collection('doneTodo').doc(idTodo);
    await docTodo.delete();

    notifyListeners();
  }
}
