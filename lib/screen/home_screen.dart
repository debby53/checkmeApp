import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/todo_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/todo_tile.dart';
import '../widgets/todo_title.dart';
import 'add_todo_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final todos = ref.watch(filteredTodosProvider);
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Dashboard'),
        actions: [
          PopupMenuButton<ThemeMode>(
            onSelected: (mode) => ref.read(themeModeProvider.notifier).state = mode,
            itemBuilder: (context) => [
              const PopupMenuItem(value: ThemeMode.light, child: Text('Light Mode')),
              const PopupMenuItem(value: ThemeMode.dark, child: Text('Dark Mode')),
              const PopupMenuItem(value: ThemeMode.system, child: Text('System Default')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: user!.avatarUrl.isNotEmpty
                          ? NetworkImage(user.avatarUrl)
                          : const AssetImage('assets/default_avatar.png') as ImageProvider,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Welcome, ${user.name}!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/images/banner.png',
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Todos',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              items: categories
                  .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category),
              ))
                  .toList(),
              onChanged: (value) => ref.read(selectedCategoryProvider.notifier).state = value!,
            ),
          ),
          Expanded(
            child: todos.isEmpty
                ? const Center(child: Text('No todos yet!'))
                : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) => TodoTile(todo: todos[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTodoScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}