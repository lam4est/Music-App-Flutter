import 'package:flutter/material.dart';
import 'package:music_app_flutter/widgets/album_cards.dart';

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
            height: MediaQuery.of(context).size.height * .5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.1),
                  Colors.black.withOpacity(0),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                      ),
                      SizedBox(width: 16),
                      AlbumCard(
                        image: AssetImage("assets/99%.jpg"),
                        label: '99%',
                      ),
                      SizedBox(width: 16),
                      AlbumCard(
                        image: AssetImage("assets/DanhDoi.jpg"),
                        label: 'Đánh đổi',
                      ),
                      SizedBox(width: 16),
                      AlbumCard(
                        image: AssetImage(
                            "assets/vaicaunoicokhiennguoithaydoi.jpg"),
                        label: 'vaicaunoicokhiennguoithaydoi',
                      ),
                      SizedBox(width: 16),
                      AlbumCard(
                        image: AssetImage("assets/ThePlayah.jpg"),
                        label: 'The Playah',
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
                              image: AssetImage("assets/NeuNgayAy.jpg")),
                          SizedBox(
                            width: 16,
                          ),
                          RowAlbumCard(
                              label: "Tại vì sao",
                              image: AssetImage("assets/TaiViSao.jpg")),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          RowAlbumCard(
                              label: "Đưa em về nhà",
                              image: AssetImage("assets/DuaEmVeNha.jpg")),
                          SizedBox(
                            width: 16,
                          ),
                          RowAlbumCard(
                              label: "Chìm sâu",
                              image: AssetImage("assets/ChimSau.jpg")),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          RowAlbumCard(
                              label: "Dont Let Me Down",
                              image: AssetImage("assets/DontLetMeDown.jpg")),
                          SizedBox(
                            width: 16,
                          ),
                          RowAlbumCard(
                              label: "Đông kiếm em",
                              image: AssetImage("assets/DongKiemEm.jpg")),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class RowAlbumCard extends StatelessWidget {
  final AssetImage image;
  final String label;
  const RowAlbumCard({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Image(
              image: image,
              height: 48,
              width: 48,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 8),
            Text(label)
          ],
        ),
      ),
    );
  }
}
