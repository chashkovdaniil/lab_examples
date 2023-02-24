import 'package:flutter/material.dart';

class ToDoStyle {
  static ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateColor.resolveWith(
      (states) => Colors.black87,
    ),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}
