import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/mysql.dart'; // Đảm bảo import đúng tệp tin
import 'package:music_app_flutter/views/library.dart';

import 'package:music_app_flutter/views/song_running_view.dart';
import 'package:music_app_flutter/widgets/PlaylistUtils.dart';
import 'package:music_app_flutter/widgets/album_cards.dart';

class AlbumView extends StatefulWidget {
  final ImageProvider image;
  final String title;
  final String artist;
  final Map<String, dynamic> song;
  final List<String> playlists;

  const AlbumView({
    Key? key,
    required this.image,
    required this.title,
    required this.artist,
    required this.song,
    required this.playlists,
  }) : super(key: key);

  @override
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  final Mysql db = Mysql();
  late ScrollController scrollController;
  double imageSize = 0;
  double initialSize = 240;
  double containerHeight = 500;
  double containerinitalHeight = 500;
  double imageOpacity = 1;
  bool showTopBar = false;
  List<Map<String, dynamic>> randomSongs = [];
  Map<String, dynamic> song = {};

  @override
  void initState() {
    imageSize = initialSize;
    song = widget.song;
    scrollController = ScrollController()
      ..addListener(() {
        imageSize = initialSize - scrollController.offset;
        if (imageSize < 0) {
          imageSize = 0;
        }
        containerHeight = containerinitalHeight - scrollController.offset;
        if (containerHeight < 0) {
          containerHeight = 0;
        }
        imageOpacity = imageSize / initialSize;
        if (scrollController.offset > 224) {
          showTopBar = true;
        } else {
          showTopBar = false;
        }
        print(scrollController.offset);
        setState(() {});
      });
    _fetchRandomSongs();
    super.initState();
  }

  Future<void> _fetchRandomSongs() async {
    final List<Map<String, dynamic>> songs = await db.getSongs('suggested');
    setState(() {
      randomSongs = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardSize = MediaQuery.of(context).size.width / 2 - 32;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: containerHeight,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Color.fromRGBO(0, 173, 181, 1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: imageOpacity.clamp(0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromRGBO(34, 40, 49, 1.0).withOpacity(.5),
                          offset: Offset(0, 20),
                          blurRadius: 32,
                          spreadRadius: 16,
                        )
                      ],
                    ),
                    child: Image(
                      image: widget.image,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(34, 40, 49, 1.0).withOpacity(0),
                          Color.fromRGBO(34, 40, 49, 1.0).withOpacity(0),
                          Color.fromRGBO(34, 40, 49, 1.0).withOpacity(1),
                          Color.fromRGBO(34, 40, 49, 1.0).withOpacity(1),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Column(
                        children: [
                          SizedBox(height: initialSize + 32),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(widget.title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Center(
                                  child: Text(widget.artist,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey)),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "${song['views']} views",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.favorite),
                                          onPressed: () {
                                            PlaylistUtils.choosePlaylist(
                                                context, song, playlists);
                                          },
                                          iconSize: 30,
                                        ),
                                        SizedBox(width: 16),
                                        IconButton(
                                          icon: Icon(Icons.more_horiz),
                                          onPressed: () {},
                                          iconSize: 30,
                                        ),
                                        Spacer(), // Widget Spacer để điền vào tất cả không gian trống còn lại
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(
                                                238, 238, 238, 1.0),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SongRunView(
                                                    title: widget.title,
                                                    artist: widget.artist,
                                                    image: widget.image,
                                                    songUrl:
                                                        widget.song['file'],
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.play_arrow,
                                              color: Color.fromRGBO(
                                                  0, 173, 181, 1.0),
                                              size: 45,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Color.fromRGBO(34, 40, 49, 1.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${song['description']}",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "You might also like",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 16),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // mainAxisSpacing: 2,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: randomSongs.length,
                          itemBuilder: (context, index) {
                            final song = randomSongs[index];
                            return AlbumCard(
                              size: cardSize,
                              label: song['title'],
                              image: AssetImage(song['image']),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image: AssetImage(song['image']),
                                      title: song['title'],
                                      artist: song['artist'],
                                      song: song,
                                      playlists: widget
                                          .playlists, // Đảm bảo playlists được chuyển đúng cách
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // App bar
          Positioned(
            child: Container(
              color: showTopBar
                  ? Color.fromRGBO(0, 173, 181, 1.0)
                  : Colors.transparent,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: SafeArea(
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            size: 38,
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 250),
                        opacity: showTopBar ? 1 : 0,
                        child: Text(
                          song['title'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
