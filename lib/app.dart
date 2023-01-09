import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/done_todo_service.dart';
import 'package:todo_app/data/services/firebase_auth_service.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/data/services/toggle_theme_service.dart';
import 'package:todo_app/home_page.dart';
import 'package:todo_app/ui/authScreens/registered_dialog.dart';
import 'package:todo_app/ui/authScreens/sign_in.dart';
import 'package:todo_app/ui/authScreens/sign_up.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoService()),
        ChangeNotifierProvider(create: (_) => DoneTodoService()),
        ChangeNotifierProvider(create: (_) => ThemeToggleService()),
      ],
      // builder for fix bug cant find correct provider ThemeToggleService
      child: Builder(builder: (context) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: context.watch<ThemeToggleService>().isDark
              ? ThemeToggleService.lightTheme
              : ThemeToggleService.darkTheme,
          debugShowCheckedModeBanner: false,
          home: FirebaseAuthService().handleAuthState(),
          routes: getRoutes(),
        );
      }),
    );
  }

  Map<String, WidgetBuilder> getRoutes() => <String, WidgetBuilder>{
        HomePage.route: (_) => HomePage(),
        SignIn.route: (_) => const SignIn(),
        SignUp.route: (_) => const SignUp(),
        RegisteredDialog.route: (_) => const RegisteredDialog(),
      };
}
