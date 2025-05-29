import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import 'package:intl/intl.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({super.key});

  @override
  ConsumerState<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends ConsumerState<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;
  String _category = 'General';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      ref.read(todoProvider.notifier).addTodo(Todo(
        title: _titleController.text,
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
        createdAt: DateTime.now(),
        dueDate: _dueDate,
        category: _category,
      ));
      Navigator.pop(context);
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider).where((cat) => cat != 'All').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Title is required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description (Optional)'),
                maxLines: 3,
              ),
              ListTile(
                title: Text(
                  _dueDate == null
                      ? 'Select Due Date'
                      : 'Due: ${DateFormat.yMMMd().format(_dueDate!)}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDueDate(context),
              ),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: ['General', 'School', 'Personal', 'Urgent', ...categories]
                    .toSet()
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTodo,
                child: const Text('Save Todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}