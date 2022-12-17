import 'package:flutter/material.dart';
import 'package:todo_app/ui/pages/todo_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

// ignore: must_be_immutable
class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  void signup() async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: 'pow@gmail.com', password: '12345678');
    } catch (e) {
      print('Error auth firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              signup();
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
