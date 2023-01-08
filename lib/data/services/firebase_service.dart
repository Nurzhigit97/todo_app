import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:flutter/material.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/home_page.dart';
import 'package:todo_app/ui/authScreens//sign_in.dart';

class FirebaseService {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  handleAuthState() {
    return StreamBuilder(
        stream: firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const App();
          } else {
            return signOut();
            // Если нужно сделаем вход через email
            // return SignIn();
          }
        });
  }

  login(
      {required BuildContext context,
      required TextEditingController emailController,
      required TextEditingController passwordController}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => HomePage())));
    } on firebase_auth.FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message.toString()),
        ),
      );
    }
  }

  Future register(
      {required BuildContext context,
      required TextEditingController emailController,
      required TextEditingController passwordController}) async {
    firebase_auth.FirebaseAuth firebaseAuth =
        firebase_auth.FirebaseAuth.instance;

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => SignIn())));
    } on firebase_auth.FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message.toString()),
        ),
      );
    }
  }

  signOut() {
    firebaseAuth.signOut();
  }
}
