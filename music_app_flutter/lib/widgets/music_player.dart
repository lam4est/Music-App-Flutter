import 'package:flutter/material.dart';

class MusicPlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Album art
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/Photograph.jpg',
              height: 50.0,
              width: 50.0,
              fit: BoxFit.cover,
            ),
          ),
          // Song details and progress
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Song Title',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Artist Name',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 4.0),
                  LinearProgressIndicator(
                    value: 0.5, // Giá trị tiến trình của bài hát
                    backgroundColor: Colors.white24,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  ),
                ],
              ),
            ),
          ),
          // Playback controls
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.skip_previous, color: Colors.white),
                onPressed: () {
                  // Thêm chức năng quay lại bài trước
                },
              ),
              IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.white),
                onPressed: () {
                  // Thêm chức năng phát/dừng
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next, color: Colors.white),
                onPressed: () {
                  // Thêm chức năng chuyển bài tiếp theo
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
