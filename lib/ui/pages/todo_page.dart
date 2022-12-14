import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/done_todo_service.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/data/services/todo_models/todo_model.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/ui/authScreens/sign_in.dart';
import 'package:todo_app/ui/widgets/add_todo.dart';
import 'package:todo_app/ui/widgets/capitalize.dart';
import 'package:todo_app/ui/widgets/choose_priority.dart';
import 'package:todo_app/ui/widgets/popup_menu_item.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoService = context.read<TodoService>();
    final doneTodoService = context.read<DoneTodoService>();

    return Scaffold(
      body: StreamBuilder<List<TodoModel>>(
        stream: TodoService().readTodo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${LocaleKeys.dontHaveTask.tr()} ${snapshot.error}');
          }

          if (snapshot.hasData) {
            final todos = snapshot.data;

            if (todos!.isEmpty) {
              return Center(
                child: Text(LocaleKeys.dontHaveTask.tr()),
              );
            } else {
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  //! UI
                  if (todos[index].id == null) {
                    Navigator.of(context).pushReplacementNamed(SignIn.route);
                  }
                  return Card(
                    color: priority(todos[index].priority),
                    child: ListTile(
                      leading: Checkbox(
                        value: todos[index].isChecked,
                        onChanged: (bool? value) async {
                          await todoService.isDoneTodo(
                              todos[index].id.toString(), value!);
                          if (todos[index].isChecked == false) {
                            doneTodoService.addToDone(
                              TodoModel(
                                id: todos[index].id,
                                title: todos[index].title,
                                createdAt: todos[index].createdAt,
                                isChecked: todos[index].isChecked,
                                priority: todos[index].priority,
                              ),
                            );

                            await todoService
                                .removeTodo(todos[index].id.toString());
                          }
                        },
                      ),
                      title: Text(
                        capitalize(todos[index].title.toString()),
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text('${todos[index].createdAt}'),
                      trailing: PopupItem(
                        valueTodos: todos[index],
                      ),
                    ),
                  );
                },
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: const AddTodo(),
    );
  }
}
