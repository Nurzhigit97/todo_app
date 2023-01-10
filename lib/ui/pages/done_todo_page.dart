import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/done_todo_service.dart';
import 'package:todo_app/data/services/todo_models/todo_model.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/ui/widgets/capitalize.dart';
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
            return Text(
                '${LocaleKeys.errorGetDataFirebase.tr()} ${snapshot.error}');
          }

          if (snapshot.hasData) {
            var todos = snapshot.data;
            if (todos!.isEmpty) {
              return Center(
                child: Text(LocaleKeys.dontHaveTask.tr()),
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
                          capitalize(todos[index].title.toString()),
                          style: const TextStyle(fontSize: 18),
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
