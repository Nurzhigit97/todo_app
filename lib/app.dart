import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/todo_models/todo_model.dart';
import 'package:uuid/uuid.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final TextEditingController _textController = TextEditingController();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  void signup() async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: 'pow@gmail.com', password: '12345678');
    } catch (e) {
      print('Error auth firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                signup();
              },
              icon: const Icon(Icons.login),
            ),
          ],
          centerTitle: true,
          title: const Text('TodoApp'),
        ),
        body: // TodoApp(),
            Consumer<TodoService>(
          builder: (context, valueTodo, child) =>
              StreamBuilder<List<TodoModel>>(
            stream: TodoService().readTodo(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error get todos from Firebase ${snapshot.error}');
              }
              if (snapshot.hasData) {
                final todos = snapshot.data;

                return todos!.isEmpty
                    ? const Center(
                        child: Text('NO TODO'),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 500,
                            child: ListView.builder(
                              itemCount: todos.length,
                              itemBuilder: (context, index) {
                                print(valueTodo);

                                return Row(
                                  children: [
                                    //! onClick change to
                                    Checkbox(
                                      value: todos[index].isChecked,
                                      onChanged: (bool? value) {
                                        FirebaseFirestore.instance
                                            .collection('todos')
                                            .doc(todos[index].id)
                                            .update({'isChecked': value});
                                      },
                                    ),
                                    Expanded(
                                      child: ListTile(
                                          title: Text(
                                            '${todos[index].title}',
                                            style: TextStyle(
                                                decoration: todos[index]
                                                        .isChecked!
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                                fontSize: 20),
                                          ),
                                          subtitle:
                                              Text('${todos[index].createdAt}'),
                                          trailing: popUpItem(todos[index])),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        floatingActionButton: addToFireStore(),
      ),
    );
  }

  popUpItem(id) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 'edit') {
          TextEditingController _textController =
              TextEditingController(text: id.title);
          showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  actions: [
                    TextField(
                      controller: _textController,
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
                              title: _textController.text,
                            );

                            tempTodo.id = id.id;
                            context.read<TodoService>().updateTodo(tempTodo);

                            Navigator.pop(context);
                          },
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                  ],
                )),
          );
          var tempTodo = TodoModel(title: _textController.text);
          //! update id
          tempTodo.id = id.id;
          context.read<TodoService>().updateTodo(tempTodo);
        }
        if (value == 'delete') {
          // remove by item
          context.read<TodoService>().removeTodo(id.id!);
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
    );
  }

  addToFireStore() {
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
                          context.read<TodoService>().addTodo(
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
