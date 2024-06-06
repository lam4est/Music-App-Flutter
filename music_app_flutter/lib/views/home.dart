import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/mysql.dart';
import 'package:music_app_flutter/views/album_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Mysql db = Mysql();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 173, 181, 1.0),
        title: const Text('JoySong', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings,
                color: Color.fromRGBO(238, 238, 238, 1.0)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            _buildSectionTitle('Được Đề Xuất Cho Bạn'),
            _buildHorizontalListView('suggested'),
            SizedBox(
              height: 10,
            ),
            _buildSectionTitle('Danh Sách Phát Mới'),
            _buildHorizontalListView('new_playlists'),
            SizedBox(
              height: 10,
            ),
            _buildSectionTitle('Album Nổi Bật'),
            _buildHorizontalListView('featured_albums'),
            SizedBox(
              height: 10,
            ),
            _buildSectionTitle('Bài Hát Yêu Thích'),
            _buildHorizontalListView('favorite_songs'),
            SizedBox(
              height: 10,
            ),
            _buildSectionTitle('Top Bảng Xếp Hạng'),
            _buildHorizontalListView('top_charts'),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: const DecorationImage(
                image: AssetImage('assets/DungLamTraiTimAnhDau_Banner.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHorizontalListView(String type) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: db.getSongs(type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        var items = snapshot.data!;

        return SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return _buildListItem(item);
            },
          ),
        );
      },
    );
  }

  Widget _buildListItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumView(
              image: AssetImage(item['image']),
              title: item['title'] ?? 'Unknown',
              artist: item['artist'] ?? 'Unknown Artist',
              song: item,
              playlists: [],
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: AssetImage(item['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 40, // Set a fixed height for the title
              child: Text(
                item['title'] ?? 'Unknown',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeView(),
  ));
}
