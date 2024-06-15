import 'package:flutter/material.dart';
import 'package:music_app_flutter/admin/views/home.dart';
import 'package:music_app_flutter/admin/views/song_management.dart';
import 'package:music_app_flutter/admin/views/user_management.dart';

class AdminTabbar extends StatefulWidget {
  const AdminTabbar({super.key});

  @override
  State<AdminTabbar> createState() => _AdminTabbarState();
}

class _AdminTabbarState extends State<AdminTabbar> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          renderView(0, HomeView()),
          renderView(1, UserManagementView()),
          renderView(2, SongManagementView()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: "User Manager",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Song Manager",
          ),
        ],
      ),
    );
  }

  Widget renderView(int tabIndex, Widget view) {
    return IgnorePointer(
      ignoring: _selectedTab != tabIndex,
      child: Opacity(
        opacity: _selectedTab == tabIndex ? 1 : 0,
        child: view,
      ),
    );
  }
}
