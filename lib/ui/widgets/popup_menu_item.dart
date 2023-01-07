// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/todo_models/todo_model.dart';

// ignore: must_be_immutable
class PopupItem extends StatelessWidget {
  TodoModel? valueTodos;
  PopupItem({
    Key? key,
    this.valueTodos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoService = context.read<TodoService>();
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 'edit') {
          TextEditingController textController =
              TextEditingController(text: valueTodos!.title);
          showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  actions: [
                    TextField(
                      controller: textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Edit todo...'),
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
                            var tempTodo = TodoModel(
                              title: textController.text,
                            );

                            tempTodo.id = valueTodos!.id;
                            todoService.updateTodo(tempTodo);

                            Navigator.pop(context);
                          },
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                  ],
                )),
          );
          var tempTodo = TodoModel(title: textController.text);
          //! update id
          tempTodo.id = valueTodos!.id;
          todoService.updateTodo(tempTodo);
        }
        if (value == 'delete') {
          // remove by item
          context.read<TodoService>().removeTodo(valueTodos!.id!);
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
          PopupMenuItem(
            onTap: () {
              var tempTodo = TodoModel(priority: '1');
              //! update id
              tempTodo.id = valueTodos!.id;
              todoService.updatePriority(tempTodo);
            },
            child: const Text(
              'important',
              style: TextStyle(color: Colors.red),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              var tempTodo = TodoModel(priority: "2");
              //! update id
              tempTodo.id = valueTodos!.id;
              todoService.updatePriority(tempTodo);
            },
            child: const Text(
              'Less Important',
              style: TextStyle(color: Colors.green),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              var tempTodo = TodoModel(priority: '3');
              //! update id
              tempTodo.id = valueTodos!.id;
              todoService.updatePriority(tempTodo);
            },
            child: const Text(
              'If Want Do',
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ];
      },
    );
  }
}
