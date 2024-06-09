import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/models/songs.dart';

class SongProvider extends ChangeNotifier {
  Song? _currentSong;

  Song? get currentSong => _currentSong;

  void playSong(Song song) {
    _currentSong = song;
    notifyListeners();
  }
}
