import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/done_todo_service.dart';
import 'package:todo_app/todo_models/todo_model.dart';
import 'package:todo_app/ui/widgets/choose_priority.dart';

class DoneTodoPage extends StatelessWidget {
  const DoneTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoService = context.read<DoneTodoService>();
    return Scaffold(
      body: StreamBuilder<List<TodoModel>>(
        stream: DoneTodoService().readDoneTodo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error get todos from Firebase ${snapshot.error}');
          }

          if (snapshot.hasData) {
            var todos = snapshot.data;
            if (todos!.isEmpty) {
              return const Center(
                child: Text("Don't have done Tasks"),
              );
            } else {
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  //! UI
                  return Card(
                    color: priority(todos[index].priority),
                    child: ListTile(
                        title: Text(
                          todos[index].title.toString(),
                          style: TextStyle(
                              decoration: todos[index].isChecked!
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontSize: 20),
                        ),
                        subtitle: Text('${todos[index].createdAt}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.restore_from_trash_outlined),
                          onPressed: () {
                            todoService.removeDoneTodo(todos[index].id);
                          },
                        )),
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
    );
  }
}
