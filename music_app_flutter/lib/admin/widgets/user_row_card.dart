import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/models/users.dart';

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
            color: user.isActive
                ? Color.fromRGBO(0, 173, 181, 1.0)
                : Color.fromRGBO(238, 238, 238, 1.0),
          ),
          onPressed: onActivate,
        ),
      ),
    );
  }
}
