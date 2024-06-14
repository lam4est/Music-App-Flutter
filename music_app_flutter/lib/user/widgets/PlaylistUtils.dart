// playlist_utils.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/models/songs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaylistUtils {
  static Future<void> addSongToPlaylist(
      String playlistName, Map<String, dynamic> song) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> playlist = prefs.getStringList(playlistName) ?? [];

    var songJson = jsonEncode(song.map((key, value) {
      if (value is DateTime) {
        return MapEntry(key, value.toIso8601String());
      }
      return MapEntry(key, value);
    }));
    playlist.add(songJson);
    await prefs.setStringList(playlistName, playlist);
  }

  static Map<String, dynamic> decodeSongJson(String songJson) {
    Map<String, dynamic> decoded = jsonDecode(songJson);
    // If there are DateTime objects, convert them back to DateTime
    decoded.forEach((key, value) {
      if (value is String) {
        try {
          DateTime dateTime = DateTime.parse(value);
          decoded[key] = dateTime;
        } catch (e) {
          // Not a DateTime string, do nothing
        }
      }
    });
    return decoded;
  }

  static void choosePlaylist(
      BuildContext context, Map<String, dynamic> song, List<String> playlists) {
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
                    // Kiểm tra và xử lý khi songID có thể là null
                    int? songID = song['id'];
                    String title = song['title'] ?? '';
                    String artist = song['artist'] ?? '';
                    String image = song['image'] ?? '';
                    int views = song['views'] ?? 0;
                    String songUrl = song['audioUrl'] ?? '';

                    // Kiểm tra nếu songID là null thì không thực hiện tiếp
                    if (songID == null) {
                      // Xử lý khi không có songID
                      print('Error: songID is null');
                      return;
                    }

                    Song songObject = Song(
                      songID: songID,
                      title: title,
                      artist: artist,
                      image: image,
                      views: views,
                      songUrl: songUrl,
                    );
                    addSongToPlaylist(playlistName, songObject.toJson());
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
