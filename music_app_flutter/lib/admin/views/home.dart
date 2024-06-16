import 'package:flutter/material.dart';
import 'package:music_app_flutter/admin/navigation/tabbar.dart';
import 'package:music_app_flutter/authentication/login.dart';
import 'package:music_app_flutter/logic/mysql.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final mysql = Mysql();
  List<Map<String, dynamic>> newSongs = [];
  List<Map<String, dynamic>> topSongs = [];

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    var newSongsData = await mysql.getSongsbyAdmin('new_playlists');
    setState(() {
      newSongs = newSongsData;
    });

    var topSongsData = await mysql.getSongsbyAdmin('top_charts');
    setState(() {
      topSongs = topSongsData;
    });
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Text('Log out'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 173, 181, 1.0)),
        ),
        backgroundColor: Color.fromRGBO(34, 40, 49, 1.0),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'Admin',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                'email@email.com',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/Erik_avt.jpg'),
              ),
              decoration:
                  BoxDecoration(color: Color.fromRGBO(0, 173, 181, 1.0)),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Manage Users'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => AdminTabbar(selectedIndex: 1)),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.music_note),
              title: Text('Manage Songs'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => AdminTabbar(selectedIndex: 2)),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.live_help_rounded),
              title: Text('Help'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: _logout,
            ),
            Divider(),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(34, 40, 49, 1.0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection('New Songs', newSongs),
            SizedBox(height: 10),
            _buildSection('Top Songs', topSongs),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> songs) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 173, 181, 1.0),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 245,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  var song = songs[index];
                  return SongCard(
                    title: song['title'],
                    artist: song['artist'],
                    image: song['image'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SongCard extends StatelessWidget {
  final String title;
  final String artist;
  final String image;

  const SongCard({
    required this.title,
    required this.artist,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 160,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                image,
                width: 160,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4.0),
            Text(artist),
          ],
        ),
      ),
    );
  }
}
