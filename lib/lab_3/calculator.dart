import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  static const routeName = '/lab_3';

  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final grid = [
    ['AC', '+/-', '/'],
    ['7', '8', '9', 'X'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['0', ',', '=']
  ];

  // String? numberEntered;
  String numberOne = '';
  String numberTwo = '';
  String enteredOperation = '';
  String operation = '';
  String? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        numberTwo.replaceAll('.', ','),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            for (final row in grid)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final symbol in row)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: _getFlex(symbol) == 2 ? 160 : 70,
                          maxHeight: 80,
                        ),
                        child: SizedBox(
                          width: _getFlex(symbol) == 2 ? 160 : 70,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              _onTap(symbol);

                              setState(() {});
                            },
                            child: Text(symbol),
                          ),
                        ),
                      ),
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }

  _onTap(String symbol) {
    if (numberTwo == 'Ошибка') {
      numberTwo = '0';
    }
    final num = int.tryParse(symbol);
    // final number = this.numberTwo;
    final isComma = symbol == ',';
    final isNum = num != null;
    if (isNum || isComma) {
      if (enteredOperation.isNotEmpty) {
        numberOne = numberTwo;
        numberTwo = '';
        operation = enteredOperation;
        enteredOperation = '';
      }

      if (numberTwo.isEmpty || double.parse(numberTwo) == 0.0) {
        if (isComma) {
          numberTwo = '0.';
        } else {
          numberTwo = num.toString();
        }
      } else {
        if (isComma) {
          if (numberTwo.contains('.')) {
            return;
          }
          numberTwo = '$numberTwo.';
        } else {
          numberTwo = '$numberTwo$num';
        }
      }
    } else if (['/', '+', 'X', '-'].contains(symbol)) {
      if (numberOne.isNotEmpty && numberTwo.isNotEmpty) {
        result = _calculate();
        numberOne = '';
      }
      if (numberTwo.isEmpty && symbol == '-') {
        numberTwo = '-';
      } else {
        enteredOperation = symbol;
      }
    } else if (symbol == 'AC') {
      enteredOperation = '';
      operation = '';
      numberOne = '';
      numberTwo = '';
      result = null;
    } else if (symbol == '+/-') {
      if (double.parse(numberTwo) == 0.0) {
        return;
      }
      if (numberTwo.isNotEmpty && numberTwo[0] == '-') {
        numberTwo = numberTwo.substring(1);
      } else {
        if (numberTwo.isEmpty) {
          numberTwo = '1';
        }
        numberTwo = '-$numberTwo';
      }
    } else if (symbol == '=') {
      result = _calculate();
    }
  }

  String _calculate() {
    if (numberTwo.isEmpty || numberOne.isEmpty) {
      return '';
    }
    final operation = this.operation;
    final firstNum = num.parse(numberOne);
    final secondNum = num.parse(numberTwo);
    num result;
    switch (operation) {
      case '-':
        result = firstNum - secondNum;
        break;
      case '+':
        result = firstNum + secondNum;
        break;
      case '/':
        result = firstNum / secondNum;
        break;
      case 'X':
        result = firstNum * secondNum;
        break;
      default:
        result = firstNum;
    }
    if (result % 1 == 0) {
      result = result.toInt();
    }
    numberTwo = result.toString();
    numberOne = '';
    if (numberTwo == 'Infinity') {
      numberTwo = 'Ошибка';
      return 'Ошибка';
    }
    return result.toString();
  }

  int _getFlex(String symbol) {
    if (symbol == 'AC') return 2;
    if (symbol == '0') return 2;
    return 1;
  }
}
