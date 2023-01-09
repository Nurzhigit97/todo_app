import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/authScreens/sign_in.dart';

class RegisteredDialog extends StatefulWidget {
  static String route = 'registeredDialog';
  const RegisteredDialog({Key? key}) : super(key: key);

  @override
  State<RegisteredDialog> createState() => _RegisteredDialogState();
}

class _RegisteredDialogState extends State<RegisteredDialog> {
  @override
  Widget build(BuildContext context) {
    // Получаем текущий пользователь
    User? user = FirebaseAuth.instance.currentUser;

    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          content: Container(
            constraints: const BoxConstraints(maxHeight: 150),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(user?.displayName ?? ''),
                    Text(user?.email ?? ''),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Логин',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, SignIn.route);
              },
            )
          ],
        ),
      ),
      icon: const Icon(Icons.person),
    );
  }
}
