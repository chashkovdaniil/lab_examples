import 'dart:math';

import 'package:flutter/material.dart';

class QuadraticEquation extends StatefulWidget {
  static const routeName = '/lab_2';

  const QuadraticEquation({Key? key}) : super(key: key);

  @override
  State<QuadraticEquation> createState() => _QuadraticEquationState();
}

class _QuadraticEquationState extends State<QuadraticEquation> {
  late final TextEditingController _textEditingControllerA;
  late final TextEditingController _textEditingControllerB;
  late final TextEditingController _textEditingControllerC;

  List<String> _result = [];

  @override
  void initState() {
    super.initState();
    _textEditingControllerA = TextEditingController();
    _textEditingControllerB = TextEditingController();
    _textEditingControllerC = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingControllerA.dispose();
    _textEditingControllerB.dispose();
    _textEditingControllerC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Квадратичное уравнение'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const Text('Дробные числа через точку вводить'),
            _CoTextField(
              textEditingController: _textEditingControllerA,
              symbol: 'A',
            ),
            _CoTextField(
              textEditingController: _textEditingControllerB,
              symbol: 'B',
            ),
            _CoTextField(
              textEditingController: _textEditingControllerC,
              symbol: 'C',
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300,
              ),
              child: Column(
                children: [
                  const Text('Ответ: '),
                  if (_result.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 0; i < _result.length; i++) ...[
                          const SizedBox(width: 10),
                          Text('${_result[i]}'),
                          const SizedBox(width: 10),
                          if (_result.length > 1 && i != _result.length - 1)
                            Text('и')
                        ]
                      ],
                    ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          child: Text('Вычислить'),
          onPressed: () {
            try {
              _calculate();
            } on FormatException catch (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Нельзя такое вводить и все значения должны быть заполнены',
                  ),
                ),
              );
            }
            setState(() {});
          },
        ),
      ),
    );
  }

  void _calculate() {
    _result.clear();
    final a = double.parse(_textEditingControllerA.text);
    final b = double.parse(_textEditingControllerB.text);
    final c = double.parse(_textEditingControllerC.text);

    if (a == 0) {
      if (b == 0) {
        _result.add('Нет корня');
        return;
      }
      final x = -c / b;
      _result.add(x.toStringAsFixed(2));

      return;
    }
    final d = b * b - 4 * a * c;
    if (d < 0) {
      _result.add('Нет корня');
      return;
    }
    if (d == 0) {
      final x = -b / (2 * a);
      _result.add(x.toStringAsFixed(2));
      return;
    }
    final x1 = (-b - sqrt(d)) / (2 * a);
    final x2 = (-b + sqrt(d)) / (2 * a);
    _result.add(x1.toStringAsFixed(2));
    _result.add(x2.toStringAsFixed(2));
  }
}

class _CoTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String symbol;

  const _CoTextField({
    Key? key,
    required this.textEditingController,
    required this.symbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(hintText: 'Коэффициент $symbol'),
      keyboardType: const TextInputType.numberWithOptions(signed: true),
    );
  }
}
