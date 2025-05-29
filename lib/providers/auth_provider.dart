import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) => AuthNotifier());

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null);

  void login(String name, String email) {
    state = User(name: name, email: email);
  }

  void logout() {
    state = null;
  }
}