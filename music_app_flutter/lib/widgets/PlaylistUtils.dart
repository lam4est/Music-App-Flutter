// playlist_utils.dart
import 'dart:convert';
import 'package:flutter/material.dart';
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
                    addSongToPlaylist(playlistName, song);
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
