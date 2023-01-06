import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/done_todo_service.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/ui/pages/done_todo_page.dart';
import 'package:todo_app/ui/pages/todo_page.dart';

class App extends StatefulWidget {
  const App({super.key});
  static const List<Widget> _widgetOptions = <Widget>[
    TodoPage(),
    DoneTodoPage(),
  ];

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoService()),
        ChangeNotifierProvider(create: (_) => DoneTodoService()),
      ],
      child: MaterialApp(
        theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.green)),
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: Center(
              child: App._widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.task_rounded),
                  label: 'DoneTodos',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color.fromARGB(255, 36, 189, 16),
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
