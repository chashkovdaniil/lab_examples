import 'package:flutter/material.dart';

class ToDoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const ToDoAppBar({Key? key, required this.title}) : super(key: key);

  @override
  final Size preferredSize = const Size(double.infinity, 70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0.0,
    );
  }
}
