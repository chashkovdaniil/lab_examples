import 'package:flutter/cupertino.dart';

import 'to_do_model.dart';

typedef _ToDoNotifier = ValueNotifier<List<ToDo>>;

class ToDoNotifier extends InheritedNotifier<_ToDoNotifier> {
  ToDoNotifier({
    super.key,
    required super.child,
  }) : super(notifier: ValueNotifier([]));

  List<ToDo> get list => notifier!.value;

  void add(ToDo toDo) => notifier!.value = _sort([...list, toDo]);

  void update(ToDo toDo) {
    final list = this.list.toList();
    final index = list.indexWhere((t) => t.id == toDo.id);

    list.replaceRange(index, index + 1, [toDo]);

    notifier!.value = _sort(list);
  }

  void remove(ToDo toDo) {
    final list = this.list.toList();
    list.removeWhere((t) => t.hashCode == toDo.hashCode);

    notifier!.value = _sort(list);
  }

  static ToDoNotifier? maybeOf(BuildContext context) {
    final widget = context.findAncestorWidgetOfExactType<ToDoNotifier>();
    return widget;
  }

  static ToDoNotifier of(BuildContext context) {
    final widget = maybeOf(context);
    assert(widget != null, 'ToDoNotifier not found in tree');

    return widget!;
  }

  static ToDoNotifier depend(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<ToDoNotifier>();
    assert(widget != null, 'ToDoNotifier not found in tree');
    return widget!;
  }

  List<ToDo> _sort(List<ToDo> initialList) {
    final list = initialList.toList();

    int compare(ToDo a, ToDo b) {
      if (a.isDone && !b.isDone) {
        return 1;
      } else if (!a.isDone && b.isDone) {
        return -1;
      }
      if (a.isDone && b.isDone) {
        return a.dateCreated.compareTo(b.dateCreated);
      }

      if (a.dateFinished != null || b.dateFinished != null) {
        if (a.dateFinished != null && b.dateFinished == null) {
          return -1;
        }

        if (a.dateFinished == null && b.dateFinished != null) {
          return 1;
        }

        if (a.dateFinished != null && b.dateFinished != null) {
          return a.dateFinished!.compareTo(b.dateFinished!);
        }
      }

      return a.dateCreated.compareTo(b.dateCreated);
    }

    list.sort(compare);
    return list;
  }
}
