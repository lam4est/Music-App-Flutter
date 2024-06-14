import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/models/users.dart';
import 'package:music_app_flutter/logic/mysql.dart';

class UserManagementView extends StatefulWidget {
  const UserManagementView({super.key});

  @override
  State<UserManagementView> createState() => _UserManagementViewState();
}

class _UserManagementViewState extends State<UserManagementView> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _searchUsers('');
  }

  void _searchUsers(String keyword) async {
    var db = Mysql();
    var results = await db.searchUser(keyword);
    print('Users from DB: $results'); // Debug
    List<User> users = results.map((row) => User.fromMap(row)).toList();
    setState(() {
      _users = users;
      print('Updated _users: $_users'); // Debug
    });
  }

  void _toggleUserActivation(User user) async {
    var db = Mysql();
    await db.updateUserActivation(user.id, !user.isActive); // Đảo ngược giá trị bool
    setState(() {
      user.isActive = !user.isActive; // Cập nhật trạng thái trong UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Management"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                _searchUsers(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return UserRowCard(
                  user: user,
                  onActivate: () => _toggleUserActivation(user),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserRowCard extends StatelessWidget {
  final User user;
  final VoidCallback onActivate;

  const UserRowCard({
    required this.user,
    required this.onActivate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(user.username),
        subtitle: Text(user.email),
        trailing: IconButton(
          icon: Icon(
            user.isActive ? Icons.check_circle : Icons.check_circle_outline,
            color: user.isActive ? Colors.green : Colors.grey,
          ),
          onPressed: onActivate,
        ),
      ),
    );
  }
}