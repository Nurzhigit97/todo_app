import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/todo_models/todo_model.dart';
import 'package:uuid/uuid.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _uuid = const Uuid();
  final _textController = TextEditingController();
  List<TodoModel> todos = [];
  List<TodoModel> doneTodos = [];

  final prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    print('todos: $todos');
    print('done: $doneTodos');
// Obtain shared preferences.
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoApp'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Add todo...'),
                onEditingComplete: () {
                  setState(() {
                    if (_textController.text == '') return;
                    todos.add(
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
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    print(todos);
                    return Row(
                      children: [
                        Checkbox(
                          value: todos[index].isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              todos[index].isChecked = value!;

                              doneTodos.add(
                                TodoModel(
                                    id: _uuid.v4(),
                                    todo: _textController.text,
                                    createdAt: [
                                      DateTime.now().toString().split('.')[0]
                                    ].join(''),
                                    isChecked: false),
                              );
                            });
                          },
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              todos[index].todo,
                              style: TextStyle(
                                  decoration: todos[index].isChecked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  fontSize: 20),
                            ),
                            subtitle: Text(todos[index].createdAt),
                            trailing: PopupMenuButton(
                              onSelected: (value) {
                                if (value == 'edit') {}
                                if (value == 'delete') {
                                  // remove by item
                                  deleteById(todos[index].id);
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
        ],
      ),
    );
  }

  void deleteById(String id) {
    print('deleted: $id');
    todos.removeWhere((element) => element.id == id);
    setState(() {});
  }
}
