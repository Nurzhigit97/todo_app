import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo_models/todo_model.dart';

class TodoService with ChangeNotifier {
  // List<TodoModel> todos = [];
  //! start use FireBase
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// get current user
  User? get _currentUser => FirebaseAuth.instance.currentUser;

  /// get user todos collection ref
  CollectionReference<Map<String, dynamic>> _userTodosRef() {
    final String userId = _currentUser!.uid;
    final ref = FirebaseFirestore.instance.collection('users/$userId/todos');
    return ref;
  }

  Stream<List<TodoModel>> readTodo() {
    return _userTodosRef()
        .orderBy('priority', descending: false) // sort by priority
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TodoModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future addTodo(TodoModel todoModel) async {
    //! local todosList
    // todos.add(todoModel);
    final docTodo = _userTodosRef().doc();
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

  Future removeTodo(String idTodo) async {
    //! local todosList
    /* var index = todos.indexWhere((element) => element.id == idTodo);
    todos.removeAt(index); */

    final docTodo = _userTodosRef().doc(idTodo);
    await docTodo.delete();

    notifyListeners();
  }

  Future updateTodo(TodoModel todoModel) async {
    //! local todosList
    // var index = todos.indexWhere((el) => el.id == todoModel.id);
    // todos[index] = todoModel;

    await _userTodosRef().doc(todoModel.id).update({'title': todoModel.title});
    notifyListeners();
  }

  Future updatePriority(TodoModel todoModel) async {
    await _userTodosRef()
        .doc(todoModel.id)
        .update({'priority': todoModel.priority});
    notifyListeners();
  }

  Future isDoneTodo(String id, bool isDone) async {
    //! local todosList
    // var index = todos.indexWhere((el) => el.id == todoModel.id);
    // todos[index] = todoModel;
    _userTodosRef().doc(id).update({'isChecked': isDone});
    notifyListeners();
  }
}
