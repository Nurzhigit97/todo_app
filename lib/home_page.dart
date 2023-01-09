import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/toggle_theme_service.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/ui/authScreens/registered_dialog.dart';
import 'package:todo_app/ui/pages/done_todo_page.dart';
import 'package:todo_app/ui/pages/todo_page.dart';
import 'package:todo_app/ui/widgets/choose_lang.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  static String route = "/homePage";
  HomePage({super.key});
  List<Widget> widgetOptions = <Widget>[
    const TodoPage(),
    const DoneTodoPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final themeToggle = context.watch<ThemeToggleService>();

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(LocaleKeys.nameApp.tr()),
            actions: [
              const ChooseLang(),
              IconButton(
                icon: Icon(themeToggle.isDark
                    ? Icons.sunny
                    : Icons.nightlight_outlined),
                onPressed: () => themeToggle.isToggle(),
              ),
              const RegisteredDialog(),
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
    );
  }
}
