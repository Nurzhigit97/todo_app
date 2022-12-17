import 'package:flutter/material.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/ui/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: loginController,
              decoration: const InputDecoration(
                hintText: 'Enter login...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter password...',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () => login(context),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

// Methods
  void login(context) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: loginController.text, password: passwordController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const App()),
      );
    } catch (e) {
      throw FormatException('Error auth firebase: $e');
    }
  }
}
