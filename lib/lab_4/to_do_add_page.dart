import 'package:examples/lab_4/to_do_app_bar.dart';
import 'package:examples/lab_4/to_do_inherited.dart';
import 'package:examples/lab_4/to_do_model.dart';
import 'package:examples/lab_4/to_do_style.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class ToDoAddPage extends StatefulWidget {
  static const routeName = '/todo_add';

  const ToDoAddPage({Key? key}) : super(key: key);

  @override
  State<ToDoAddPage> createState() => _ToDoAddPageState();
}

class _ToDoAddPageState extends State<ToDoAddPage> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController titleEditingController;
  late final TextEditingController textEditingController;
  DateTime? _dateFinished;

  @override
  void initState() {
    super.initState();
    titleEditingController = TextEditingController();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = ToDoNotifier.depend(context).list.length + 1;

    return Form(
      key: _key,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const ToDoAppBar(
          title: 'Добавление',
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: titleEditingController,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Укажите значение';
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text.rich(
                  TextSpan(
                    text: 'Укажите заголовок ',
                    children: [
                      TextSpan(
                        text: '*',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.red,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(
                label: Text('Краткое описание'),
              ),
              minLines: 1,
              maxLines: null,
              validator: (_) => null,
            ),
            Row(
              children: [
                if (_dateFinished != null)
                  Text(
                    Utils.formatDate(_dateFinished),
                  ),
                TextButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _dateFinished ?? DateTime.now(),
                      firstDate: DateTime(2020, 01, 01),
                      lastDate: DateTime(2030, 01, 01),
                    );
                    _dateFinished = date;
                    setState(() {});
                  },
                  child: const Text('Указать дату дедлайна'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState?.validate() == true) {
                        final toDo = ToDo(
                          id: id,
                          title: titleEditingController.text,
                          text: textEditingController.text,
                          dateCreated: DateTime.now(),
                          dateFinished: _dateFinished,
                        );
                        ToDoNotifier.of(context).add(toDo);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Сохранить"),
                    style: ToDoStyle.buttonStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
