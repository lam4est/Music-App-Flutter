class Song {
  final int songID;
  final String title;
  final String artist;
  final String image;
  final int views;
  final String songUrl;
  final int active;

  Song({
    required this.songID,
    required this.title,
    required this.artist,
    required this.image,
    required this.views,
    required this.songUrl,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      'songID': songID,
      'title': title,
      'artist': artist,
      'image': image,
      'views': views,
      'songUrl': songUrl,
      'active': active,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      songID: map['songID'] ?? 0,
      title: map['title'] ?? '',
      artist: map['artist'] ?? '',
      image: map['image'] ?? '',
      views: map['views'] ?? 0,
      songUrl: map['songUrl'] ?? '',
      active: map['active'] ?? 0,
    );
  }
}
