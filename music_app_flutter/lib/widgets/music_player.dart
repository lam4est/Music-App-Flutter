  import 'package:flutter/material.dart';
  import 'package:music_app_flutter/widgets/SongProvider.dart';
  import 'package:provider/provider.dart';

  class MusicPlayerWidget extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      final currentSong = context.watch<SongProvider>().currentSong;

      if (currentSong == null) {
        return SizedBox.shrink(); // Don't display anything if no song is playing
      }

      return Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Album art
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                currentSong.image,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            // Song details and progress
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      currentSong.title,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentSong.artist,
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 4.0),
                    LinearProgressIndicator(
                      value: 0.5, // Example progress value
                      backgroundColor: Colors.white24,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    ),
                  ],
                ),
              ),
            ),
            // Playback controls
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.skip_previous, color: Colors.white),
                  onPressed: () {
                    // Previous song functionality
                  },
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: () {
                    // Play/pause functionality
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, color: Colors.white),
                  onPressed: () {
                    // Next song functionality
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
