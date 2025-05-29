import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? dueDate;
  final String category;

  Todo({
    String? id,
    required this.title,
    this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.dueDate,
    this.category = 'General',
  }) : id = id ?? const Uuid().v4();

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    String? category,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
    );
  }
}