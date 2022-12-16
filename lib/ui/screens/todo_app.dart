import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/todo_models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
// Obtain shared preferences.
  final _uuid = const Uuid();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoService>(
      builder: (context, valueTodo, child) => ListView.builder(
        itemBuilder: (context, index) => Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add todo...'),
              onEditingComplete: () {
                setState(() {
                  if (_textController.text.isEmpty) return;
                  context.read<TodoService>().addTodo(
                        TodoModel(
                            id: _uuid.v4(),
                            todo: _textController.text,
                            createdAt: [DateTime.now().toString().split('.')[0]]
                                .join(''),
                            isChecked: false),
                      );

                  _textController.text = '';
                });
              },
            ),
            SizedBox(
              width: double.infinity,
              height: 500,
              child: ListView.builder(
                itemCount: valueTodo.todos.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Checkbox(
                        value: valueTodo.todos[index].isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            valueTodo.todos[index].isChecked = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            '${valueTodo.todos[index].todo}',
                            style: TextStyle(
                                decoration: valueTodo.todos[index].isChecked!
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                fontSize: 20),
                          ),
                          subtitle: Text(valueTodo.todos[index].createdAt!),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'edit') {}
                              if (value == 'delete') {
                                // remove by item
                                context
                                    .read<TodoService>()
                                    .removeTodo(valueTodo.todos[index].id!);
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ];
                            },
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
