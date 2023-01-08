import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/services/firebase_service.dart';
import 'package:todo_app/home_page.dart';
import 'package:todo_app/ui/authScreens/sign_in.dart';

class RegisteredDialog extends StatelessWidget {
  static String route = 'registeredDialog';
  const RegisteredDialog({Key? key}) : super(key: key);

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
            constraints: BoxConstraints(maxHeight: 150),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Если не авторизован показываем текст "Пройти авторизацию" иначе данные user
                FirebaseAuth.instance.currentUser != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('${user?.displayName ?? ''}'),
                          Text('${user?.email}'),
                        ],
                      )
                    : Text(
                        'Пройти авторизацию',
                        style: TextStyle(fontSize: 20),
                      ),
              ],
            ),
          ),
          actions: <Widget>[
            // Если не авторизован показываем кнопку логин иначе Выйти
            FirebaseAuth.instance.currentUser == null
                ? ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text(
                      'Логин',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () async {
                      await Navigator.of(context)
                          .pushReplacementNamed(SignIn.route);
                    },
                  )
                : ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Выйти'),
                    onPressed: () async {
                      // Чтобы могли переключать showIntro
                      // final prefs = await SharedPreferences.getInstance();
                      // prefs.setBool('showHome', false);
                      await FirebaseService().signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomePage())));
                    },
                  ),
          ],
        ),
      ),
      icon: Icon(Icons.person),
    );
  }
}
