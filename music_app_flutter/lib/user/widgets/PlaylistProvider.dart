import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  List<String> playlists = [];

  void setPlaylists(List<String> newPlaylists) {
    playlists = newPlaylists;
    notifyListeners();
  }
}