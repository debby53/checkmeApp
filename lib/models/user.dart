class User {
  final String name;
  final String email;
  final String avatarUrl;

  User({
    required this.name,
    required this.email,
    this.avatarUrl = 'https://api.dicebear.com/9.x/avataaars/png?seed=default',
  });
}