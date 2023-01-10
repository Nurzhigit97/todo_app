import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:todo_app/data/services/firebase_auth_service.dart';
import 'package:todo_app/ui/authScreens/sign_up.dart';

class SignIn extends StatefulWidget {
  static String route = 'signIn';
  const SignIn({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
                        suffixIcon: Icon(Icons.alternate_email_sharp),
                        hintText: 'Введите почту...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordField(
                      controller: _passwordController,
                      passwordConstraint: r'.*[@$#.*].*',
                      inputDecoration: PasswordDecoration(
                        inputPadding: const EdgeInsets.only(top: 5, left: 10),
                      ),
                      hintText: 'Введите пароль...',
                      border: PasswordBorder(
                        border: const OutlineInputBorder(),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(width: 2, color: Colors.red.shade200),
                        ),
                      ),
                      errorMessage:
                          'Должен содержать специальный символ . * @ # \$',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => FirebaseAuthService().login(
                          context: context,
                          emailController: _emailController,
                          passwordController: _passwordController),
                      child: const Text('Войти'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Нет учетной записи?"),
                        TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, SignUp.route),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Выйти'),
                      onPressed: () {
                        FirebaseAuthService().signOut();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
