import 'package:flutter/material.dart';

@immutable
class ToDo {
  final int id;
  final String title;
  final String? text;
  final DateTime dateCreated;
  final DateTime? dateFinished;
  final bool isDone;

  const ToDo({
    required this.id,
    required this.title,
    required this.text,
    required this.dateCreated,
    this.dateFinished,
    this.isDone = false,
  });

  @override
  bool operator ==(Object other) {
    return other is ToDo &&
        id == other.id &&
        title == other.title &&
        text == other.text &&
        dateCreated == other.dateCreated &&
        dateFinished == other.dateFinished &&
        isDone == other.isDone;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      text.hashCode ^
      dateFinished.hashCode ^
      dateCreated.hashCode ^
      isDone.hashCode;

  ToDo copyWith({
    String? title,
    String? text,
    DateTime? dateFinished,
    bool? isDone,
  }) {
    return ToDo(
      id: id,
      title: title ?? this.title,
      text: text ?? this.text,
      dateCreated: dateCreated,
      dateFinished: dateFinished ?? this.dateFinished,
      isDone: isDone ?? this.isDone,
    );
  }
}
