import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:todo_app/data/services/firebase_auth_service.dart';
import 'package:todo_app/ui/authScreens/sign_in.dart';

class SignUp extends StatefulWidget {
  static String route = 'signUp';

  const SignUp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5, left: 10),
                          suffixIcon: Icon(Icons.alternate_email_sharp),
                          hintText: 'Введите почту...',
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Введите правильный эл. почту'
                                : null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PasswordField(
                        controller: _passwordController,
                        passwordConstraint: r'.*[0-9].*',
                        inputDecoration: PasswordDecoration(
                          inputPadding: const EdgeInsets.only(top: 5, left: 10),
                        ),
                        hintText: 'Введите пароль...',
                        border: PasswordBorder(
                          border: const OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: Colors.red.shade200),
                          ),
                        ),
                        errorMessage: 'Должен содержать хотябы одну цифру',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final isValid = formKey.currentState!.validate();
                          // если введенные email и password не верны не даем доступ к регистрации
                          if (!isValid) return;
                          FirebaseAuthService().register(
                              context: context,
                              emailController: _emailController,
                              passwordController: _passwordController);
                        },
                        child: const Text('Регистрация'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Уже есть учетная запись?'),
                          TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, SignIn.route),
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
