import 'package:flutter/material.dart';

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
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class AlbumCard extends StatelessWidget {
  final ImageProvider image;
  final String label;

  const AlbumCard({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: image,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10),
        Text(label),
      ],
    );
  }
}
