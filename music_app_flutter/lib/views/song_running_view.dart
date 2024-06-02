import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class SongRunView extends StatefulWidget {
  final String title;
  final String artist;
  final ImageProvider image;
  final String songUrl;

  const SongRunView({
    Key? key,
    required this.title,
    required this.artist,
    required this.image,
    required this.songUrl,
  }) : super(key: key);

  @override
  State<SongRunView> createState() => _SongRunViewState();
}

Map<String, dynamic> song = {};

class _SongRunViewState extends State<SongRunView> {
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
      await audioPlayer.resume();
    }
  }

  void _previousSong() {
    // Implement your logic to play the previous song
  }

  void _nextSong() {
    // Implement your logic to play the next song
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
