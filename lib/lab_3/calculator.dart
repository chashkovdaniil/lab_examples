import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  static const routeName = '/lab_3';

  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final grid = [
    ['AC', '-/+', 'X', '/'],
    ['1', '2', '3', '-'],
    ['4', '5', '6', '+'],
    ['7', '8', '9', ','],
    ['0', '=']
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
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Text('Ответ: '),
                  if (result != null) Text('${result?.replaceAll('.', ',')}'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Text('Введено: '),
                  if (enteredOperation.isNotEmpty)
                    Text(enteredOperation)
                  else if (numberTwo.isNotEmpty)
                    Text(numberTwo.replaceAll('.', ','))
                ],
              ),
            ),
            const Spacer(),
            for (final row in grid)
              Row(
                children: [
                  for (final symbol in row)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 80,
                            maxHeight: 80,
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
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
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }

  _onTap(String symbol) {
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

      if (numberTwo.isEmpty) {
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
      // this.numberEntered = null;
      numberOne = '';
      numberTwo = '';
      result = null;
    } else if (symbol == '-/+') {
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
    return result.toString();
  }
}
