import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app_flutter/user/views/song_running_view.dart';
import 'package:music_app_flutter/user/widgets/SongProvider.dart';
import 'package:provider/provider.dart';

class MusicPlayerWidget extends StatefulWidget {
  @override
  _MusicPlayerWidgetState createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<MusicPlayerWidget> {
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
      final currentSong = context.read<SongProvider>().currentSong;
      if (currentSong != null) {
        await audioPlayer.setSourceAsset(currentSong.songUrl);
        await audioPlayer.resume();
      }
    }
  }

  void _openSongRunView(BuildContext context) {
    final currentSong = context.read<SongProvider>().currentSong;
    if (currentSong != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SongRunView(
            title: currentSong.title,
            artist: currentSong.artist,
            image: AssetImage(currentSong.image),
            songUrl: currentSong.songUrl,
            songID: currentSong.songID,
          ),
        ),
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
    final currentSong = context.watch<SongProvider>().currentSong;

    if (currentSong == null) {
      return SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        _openSongRunView(context);
      },
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Ảnh album
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                currentSong.image,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            // Chi tiết bài hát và tiến độ
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
                      value: duration.inSeconds > 0
                          ? position.inSeconds / duration.inSeconds
                          : 0.0,
                      backgroundColor: Colors.white24,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white),
              onPressed: _playPause,
              iconSize: 35,
            ),
          ],
        ),
      ),
    );
  }
}
