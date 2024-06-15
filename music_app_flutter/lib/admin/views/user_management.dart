import 'package:flutter/material.dart';
import 'package:music_app_flutter/admin/widgets/user_row_card.dart';
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
    List<User> users = results.map((row) => User.fromMap(row)).toList();
    setState(() {
      _users = users;
    });
  }

  void _toggleUserActivation(User user) async {
    var db = Mysql();
    await db.updateUserActivation(
        user.id, !user.isActive); 
    setState(() {
      user.isActive = !user.isActive; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage your users',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 173, 181, 1.0),
          ),
        ),
        backgroundColor: Color.fromRGBO(57, 62, 70, 1.0),
      ),
      backgroundColor: Color.fromRGBO(57, 62, 70, 1.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (query) {
                _searchUsers(query);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
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
          ),
        ],
      ),
    );
  }
}
