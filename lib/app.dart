import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/todo_app.dart';

class App extends StatelessWidget {
  const App({super.key});

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
        body: const TabBarView(
          children: [
            TodoApp(),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
