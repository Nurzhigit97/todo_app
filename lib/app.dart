import 'package:flutter/material.dart';
import 'package:todo_app/ui/pages/register_page.dart';
import 'package:todo_app/ui/pages/todo_page.dart';

// ignore: must_be_immutable
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            icon: const Icon(Icons.login),
          ),
        ],
        centerTitle: true,
        title: const Text('TodoApp'),
      ),
      body: const TodoPage(),
    );
  }
}
