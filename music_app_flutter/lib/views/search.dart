import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/models/songs.dart';
import 'package:music_app_flutter/logic/mysql.dart';
import 'package:music_app_flutter/views/library.dart';
import 'package:music_app_flutter/widgets/PlaylistUtils.dart';
import 'package:music_app_flutter/widgets/SongProvider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final titleController = TextEditingController();
  List<Map<String, dynamic>> songs = [];
  bool isLoading = false; // Fixed variable name

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onStatus: (status) {
        print('onStatus: $status');
        if (status == 'done') {
          _stopListening();
        }
      },
      onError: (error) {
        print('onError: $error');
        setState(() {
          _speechEnabled = false;
        });
      },
    );
    if (!_speechEnabled) {
      print('Speech recognition not enabled');
    }
    setState(() {});
  }

  void _startListening() async {
    if (_speechEnabled) {
      print('Starting to listen...');
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: Duration(seconds: 10), // Increase timeout duration
        pauseFor: Duration(seconds: 5), // Adjust as necessary
        localeId: 'vi_VN', // Set locale to Vietnamese
        onSoundLevelChange: (level) {
          print('Sound level: $level');
          if (level < 1) {
            print('Speak louder, please.');
          }
        },
      );
      setState(() {});
    } else {
      print('Speech recognition not enabled');
    }
  }

  void _stopListening() async {
    print('Stopping listening...');
    await _speechToText.stop();
    setState(() {});
    searchSongs();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      titleController.text = _lastWords;
    });
    print('Recognized words: $_lastWords');
  }

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
              SizedBox(height: 30),
              const ListTile(
                title: Text(
                  "What do you want to listen to?",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 173, 181, 1.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromRGBO(57, 62, 70, 1.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                          hintText: _speechToText.isListening
                              ? 'Listening...'
                              : _speechEnabled
                                  ? 'Type something'
                                  : 'Speech not available',
                        ),
                        onFieldSubmitted: (value) {
                          searchSongs();
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(_speechToText.isNotListening
                          ? Icons.mic_off
                          : Icons.mic),
                      color: Colors.white,
                      onPressed: _speechToText.isNotListening
                          ? _startListening
                          : _stopListening,
                    ),
                  ],
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(57, 62, 70, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: song['image'] != null
            ? Image.asset(song['image'],
                width: 60, height: 60, fit: BoxFit.cover)
            : Icon(Icons.music_note),
        title: Text(song['title'],
            style: TextStyle(color: Color.fromRGBO(238, 238, 238, 1.0))),
        subtitle: Text(song['artist'],
            style: TextStyle(color: Color.fromRGBO(238, 238, 238, 1.0))),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.favorite,
                  color: Color.fromRGBO(238, 238, 238, 1.0)),
              onPressed: () {
                PlaylistUtils.choosePlaylist(context, song, playlists);
              },
            ),
            IconButton(
              icon: Icon(Icons.play_arrow,
                  color: Color.fromRGBO(238, 238, 238, 1.0)),
              onPressed: () {
                final selectedSong = Song(
                  title: song['title'],
                  artist: song['artist'],
                  image: song['image'],
                  views: song['views'],
                  songUrl: song['file'],
                  songID: song['id'],
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
