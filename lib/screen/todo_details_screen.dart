import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';

import'../providers/todo_provider.dart';
import 'package:intl/intl.dart';
import 'add_todo_screen.dart';

class TodoDetailsScreen extends ConsumerWidget {
  final Todo todo;

  const TodoDetailsScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOverdue = todo.dueDate != null && todo.dueDate!.isBefore(DateTime.now()) && !todo.isCompleted;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTodoScreen(), // Reuse AddTodoScreen for editing
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            const SizedBox(height: 10),
            Text('Category: ${todo.category}'),
            Text('Created: ${DateFormat.yMMMd().format(todo.createdAt)}'),
            if (todo.dueDate != null)
              Text(
                'Due: ${DateFormat.yMMMd().format(todo.dueDate!)} ${isOverdue ? '(Overdue)' : ''}',
                style: TextStyle(color: isOverdue ? Colors.red : null),
              ),
            const SizedBox(height: 10),
            if (todo.description != null)
              Text(
                todo.description!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
          ],
        ),
      ),
    );
  }
}