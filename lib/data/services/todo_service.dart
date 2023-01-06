import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo_models/todo_model.dart';

class TodoService with ChangeNotifier {
  // List<TodoModel> todos = [];
  //! start use FireBase
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<TodoModel>> readTodo() =>
      FirebaseFirestore.instance.collection('todos').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => TodoModel.fromJson(doc.data()))
                .toList(),
          );

  addTodo(TodoModel todoModel) async {
    //! local todosList
    // todos.add(todoModel);
    final docTodo = FirebaseFirestore.instance.collection('todos').doc();
    final todo = TodoModel(
      id: docTodo.id,
      title: todoModel.title,
      createdAt: [DateTime.now().toString().split('.')[0]].join(''),
      isChecked: false,
    );
    final json = todo.toJson();
    await docTodo.set(json);

    notifyListeners();
  }

  removeTodo(idTodo) async {
    //! local todosList
    /* var index = todos.indexWhere((element) => element.id == idTodo);
    todos.removeAt(index); */

    final docTodo = firebaseFirestore.collection('todos').doc(idTodo);
    await docTodo.delete();

    notifyListeners();
  }

  updateTodo(TodoModel todoModel) async {
    //! local todosList
    // var index = todos.indexWhere((el) => el.id == todoModel.id);
    // todos[index] = todoModel;

    await firebaseFirestore
        .collection('todos')
        .doc(todoModel.id)
        .update({'title': todoModel.title});
    notifyListeners();
  }

  isDoneTodo(id, isDone) async {
    //! local todosList
    // var index = todos.indexWhere((el) => el.id == todoModel.id);
    // todos[index] = todoModel;
    FirebaseFirestore.instance
        .collection('todos')
        .doc(id)
        .update({'isChecked': isDone});
    notifyListeners();
  }
}
