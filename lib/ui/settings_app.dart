import 'package:flutter/material.dart';
import 'package:todo_app/ui/home_page.dart';
import 'package:todo_app/ui/authScreens/registered_dialog.dart';
import 'package:todo_app/ui/authScreens/sign_in.dart';
import 'package:todo_app/ui/authScreens/sign_up.dart';

class SettingsApp {
  static Map<String, WidgetBuilder> getRoutes() => <String, WidgetBuilder>{
        HomePage.route: (_) => HomePage(),
        SignIn.route: (_) => const SignIn(),
        SignUp.route: (_) => const SignUp(),
        RegisteredDialog.route: (_) => const RegisteredDialog(),
      };
}
