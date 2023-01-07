import 'package:flutter/material.dart';

priority(priority) {
  Color? priorityColor;

  switch (priority) {
    case '1':
      priorityColor = Colors.red;
      break;
    case '2':
      priorityColor = Colors.green;
      break;
    case '3':
      priorityColor = Colors.orange;
      break;
    default:
      priorityColor = null;
  }
  return priorityColor;
}
