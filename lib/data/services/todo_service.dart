import 'package:flutter/cupertino.dart';
import 'package:todo_app/todo_models/todo_model.dart';

class TodoService with ChangeNotifier {
  List<TodoModel> todos = [];
  addTodo(TodoModel todoModel) {
    todos.add(todoModel);
    notifyListeners();
  }

  removeTodo(idTodo) {
    var index = todos.indexWhere((element) => element.id == idTodo);
    if (index != -1) todos.removeAt(index);
    notifyListeners();
  }

  updateTodo(TodoModel todoModel) {
    var index = todos.indexWhere((el) => el.id == todoModel.id);
    if (index != -1) todos[index] = todoModel;
    notifyListeners();
  }
}
