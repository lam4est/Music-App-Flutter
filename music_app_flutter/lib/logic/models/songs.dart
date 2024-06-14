class Song {
  final int songID; 
  final String title;
  final String artist;
  final String image;
  final int views;
  final String songUrl;

  Song({
    required this.songID,
    required this.title,
    required this.artist,
    required this.image,
    required this.views,
    required this.songUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'songID': songID,
      'title': title,
      'artist': artist,
      'image': image,
      'views': views,
      'songUrl': songUrl,
    };
  }
}
