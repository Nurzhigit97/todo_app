import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:todo_app/data/services/firebase_auth_service.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
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
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 5, left: 10),
                        suffixIcon: const Icon(Icons.alternate_email_sharp),
                        hintText: LocaleKeys.enterEmail.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? LocaleKeys.errorTextFieldEmail.tr()
                              : null,
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
                      hintText: LocaleKeys.enterPassword.tr(),
                      border: PasswordBorder(
                        border: const OutlineInputBorder(),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(width: 2, color: Colors.red.shade200),
                        ),
                      ),
                      errorMessage: LocaleKeys.errorTextFieldPassword.tr(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => FirebaseAuthService().login(
                          context: context,
                          emailController: _emailController,
                          passwordController: _passwordController),
                      child: Text(LocaleKeys.login.tr()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LocaleKeys.ifDontHaveAccaunt.tr()),
                        TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, SignUp.route),
                          child: Text(LocaleKeys.register.tr()),
                        ),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: Text(LocaleKeys.signOut.tr()),
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
