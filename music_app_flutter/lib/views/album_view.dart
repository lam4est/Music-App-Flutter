import 'package:flutter/material.dart';
import 'package:music_app_flutter/views/library.dart';
import 'package:music_app_flutter/widgets/PlaylistUtils.dart';
import 'package:music_app_flutter/widgets/album_cards.dart';

class AlbumView extends StatefulWidget {
  final ImageProvider image;
  final Map<String, dynamic> song;
  final List<String> playlists;

  const AlbumView(
      {Key? key,
      required this.image,
      required this.song,
      required this.playlists})
      : super(key: key);

  @override
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late ScrollController scrollController;
  double imageSize = 0;
  double initialSize = 240;
  double containerHeight = 500;
  double containerinitalHeight = 500;
  double imageOpacity = 1;
  bool showTopBar = false;

  @override
  void initState() {
    imageSize = initialSize;
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
    super.initState();
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
                                  child: Text("Đánh đổi - OBITO",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "1,888,132 likes",
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                                                context,
                                                widget.song,
                                                playlists);
                                          },
                                        ),
                                        SizedBox(width: 16),
                                        IconButton(
                                          icon: Icon(Icons.more_horiz),
                                          onPressed: () {
                                            // Thêm logic xử lý khi nút được nhấn
                                          },
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
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"),
                        SizedBox(height: 32),
                        Text(
                          "You might also like",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AlbumCard(
                                size: cardSize,
                                label: "Photograph",
                                image: AssetImage("assets/Photograph.jpg"),
                                onTap: () {},
                              ),
                              AlbumCard(
                                size: cardSize,
                                label: "Lạc Trôi",
                                image: AssetImage("assets/LacTroi.jpg"),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AlbumCard(
                                size: cardSize,
                                label: "Missing You",
                                image: AssetImage("assets/MissingYou.jpg"),
                                onTap: () {},
                              ),
                              AlbumCard(
                                size: cardSize,
                                label: "Shape of You",
                                image: AssetImage("assets/ShapeOfYou.jpg"),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AlbumCard(
                                size: cardSize,
                                label: "Sau Tất Cả",
                                image: AssetImage("assets/SauTatCa.jpg"),
                                onTap: () {},
                              ),
                              AlbumCard(
                                size: cardSize,
                                label: "Perfect",
                                image: AssetImage("assets/Perfect.jpg"),
                                onTap: () {},
                              ),
                            ],
                          ),
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
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              color: showTopBar
                  ? Color.fromRGBO(0, 173, 181, 1.0).withOpacity(1)
                  : Color.fromRGBO(0, 173, 181, 1.0).withOpacity(0),
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
                          "Music Library",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom:
                            130 - containerHeight.clamp(165.0, double.infinity),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(238, 238, 238, 1.0),
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                size: 38,
                                color: Color.fromRGBO(0, 173, 181, 1.0),
                              ),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(0, 173, 181, 1.0),
                              ),
                              child: Icon(
                                Icons.shuffle,
                                color: Color.fromRGBO(238, 238, 238, 1.0),
                                size: 14,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
