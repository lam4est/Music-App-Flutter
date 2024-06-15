import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/models/songs.dart';

class SongRowCard extends StatelessWidget {
  final Song song;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleActive;

  const SongRowCard({
    required this.song,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                song.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    song.artist,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(238, 238, 238, 1.0),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(song.active == 0
                  ? Icons.check_circle
                  : Icons.check_circle_outline),
              color: song.active == 0
                  ? Color.fromRGBO(0, 173, 181, 1.0)
                  : Color.fromRGBO(238, 238, 238, 1.0),
              onPressed: onToggleActive,
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
