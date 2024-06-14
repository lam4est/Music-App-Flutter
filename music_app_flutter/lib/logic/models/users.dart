class User {
  final int id;
  final String username;
  final String email;
  bool isActive;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.isActive = false,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      isActive: map['active'] == 0, // 0 là hoạt động, 1 là không hoạt động
    );
  }
}
