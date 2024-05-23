class UserProfile {
  final String profileImageUrl;
  final String userName;
  final int followers;
  final int following;
  final List<String> playlists;

  UserProfile({
    required this.profileImageUrl,
    required this.userName,
    required this.followers,
    required this.following,
    required this.playlists,
  });
}
