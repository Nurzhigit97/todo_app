import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/todo_models/todo_model.dart';

class AddTodo extends StatelessWidget {
  AddTodo({Key? key}) : super(key: key);

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoService = context.read<TodoService>();
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                actions: [
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Add todo...'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_textController.text.isEmpty) return;
                          todoService.addTodo(
                            TodoModel(
                                title: _textController.text,
                                createdAt: [
                                  DateTime.now().toString().split('.')[0]
                                ].join(''),
                                isChecked: false),
                          );
                          _textController.text = '';
                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
