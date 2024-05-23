import 'package:flutter/material.dart';
import 'package:music_app_flutter/views/album_view.dart';

class SongCard extends StatelessWidget {
  final AssetImage image;
  final String label;
  final Function onTap;

  const SongCard({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumView(
              image: image, song: {}, playlists: [],
            ),
          ),
        );
      },
      // width: 140,
      child: Column(
        children: [
          Image(
            image: image,
            width: 140,
            height: 140,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
