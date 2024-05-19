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
            decoration: BoxDecoration(color: Color(0xFf1C7A74)),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
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
                          "Recently Played",  
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Row(
                          children: [
                            Icon(Icons.history),
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
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
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
                              label: 'Phia sau mot co gai',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumView(
                                      image:
                                          AssetImage("assets/Photograph.jpg"),
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
