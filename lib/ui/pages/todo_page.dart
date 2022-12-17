import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/todo_models/todo_model.dart';
import 'package:todo_app/ui/widgets/add_todo.dart';
import 'package:todo_app/ui/widgets/popup_menu_item.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoService = context.read<TodoService>();
    return Scaffold(
      body: StreamBuilder<List<TodoModel>>(
        stream: TodoService().readTodo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error get todos from Firebase ${snapshot.error}');
          }

          if (snapshot.hasData) {
            final todos = snapshot.data;
            return todos!.isEmpty
                ? const Center(
                    child: Text('NO TODO'),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            //! UI
                            return Row(
                              children: [
                                Checkbox(
                                  value: todos[index].isChecked,
                                  onChanged: (bool? value) {
                                    todoService.isDoneTodo(
                                        todos[index].id, value);
                                  },
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      '${todos[index].title!.length > 25 ? todos[index].title!.substring(0, 25) + "..." : todos[index].title}',
                                      style: TextStyle(
                                          decoration: todos[index].isChecked!
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          fontSize: 20),
                                    ),
                                    subtitle: Text('${todos[index].createdAt}'),
                                    trailing: PopupItem(
                                      valueTodos: todos[index],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: AddTodo(),
    );
  }
}
