import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/mysql.dart';
import 'package:palette_generator/palette_generator.dart';

class SongRunView extends StatefulWidget {
  final String title;
  final String artist;
  final ImageProvider image;
  final String songUrl;
  final int songID;

  const SongRunView({
    Key? key,
    required this.title,
    required this.artist,
    required this.image,
    required this.songUrl,
    required this.songID,
  }) : super(key: key);

  @override
  State<SongRunView> createState() => _SongRunViewState();
}

Map<String, dynamic> song = {};

class _SongRunViewState extends State<SongRunView> {
  final Mysql db = Mysql();
  Color backgroundColor = Colors.black;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  late StreamSubscription<PlayerState> _playerStateSubscription;
  late StreamSubscription<Duration> _durationSubscription;
  late StreamSubscription<Duration> _positionSubscription;

  @override
  void initState() {
    super.initState();
    _updatePalette();
    _setupAudioPlayer();
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _durationSubscription.cancel();
    _positionSubscription.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _updatePalette() async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(widget.image);
    setState(() {
      backgroundColor = paletteGenerator.dominantColor?.color ?? Colors.black;
    });
  }

  void _setupAudioPlayer() {
    _playerStateSubscription = audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    _durationSubscription = audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    _positionSubscription = audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  void _playPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.setSourceAsset(widget.songUrl);
      print(widget.songID);
      await audioPlayer.resume();
    }
  }

  void _previousSong() async {
    if (widget.songID > 1) {
      var previousSongID = widget.songID - 1;
      var previousSong = await db.getSongById(previousSongID);

      if (previousSong != null) {
        var newImage =
            AssetImage(previousSong['image']); // Assuming the image is a URL

        // Stop the current song
        await audioPlayer.stop();

        // Navigate to the new SongRunView with the updated song details
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SongRunView(
              title: previousSong['title'],
              artist: previousSong['artist'],
              image: newImage,
              songUrl: previousSong['audioUrl'],
              songID: previousSongID,
            ),
          ),
        );

        String songUrl = previousSong['audioUrl'];

        // Check if the URL is valid and accessible
        if (songUrl.startsWith('http') || songUrl.startsWith('https')) {
          await audioPlayer.setSourceUrl(songUrl);
        } else {
          await audioPlayer.setSourceAsset(songUrl);
        }

        await audioPlayer.resume();
      } else {
        print('Previous song not found.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Previous song not found.')),
        );
      }
    } else {
      print('This is the first song.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('This is the first song.')),
      );
    }
  }

  void _nextSong() async {
    var nextSongID = widget.songID + 1;
    var nextSong = await db.getSongById(nextSongID);

    if (nextSong != null) {
      var newImage =
          AssetImage(nextSong['image']); // Assuming the image is a URL

      // Stop the current song
      await audioPlayer.stop();

      // Navigate to the new SongRunView with the updated song details
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SongRunView(
            title: nextSong['title'],
            artist: nextSong['artist'],
            image: newImage,
            songUrl: nextSong['audioUrl'],
            songID: nextSongID,
          ),
        ),
      );

      // Play the next song
      String songUrl = nextSong['audioUrl'];

      // Check if the URL is valid and accessible
      if (songUrl.startsWith('http') || songUrl.startsWith('https')) {
        await audioPlayer.setSourceUrl(songUrl);
      } else {
        // Handle local assets if necessary
        await audioPlayer.setSourceAsset(songUrl);
      }

      await audioPlayer.resume();
    } else {
      print('Next song not found.');
      // Optionally show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Next song not found.')),
      );
    }
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Container(
            color: backgroundColor,
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Spacer(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: widget.image,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.artist,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.skip_previous),
                            iconSize: 50,
                            onPressed: _previousSong,
                          ),
                          SizedBox(
                              width: 20), // Adjust the width value as needed
                          CircleAvatar(
                            radius: 35,
                            child: IconButton(
                              icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow),
                              iconSize: 50,
                              onPressed: _playPause,
                            ),
                          ),
                          SizedBox(
                              width: 20), // Adjust the width value as needed
                          IconButton(
                            icon: Icon(Icons.skip_next),
                            iconSize: 50,
                            onPressed: _nextSong,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Slider(
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          value: position.inSeconds.toDouble(),
                          onChanged: (value) async {
                            final newPosition =
                                Duration(seconds: value.toInt());
                            await audioPlayer.seek(newPosition);
                            if (!isPlaying) {
                              await audioPlayer.resume();
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 37),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(position),
                                style: TextStyle(color: Colors.white)),
                            Text(formatTime(duration - position),
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
