import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/models/songs.dart';
import 'package:music_app_flutter/logic/mysql.dart';
import 'package:music_app_flutter/views/library.dart';
import 'package:music_app_flutter/widgets/SongProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final titleController = TextEditingController();
  List<Map<String, dynamic>> songs = [];
  bool isLoading = false;

  void searchSongs() async {
    setState(() {
      isLoading = true;
    });
    var db = Mysql();
    var results = await db.searchSongs(titleController.text);
    setState(() {
      songs = results;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16),
              const ListTile(
                title: Text(
                  "What do you want to listen to?",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.deepPurple.withOpacity(.2),
                ),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: "Type something",
                  ),
                  onFieldSubmitted: (value) {
                    searchSongs();
                  },
                ),
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          var song = songs[index];
                          return SearchResult(song: song, playlists: playlists);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  final Map<String, dynamic> song;
  final List<String> playlists;

  const SearchResult({Key? key, required this.song, required this.playlists})
      : super(key: key);

  Future<void> _addSongToPlaylist(String playlistName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> playlist = prefs.getStringList(playlistName) ?? [];

    // Convert song to JSON string and add to playlist
    var songJson = jsonEncode(song.map((key, value) {
      if (value is DateTime) {
        return MapEntry(key, value.toIso8601String());
      }
      return MapEntry(key, value);
    }));
    playlist.add(songJson);
    await prefs.setStringList(playlistName, playlist);
  }

  void _choosePlaylist(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Playlist'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (String playlistName in playlists)
                ListTile(
                  title: Text(playlistName),
                  onTap: () {
                    _addSongToPlaylist(playlistName);
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Image.asset(song['image'],
            width: 60, height: 60, fit: BoxFit.cover),
        title: Text(song['title']),
        subtitle: Text('${song['artist']}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                _choosePlaylist(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                final selectedSong = Song(
                  title: song['title'],
                  artist: song['artist'],
                  image: song['image'],
                  views: song['views'],
                );
                context.read<SongProvider>().playSong(selectedSong);
              },
            ),
          ],
        ),
        onTap: () {
          print('Tapped on ${song['title']}');
        },
      ),
    );
  }
}
