import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class SongRunView extends StatefulWidget {
  final String title;
  final String artist;
  final ImageProvider image;

  const SongRunView({
    Key? key,
    required this.title,
    required this.artist,
    required this.image,
  }) : super(key: key);

  @override
  State<SongRunView> createState() => _SongRunViewState();
}

class _SongRunViewState extends State<SongRunView> {
  Color backgroundColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(widget.image);
    setState(() {
      backgroundColor = paletteGenerator.dominantColor?.color ?? Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Container(
            color: backgroundColor,
          ),
          Container(
            color: Colors.black.withOpacity(0.3), // Lớp màu bán trong suốt
          ),
          SafeArea(
            child: Column(
              children: [
                // Nút quay lại
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Spacer(), // Đẩy nội dung chính xuống giữa màn hình
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Thêm hình ảnh bìa album
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: widget.image,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Thêm tiêu đề bài hát
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // màu chữ
                        ),
                      ),
                      SizedBox(height: 10),
                      // Thêm tên nghệ sĩ
                      Text(
                        widget.artist,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[300], // màu chữ
                        ),
                      ),
                      SizedBox(height: 20),
                      // Thêm nút play/pause
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                        iconSize: 64,
                        color: Colors.white, // màu biểu tượng
                        onPressed: () {
                          // Xử lý khi nút được nhấn
                        },
                      ),
                    ],
                  ),
                ),
                Spacer(), // Đẩy nội dung chính lên giữa màn hình
              ],
            ),
          ),
        ],
      ),
    );
  }
}
