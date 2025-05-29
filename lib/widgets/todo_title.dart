import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import '../screen/todo_details_screen.dart';
// import 'todo_details_screen.dart';
import 'package:intl/intl.dart';

class TodoTile extends ConsumerWidget {
  final Todo todo;

  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOverdue = todo.dueDate != null && todo.dueDate!.isBefore(DateTime.now()) && !todo.isCompleted;

    return Dismissible(
      key: Key(todo.id),
      onDismissed: (direction) => ref.read(todoProvider.notifier).deleteTodo(todo.id),
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
      ),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) => ref.read(todoProvider.notifier).toggleTodo(todo.id),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: isOverdue ? Colors.red : null,
          ),
        ),
        subtitle: todo.dueDate != null
            ? Text(
          'Due: ${DateFormat.yMMMd().format(todo.dueDate!)} ${isOverdue ? '(Overdue)' : ''}',
          style: TextStyle(color: isOverdue ? Colors.red : null),
        )
            : null,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoDetailsScreen(todo: todo),
          ),
        ),
      ),
    );
  }
}