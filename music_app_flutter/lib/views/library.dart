import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LibraryView extends StatefulWidget {
  @override
  _LibraryViewState createState() => _LibraryViewState();
}

List<String> playlists = [];

class _LibraryViewState extends State<LibraryView> {
  String newPlaylistName = '';

  @override
  void initState() {
    super.initState();
    _loadPlaylists();
  }

  Future<void> _loadPlaylists() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      playlists = prefs.getStringList('playlists') ?? [];
    });
  }

  Future<void> _savePlaylists() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('playlists', playlists);
  }

  Future<void> _deletePlaylist(String playlistName) async {
    setState(() {
      playlists.remove(playlistName);
    });
    await _savePlaylists();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Playlist "$playlistName" has been deleted')),
    );
  }

  void _confirmDeletePlaylist(BuildContext context, String playlistName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Playlist'),
          content: Text(
              'Are you sure you want to delete the playlist "$playlistName"?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                _deletePlaylist(playlistName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _playPlaylist(String playlistName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistSongsView(
          playlistName: playlistName,
          autoPlay: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(top: 60.0, right: 20.0, left: 20.0),
            child: Text(
              "What is your favorite playlist?",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 173, 181, 1.0),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                _buildSectionTitle('Playlists'),
                for (String playlistName in playlists)
                  _buildPlaylistItem(playlistName),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 173, 181, 1.0),
        foregroundColor: Color.fromRGBO(238, 238, 238, 1.0),
        onPressed: () {
          _addPlaylist(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPlaylistItem(String playlistName) {
    return Card(
      color: Color.fromRGBO(57, 62, 70, 1.0),
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(Icons.queue_music),
        title: Text(playlistName),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                _playPlaylist(playlistName);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _confirmDeletePlaylist(context, playlistName);
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PlaylistSongsView(playlistName: playlistName),
            ),
          );
        },
      ),
    );
  }

  void _addPlaylist(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Playlist'),
          content: TextField(
            onChanged: (value) {
              newPlaylistName = value;
            },
            decoration: InputDecoration(hintText: "Enter playlist name"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                _createPlaylist(newPlaylistName);
                Navigator.of(context).pop();
                _savePlaylists();
              },
            ),
          ],
        );
      },
    );
  }

  void _createPlaylist(String name) {
    if (name.isNotEmpty) {
      playlists.add(name);
      setState(() {});
    }
  }
}

class PlaylistSongsView extends StatefulWidget {
  final String playlistName;
  final bool autoPlay;

  PlaylistSongsView(
      {Key? key, required this.playlistName, this.autoPlay = false})
      : super(key: key);

  @override
  _PlaylistSongsViewState createState() => _PlaylistSongsViewState();
}

class _PlaylistSongsViewState extends State<PlaylistSongsView> {
  int currentIndex = 0;
  List<Map<String, dynamic>> songs = [];

  Future<List<Map<String, dynamic>>> _loadPlaylistSongs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> playlist = prefs.getStringList(widget.playlistName) ?? [];
    return playlist.map((song) {
      Map<String, dynamic> songMap;
      try {
        songMap = jsonDecode(song) as Map<String, dynamic>;
        songMap['views'] = songMap['views'] ?? 0;
      } catch (e) {
        songMap = {};
      }
      return songMap;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadPlaylistSongs().then((loadedSongs) {
      setState(() {
        songs = loadedSongs;
        if (widget.autoPlay && songs.isNotEmpty) {
          _showMusicPlayer(songs[currentIndex]);
        }
      });
    });
  }

  void _showMusicPlayer(Map<String, dynamic> song) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return MusicPlayer(
          song: song,
          onNext: _nextSong,
          onPrevious: _previousSong,
        );
      },
    );
  }

  void _nextSong() {
    setState(() {
      if (currentIndex < songs.length - 1) {
        currentIndex++;
        _showMusicPlayer(songs[currentIndex]);
      }
    });
  }

  void _previousSong() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        _showMusicPlayer(songs[currentIndex]);
      }
    });
  }

  void _deleteSong(int index) async {
    setState(() {
      songs.removeAt(index);
    });
    await _savePlaylistSongs();
  }

  Future<void> _savePlaylistSongs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> playlist = songs.map((song) => jsonEncode(song)).toList();
    await prefs.setStringList(widget.playlistName, playlist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.playlistName,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(0, 173, 181, 1.0),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: songs.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  var song = songs[index];
                  return Card(
                    color: Color.fromRGBO(57, 62, 70, 1.0),
                    elevation: 4.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    child: ListTile(
                      leading: song['image'] != null
                          ? Image.asset(
                              song['image'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.music_note),
                      title: Text(song['title'] ?? ''),
                      subtitle: Text(song['artist'] ?? ''),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteSong(index);
                        },
                      ),
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                        _showMusicPlayer(song);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class MusicPlayer extends StatelessWidget {
  final Map<String, dynamic> song;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  MusicPlayer({
    required this.song,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        children: [
          song['image'] != null
              ? Image.asset(
                  song['image'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: double.infinity,
                  height: 200,
                  color: Color.fromRGBO(238, 238, 238, 1.0),
                  child: Icon(
                    Icons.music_note,
                    color: Color.fromRGBO(238, 238, 238, 1.0),
                    size: 100,
                  ),
                ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(34, 40, 49, 1.0).withOpacity(0.3),
                    Color.fromRGBO(34, 40, 49, 1.0).withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: song['image'] != null
                      ? Image.asset(
                          song['image'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          color: Color.fromRGBO(238, 238, 238, 1.0),
                          child: Icon(
                            Icons.music_note,
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                          ),
                        ),
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song['title'] ?? '',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(238, 238, 238, 1.0)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      song['artist'] ?? '',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromRGBO(238, 238, 238, 1.0)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.skip_previous,
                            color: Color.fromRGBO(238, 238, 238, 1.0)),
                        onPressed: onPrevious,
                      ),
                      IconButton(
                        icon: Icon(Icons.play_arrow,
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                            size: 32),
                        onPressed: () {
                          // Play/pause logic
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next,
                            color: Color.fromRGBO(238, 238, 238, 1.0)),
                        onPressed: onNext,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: IconButton(
              icon:
                  Icon(Icons.close, color: Color.fromRGBO(238, 238, 238, 1.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
