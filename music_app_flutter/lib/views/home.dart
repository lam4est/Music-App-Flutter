import 'package:flutter/material.dart';
import 'package:music_app_flutter/views/album_view.dart';
import 'package:music_app_flutter/widgets/album_cards.dart';
import 'package:music_app_flutter/widgets/row_song_card.dart';
import 'package:music_app_flutter/widgets/song_card.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .6,
            decoration: BoxDecoration(color: Color.fromRGBO(0, 173, 181, 1.0)),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 173, 181, 1.0).withOpacity(.0),
                    Color.fromRGBO(0, 173, 181, 1.0).withOpacity(.8),
                    Color.fromRGBO(34, 40, 49, 1.0).withOpacity(1),
                    Color.fromRGBO(34, 40, 49, 1.0).withOpacity(1),
                    Color.fromRGBO(34, 40, 49, 1.0).withOpacity(1),
                  ],
                ),
              ),
              child: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "What's a music !!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.history),
                            SizedBox(width: 10),
                            Icon(Icons.settings),
                            SizedBox(width: 16),
                          ],
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        AlbumCard(
                          image: AssetImage("assets/LoiChoi.jpg"),
                          label: 'Loi Choi',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlbumView(
                                  image: AssetImage(
                                      "assets/WeDontTalkAnymore.jpg"),
                                  song: {},
                                  playlists: [],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 16),
                        AlbumCard(
                          image: AssetImage("assets/99%.jpg"),
                          label: '99%',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlbumView(
                                  image: AssetImage("assets/Photograph.jpg"),
                                  song: {},
                                  playlists: [],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 16),
                        AlbumCard(
                          image: AssetImage("assets/DanhDoi.jpg"),
                          label: 'Đánh đổi',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlbumView(
                                  image: AssetImage("assets/Photograph.jpg"),
                                  song: {},
                                  playlists: [],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 16),
                        AlbumCard(
                          image: AssetImage(
                              "assets/vaicaunoicokhiennguoithaydoi.jpg"),
                          label: 'vaicaunoicokhiennguoithaydoi',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlbumView(
                                  image: AssetImage("assets/Photograph.jpg"),
                                  song: {},
                                  playlists: [],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 16),
                        AlbumCard(
                          image: AssetImage("assets/ThePlayah.jpg"),
                          label: 'The Playah',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlbumView(
                                  image: AssetImage("assets/Photograph.jpg"),
                                  song: {},
                                  playlists: [],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Good Evening",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            RowAlbumCard(
                              label: "Nếu ngày ấy",
                              image: AssetImage("assets/NeuNgayAy.jpg"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            RowAlbumCard(
                              label: "Tại vì sao",
                              image: AssetImage("assets/TaiViSao.jpg"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            RowAlbumCard(
                              label: "Đưa em về nhà",
                              image: AssetImage("assets/DuaEmVeNha.jpg"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            RowAlbumCard(
                              label: "Chìm sâu",
                              image: AssetImage("assets/ChimSau.jpg"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            RowAlbumCard(
                              label: "Dont Let Me Down",
                              image: AssetImage("assets/DontLetMeDown.jpg"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            RowAlbumCard(
                              label: "Đông kiếm em",
                              image: AssetImage("assets/DongKiemEm.jpg"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Based on your recent listening",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            SongCard(
                              image: AssetImage("assets/WeDontTalkAnymore.png"),
                              label: 'We Dont Talk Anymore',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      playlists: [],
                                      song: {},
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SongCard(
                              image: AssetImage("assets/Attention.png"),
                              label: 'Attention',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SongCard(
                              image: AssetImage("assets/PhiaSauMotCoGai.png"),
                              label: 'Phía sau một cô gái',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SongCard(
                              image: AssetImage("assets/MatTroiCuaEm.jpg"),
                              label: 'Mặt Trời Của Em',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SongCard(
                              image: AssetImage("assets/TinhYeuChamTre.jpg"),
                              label: 'Tình Yêu Chậm Trễ',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SongCard(
                              image: AssetImage("assets/Perfect.jpg"),
                              label: 'Perfect',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Recomment radio",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            SongCard(
                              image: AssetImage("assets/WeDontTalkAnymore.png"),
                              label: 'Phia sau mot co gai',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SongCard(
                              image: AssetImage("assets/Attention.png"),
                              label: 'Phia sau mot co gai',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SongCard(
                              image: AssetImage("assets/PhiaSauMotCoGai.png"),
                              label: 'Phia sau mot co gai',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SongCard(
                              image: AssetImage("assets/MatTroiCuaEm.jpg"),
                              label: 'Phia sau mot co gai',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SongCard(
                              image: AssetImage(
                                  "assets/SomethingJustLikeThis.png"),
                              label: 'Phia sau mot co gai',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SongCard(
                              image: AssetImage(
                                  "assets/YeuAnhDiMeAnhBanBanhMi.jpg"),
                              label: 'Phia sau mot co gai',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
                                      song: {},
                                      playlists: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
