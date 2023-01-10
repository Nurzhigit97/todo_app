import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/data/services/todo_models/todo_model.dart';
import 'package:todo_app/generated/locale_keys.g.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: LocaleKeys.addTodo.tr()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(LocaleKeys.cancel.tr()),
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
                        child: Text(LocaleKeys.add.tr()),
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
