import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import 'package:intl/intl.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) => TodoNotifier());

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void toggleTodo(String id) {
    state = state.map((todo) => todo.id == id
        ? todo.copyWith(isCompleted: !todo.isCompleted)
        : todo).toList();
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void updateTodo(Todo updatedTodo) {
    state = state.map((todo) => todo.id == updatedTodo.id ? updatedTodo : todo).toList();
  }
}

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final selectedCategory = ref.watch(selectedCategoryProvider);

  return todos.where((todo) {
    final matchesQuery = todo.title.toLowerCase().contains(query) ||
        (todo.description?.toLowerCase().contains(query) ?? false);
    final matchesCategory = selectedCategory == 'All' || todo.category == selectedCategory;
    return matchesQuery && matchesCategory;
  }).toList();
});

final categoriesProvider = Provider<List<String>>((ref) {
  final todos = ref.watch(todoProvider);
  final categories = todos.map((todo) => todo.category).toSet().toList();
  return ['All', ...categories];
});