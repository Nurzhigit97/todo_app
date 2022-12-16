import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/todo_models/todo_model.dart';
import 'package:uuid/uuid.dart';

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _uuid = const Uuid();

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.format_list_numbered_rtl),
              ),
              Tab(icon: Icon(Icons.playlist_add_check)),
            ],
          ),
          title: const Text('TodoApp'),
        ),
        body: TabBarView(
          children: [
            // TodoApp(),
            Consumer<TodoService>(
              builder: (context, valueTodo, child) => ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 500,
                      child: ListView.builder(
                        itemCount: valueTodo.todos.length,
                        itemBuilder: (context, index) {
                          print(valueTodo);

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
                                        decoration:
                                            valueTodo.todos[index].isChecked!
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                        fontSize: 20),
                                  ),
                                  subtitle:
                                      Text(valueTodo.todos[index].createdAt!),
                                  trailing: PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        var tempTodo = TodoModel(todo: 'Test');
                                        tempTodo.id = '1';
                                        context
                                            .read<TodoService>()
                                            .updateTodo(tempTodo);
                                        setState(() {});
                                      }
                                      if (value == 'delete') {
                                        // remove by item
                                        context.read<TodoService>().removeTodo(
                                            valueTodo.todos[index].id!);
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
            ),
            const Icon(Icons.directions_bike),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    actions: [
                      TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Add todo...'),
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
                              context.read<TodoService>().addTodo(
                                    TodoModel(
                                        id: _uuid.v4(),
                                        todo: _textController.text,
                                        createdAt: [
                                          DateTime.now()
                                              .toString()
                                              .split('.')[0]
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
        ),
      ),
    );
  }
}
