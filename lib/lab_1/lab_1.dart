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
            AnimatedOpacity(
              opacity: _show ? 1.0 : 0.0,
              duration: baseDuration,
              child: const Text('Hello, world!'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => setState(() => _show = !_show),
              child: const Text('Отобразить'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
