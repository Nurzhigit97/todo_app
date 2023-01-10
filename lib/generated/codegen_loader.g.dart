// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "nameApp": "Daily tasks",
  "addTodo": "Add todo...",
  "cancel": "Cancel",
  "add": "Add",
  "dontHaveTask": "Don't have tasks",
  "enterEmail": "Enter email...",
  "enterPassword": "Enter password...",
  "login": "Login",
  "register": "Register",
  "signOut": "Sign out",
  "errorTextFieldEmail": "Please enter a valid email.",
  "ifErrorTextField": "Must contain at least one number.",
  "errorTextFieldPassword": "Please enter a valid password.",
  "ifHaveAccaunt": "Already have an account?",
  "ifDontHaveAccaunt": "Don't have an account?",
  "edit": "Edit",
  "editTextField": "Edit task...",
  "delete": "Delete",
  "important": "Important",
  "lessImportant": "Less important",
  "doIfYouWant": "Do it if you want",
  "errorGetDataFirebase": "Error getting data from Firebase."
};
static const Map<String,dynamic> ky = {
  "nameApp": "Күнүмдүк тапшырмалар",
  "addTodo": "Тапшырма кошуу...",
  "cancel": "Чыгуу",
  "add": "Кошуу",
  "dontHaveTask": "Тапшырма жок",
  "enterEmail": "Электрондук почтаңызды киргизиңиз...",
  "enterPassword": "Сырсөздү киргизиңиз...",
  "login": "Кирүү",
  "register": "Каттоо",
  "signOut": "Чыгуу",
  "errorTextFieldEmail": "Сураныч, жарактуу электрондук почта дарегин киргизиңиз.",
  "ifErrorTextField": "Жок дегенде бир санды камтышы керек.",
  "errorTextFieldPassword": "Сураныч, туура сырсөздү киргизиңиз.",
  "ifHaveAccaunt": "Аккаунтуңуз бар болсо?",
  "ifDontHaveAccaunt": "Аккаунтуңуз жок болсо?",
  "edit": "Оңдоо",
  "editTextField": "Тапшырманы түзөтүү...",
  "delete": "Жок кылуу",
  "important": "Маанилүү",
  "lessImportant": "Азыраак маанилүү",
  "doIfYouWant": "Кылгың келсе жаса",
  "errorGetDataFirebase": "Firebase'тен берилиштерди алууда ката кетти"
};
static const Map<String,dynamic> ru = {
  "nameApp": "Повседневные задачи",
  "addTodo": "Добавить задачу...",
  "cancel": "Выйти",
  "add": "Добавить",
  "dontHaveTask": "Нет задач",
  "enterEmail": "Введите эл. почты...",
  "enterPassword": "Введите пароль...",
  "login": "Войти",
  "register": "Регистрация",
  "signOut": "Выйти",
  "errorTextFieldEmail": "Пожалуйста, введите правильный адрес электронной почты.",
  "ifErrorTextField": "Должен содержать хотя бы одно число.",
  "errorTextFieldPassword": "Пожалуйста, введите правильный пароль.",
  "ifHaveAccaunt": "Уже есть аккаунт?",
  "ifDontHaveAccaunt": "Нет аккаунта?",
  "edit": "Изменить",
  "editTextField": "Редактировать задачу...",
  "delete": "Удалить",
  "important": "Важный",
  "lessImportant": "Менее важный",
  "doIfYouWant": "Если хочешь делай",
  "errorGetDataFirebase": "Ошибка при получении данных из Firebase."
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ky": ky, "ru": ru};
}
