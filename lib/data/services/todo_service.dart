import 'package:flutter/cupertino.dart';
import 'package:todo_app/todo_models/todo_model.dart';

class TodoService with ChangeNotifier {
  List<TodoModel> todos = [];
  addTodo(TodoModel todoModel) {
    todos.add(todoModel);
    notifyListeners();
  }

  removeTodo(idTodo) {
    todos.removeWhere((element) => element.id == idTodo);
    notifyListeners();
  }

  updateTodo(TodoModel todoModel) {
    var index = todos.indexWhere((el) => el.id == todoModel.id);
    if (index != -1) todos[index] = todoModel;
    notifyListeners();
  }
}
