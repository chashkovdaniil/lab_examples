import 'package:flutter/material.dart';

import 'to_do_add_page.dart';
import 'to_do_app_bar.dart';
import 'to_do_edit_page.dart';
import 'to_do_inherited.dart';
import 'to_do_model.dart';

class ToDoList extends StatelessWidget {
  static const routeName = '/todo';

  const ToDoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = ToDoNotifier.depend(context).list;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ToDoAppBar(title: 'Список дел'),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          for (final todo in list) ToDoCard(toDo: todo),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ToDoAddPage()),
          );
        },
        backgroundColor: Colors.black87,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ToDoCard extends StatelessWidget {
  final ToDo toDo;

  const ToDoCard({
    Key? key,
    required this.toDo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFinished = toDo.dateFinished;
    final isExpired = dateFinished?.compareTo(DateTime.now()) == -1;

    String title = toDo.title;
    String text = toDo.text;

    if (title.length > 15) {
      toDo.title.substring(0, 15);
    }

    if (text.length > 70) {
      toDo.text.substring(0, 70);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ToDoEditPage(toDo: toDo);
            },
          ),
        );
      },
      child: Card(
        color: isExpired ? Colors.redAccent : Colors.white,
        margin: const EdgeInsets.only(bottom: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  decoration: toDo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(
                  decoration: toDo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              if (dateFinished != null) ...[
                const SizedBox(height: 10),
                Text(
                  'Дедлайн: '
                  '${dateFinished.day}.${dateFinished.month}.${dateFinished.year}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    decoration: toDo.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
