import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:flutter/material.dart';
import 'package:todo_app/home_page.dart';
import 'package:todo_app/ui/authScreens//sign_in.dart';

class FirebaseAuthService {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  StreamBuilder<firebase_auth.User?> handleAuthState() {
    return StreamBuilder(
        stream: firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const SignIn();
          }
        });
  }

  Future login(
      {required context,
      required emailController,
      required passwordController}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, HomePage.route);
    } on firebase_auth.FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message.toString()),
        ),
      );
    }
    return null;
  }

  Future register(
      {required context,
      required emailController,
      required passwordController}) async {
    firebase_auth.FirebaseAuth firebaseAuth =
        firebase_auth.FirebaseAuth.instance;

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, SignIn.route);
    } on firebase_auth.FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message.toString()),
        ),
      );
    }
  }

  void signOut() {
    firebaseAuth.signOut();
  }
}
