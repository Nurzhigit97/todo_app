// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/data/services/todo_models/todo_model.dart';
import 'package:todo_app/generated/locale_keys.g.dart';

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
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: LocaleKeys.editTextField.tr()),
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
                            var tempTodo = TodoModel(
                              title: textController.text,
                            );

                            tempTodo.id = valueTodos!.id;
                            todoService.updateTodo(tempTodo);

                            Navigator.pop(context);
                          },
                          child: Text(LocaleKeys.edit.tr()),
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
          PopupMenuItem(
            value: 'edit',
            child: Text(LocaleKeys.edit.tr()),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Text(LocaleKeys.delete.tr()),
          ),
          PopupMenuItem(
            onTap: () {
              var tempTodo = TodoModel(priority: '1');
              //! update id
              tempTodo.id = valueTodos!.id;
              todoService.updatePriority(tempTodo);
            },
            child: Text(
              LocaleKeys.important.tr(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              var tempTodo = TodoModel(priority: "2");
              //! update id
              tempTodo.id = valueTodos!.id;
              todoService.updatePriority(tempTodo);
            },
            child: Text(
              LocaleKeys.lessImportant.tr(),
              style: const TextStyle(color: Colors.green),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              var tempTodo = TodoModel(priority: '3');
              //! update id
              tempTodo.id = valueTodos!.id;
              todoService.updatePriority(tempTodo);
            },
            child: Text(
              LocaleKeys.doIfYouWant.tr(),
              style: const TextStyle(color: Colors.orange),
            ),
          ),
        ];
      },
    );
  }
}
