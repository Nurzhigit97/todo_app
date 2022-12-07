import 'package:flutter/material.dart';

class TodoModel {
  String name;
  String dateTime;
  bool isChecked;

  TodoModel(
      {required this.name, required this.dateTime, required this.isChecked});

  @override
  String toString() {
    return '{ ${this.name}, ${this.dateTime} ${isChecked}}';
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final textController = TextEditingController();
  List<TodoModel> todos = [];

  @override
  Widget build(BuildContext context) {
    print(todos);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoApp'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Add todo...'),
                onEditingComplete: () {
                  setState(() {
                    todos.add(
                      TodoModel(
                          name: textController.text,
                          dateTime: '${[
                            DateTime.now().toString().split('.')[0]
                          ].join('')}',
                          isChecked: true),
                    );
                    textController.text = '';
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
                        IconButton(
                            icon: const Icon(Icons.check_box_outline_blank),
                            onPressed: () {
                              setState(() {
                                todos[index].isChecked =
                                    !todos[index].isChecked;
                              });
                            }),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              todos[index].name,
                              style: TextStyle(
                                  decoration: todos[index].isChecked == false
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  fontSize: 20),
                            ),
                            subtitle: Text(todos[index].dateTime),
                            trailing: IconButton(
                                icon: const Icon(Icons.create),
                                onPressed: () {
                                  setState(() {
                                    todos[index].isChecked =
                                        !todos[index].isChecked;
                                  });
                                }),
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
}
