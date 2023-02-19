import 'package:examples/lab_1/lab_1.dart';
import 'package:examples/lab_2/quadratic_equation.dart';
import 'package:examples/lab_3/calculator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HelloWorldPage.routeName: (_) => const HelloWorldPage(),
        QuadraticEquation.routeName: (_) => const QuadraticEquation(),
        CalculatorPage.routeName: (_) => const CalculatorPage(),
      },
      home: const MyHomePage(title: 'Examples of Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final labs = [
    HelloWorldPage.routeName,
    QuadraticEquation.routeName,
    CalculatorPage.routeName,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: labs.length,
          itemBuilder: (context, index) => ListTile(
            leading: Chip(
              label: Text('$index'),
            ),
            title: Text(labs[index]),
            onTap: () => Navigator.pushNamed(context, labs[index]),
          ),
        ),
      ),
    );
  }
}
