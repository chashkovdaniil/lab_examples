import 'package:examples/lab_5/to_do_app_bar.dart';
import 'package:examples/lab_5/to_do_inherited.dart';
import 'package:examples/lab_5/to_do_style.dart';
import 'package:flutter/material.dart';

import 'to_do_model.dart';

class ToDoEditPage extends StatefulWidget {
  final ToDo toDo;

  const ToDoEditPage({Key? key, required this.toDo}) : super(key: key);

  @override
  State<ToDoEditPage> createState() => _ToDoEditPageState();
}

class _ToDoEditPageState extends State<ToDoEditPage> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController titleEditingController;
  late final TextEditingController textEditingController;
  DateTime? _dateFinished;
  bool? _isDone;

  @override
  void initState() {
    super.initState();
    titleEditingController = TextEditingController(text: widget.toDo.title);
    textEditingController = TextEditingController(text: widget.toDo.text);
    _dateFinished = widget.toDo.dateFinished;
    _isDone = widget.toDo.isDone;
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ToDoAppBar(
        title: 'Редактирование',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                TextFormField(
                  controller: titleEditingController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Укажите значение';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Укажите заголовок *'),
                  ),
                ),
                TextFormField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    label: Text('Укажите описание *'),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Укажите значение';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    if (_dateFinished != null)
                      Text(
                        '${_dateFinished?.day}.${_dateFinished?.month}.${_dateFinished?.year}',
                      ),
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _dateFinished ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030, 01, 01),
                        );
                        _dateFinished = date;
                        setState(() {});
                      },
                      child: const Text('Указать дату дедлайна'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  ToDoNotifier.of(context).remove(widget.toDo);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
              ),
              ElevatedButton(
                onPressed: () {
                  final newToDo = widget.toDo.copyWith(
                    title: titleEditingController.text,
                    text: textEditingController.text,
                    isDone: !widget.toDo.isDone,
                    dateFinished: _dateFinished,
                  );
                  ToDoNotifier.of(context).update(newToDo);
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(
                          'Поздравляем. '
                          '${widget.toDo.isDone ? 'Задача не выполнена' : 'Задача выполнена'}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Ок'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ToDoStyle.buttonStyle,
                child: widget.toDo.isDone
                    ? const Text("Отменить выполние")
                    : const Text("Выполнить"),
              ),
              IconButton(
                onPressed: () {
                  final newToDo = widget.toDo.copyWith(
                    title: titleEditingController.text,
                    text: textEditingController.text,
                    isDone: _isDone,
                    dateFinished: _dateFinished,
                  );
                  ToDoNotifier.of(context).update(newToDo);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save),
              ),
            ],
          )
        ],
      ),
    );
  }
}
