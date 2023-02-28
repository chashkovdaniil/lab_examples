import 'package:flutter/material.dart';

import '../constants.dart';

class HelloWorldPage extends StatefulWidget {
  static const routeName = '/lab_1';

  const HelloWorldPage({Key? key}) : super(key: key);

  @override
  State<HelloWorldPage> createState() => _HelloWorldPageState();
}

class _HelloWorldPageState extends State<HelloWorldPage> {
  bool _show = false;
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello, World'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: 'Введите текст'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => setState(() {}),
              child: Text('Отобразить'),
            ),
            const SizedBox(height: 10),
            AnimatedOpacity(
              opacity: textEditingController.value.text.isNotEmpty ? 1.0 : 0.0,
              duration: baseDuration,
              child: Text(textEditingController.value.text),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
