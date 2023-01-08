import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChooseLang extends StatefulWidget {
  const ChooseLang({Key? key}) : super(key: key);

  @override
  State<ChooseLang> createState() => _ChooseLangState();
}

class _ChooseLangState extends State<ChooseLang> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
        underline: const SizedBox.shrink(),
        icon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.language_rounded,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        onChanged: (locale) {
          context.setLocale(locale ?? context.locale);
        },
        items: const [
          DropdownMenuItem(
            value: Locale('en'),
            child: Text(
              'EN',
            ),
          ),
          DropdownMenuItem(
            value: Locale('ky'),
            child: Text('KG'),
          ),
          DropdownMenuItem(
            value: Locale('ru'),
            child: Text('RU'),
          ),
        ],
        selectedItemBuilder: (context) {
          return [
            const Text(
              'EN',
            ),
            const Text(
              'KG',
            ),
            const Text(
              'RU',
            ),
          ];
        });
  }
}
