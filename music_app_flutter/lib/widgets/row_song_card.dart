import 'package:flutter/material.dart';
import 'package:music_app_flutter/views/album_view.dart';

class RowAlbumCard extends StatelessWidget {
  final AssetImage image;
  final String label;
  final Function onTap;

  const RowAlbumCard({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlbumView(
                image: image,
                song: {},
                playlists: [],
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(57, 62, 70, 1.0),
              borderRadius: BorderRadius.circular(8)),
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
      ),
    );
  }
}
