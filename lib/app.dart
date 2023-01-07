import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/done_todo_service.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/data/services/toggle_theme_service.dart';
import 'package:todo_app/ui/pages/done_todo_page.dart';
import 'package:todo_app/ui/pages/todo_page.dart';

class App extends StatefulWidget {
  const App({super.key});
  // ignore: prefer_final_fields

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Widget> widgetOptions = <Widget>[
    const TodoPage(),
    DoneTodoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoService()),
        ChangeNotifierProvider(create: (_) => DoneTodoService()),
        ChangeNotifierProvider(create: (context) => ThemeToggleService()),
      ],
      // Builder- for fix error can't get current context ThemeProvider
      child: Builder(builder: (context) {
        final themeToggle = Provider.of<ThemeToggleService>(context);

        return MaterialApp(
          theme: themeToggle.isDark
              ? ThemeToggleService.lightTheme
              : ThemeToggleService.darkTheme,
          debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('TODO'),
                  actions: [
                    IconButton(
                      icon: Icon(themeToggle.isDark
                          ? Icons.sunny
                          : Icons.nightlight_outlined),
                      onPressed: () => themeToggle.isToggle(),
                    ),
                  ],
                  bottom: const TabBar(
                    tabs: [
                      Icon(Icons.home),
                      Icon(Icons.task_alt_outlined),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: widgetOptions,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
