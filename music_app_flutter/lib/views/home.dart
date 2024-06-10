import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/mysql.dart';
import 'package:music_app_flutter/views/album_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final Mysql db = Mysql();
  late AnimationController _controller;
  late Animation<double> _animation;

  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentIndex = 0;
  final List<String> _imagePaths = [
    'assets/DungLamTraiTimAnhDau_Banner.png',
    'assets/MotDoi_banner.jpg',
    'assets/X_banner.jpg',
    'assets/XuanDanGDenBenEm_banner.jpg',
    'assets/TungLa_banner.jpg'
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _stopTimer();
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _changeBanner();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _changeBanner() {
    _currentIndex = (_currentIndex + 1) % _imagePaths.length;
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

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
            _buildSectionTitle('Recommended Stations'),
            _buildHorizontalListView('suggested'),
            SizedBox(
              height: 8,
            ),
            _buildSectionTitle('New Playlist'),
            _buildHorizontalListView('new_playlists'),
            SizedBox(
              height: 8,
            ),
            _buildSectionTitle('Recently Played'),
            _buildHorizontalListView('featured_albums'),
            SizedBox(
              height: 8,
            ),
            _buildSectionTitle('Favourite Song'),
            _buildHorizontalListView('favorite_songs'),
            SizedBox(
              height: 8,
            ),
            _buildSectionTitle('Top Chart'),
            _buildHorizontalListView('top_charts'),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 200,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _imagePaths.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  image: AssetImage(_imagePaths[index]),
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          onPageChanged: (index) {
            _currentIndex = index;
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return FadeTransition(
      opacity: _animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
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
          height: 220,
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
    return FadeTransition(
      opacity: _animation,
      child: GestureDetector(
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
          width: 170,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  height: 170,
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
                      fontSize: 15),
                ),
              ),
            ],
          ),
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
