import 'package:music_app_flutter/logic/models/songs.dart';
import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '10.0.2.2', user = 'root', db = 'music_db';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings =
        new ConnectionSettings(host: host, port: port, user: user, db: db);
    return await MySqlConnection.connect(settings);
  }

  // LOGIN
  Future<String?> login(String username, String password) async {
    var conn = await getConnection();
    try {
      var results = await conn.query(
        'SELECT role, active FROM users WHERE username = ? AND password = ?',
        [username, password],
      );

      if (results.isNotEmpty) {
        var row = results.first;
        int active = row['active'];
        if (active == 1) {
          print('Tài khoản đã bị vô hiệu hóa.');
          return null; 
        }

        String role = row['role'];
        print('Đăng nhập thành công với vai trò $role');
        return role;
      } else {
        print('Đăng nhập thất bại: Sai tên đăng nhập hoặc mật khẩu.');
        return null;
      }
    } catch (e) {
      print('Đăng nhập thất bại: $e');
      return null;
    } finally {
      await conn.close();
    }
  }

  // SIGNUP
  Future<bool> signup(String username, String password, String email) async {
    var conn = await getConnection();
    try {
      var result = await conn.query(
          'INSERT INTO users (username, password, email, active, role) VALUES (?,?,?,?,?)',
          [username, password, email, 0, 'user']);

      if (result.affectedRows! > 0) {
        print('Đăng ký thành công!');
        return true;
      } else {
        print('Đăng ký thất bại.');
        return false;
      }
    } catch (e) {
      print('Đăng ký thất bại: $e');
      return false;
    } finally {
      await conn.close();
    }
  }

  // GET SONGS FROM DATABASE
  Future<List<Map<String, dynamic>>> getSongs(String type) async {
    var conn = await getConnection();
    try {
      var query = '';
      switch (type) {
        case 'suggested':
          query = 'SELECT * FROM songs ORDER BY RAND() LIMIT 10';
          break;
        case 'new_playlists':
          query = 'SELECT * FROM songs ORDER BY date DESC LIMIT 10';
          break;
        case 'featured_albums':
          query = 'SELECT * FROM songs ORDER BY timestamp DESC LIMIT 10';
          break;
        case 'favorite_songs':
          query = 'SELECT * FROM songs ORDER BY RAND() LIMIT 10';
          break;
        case 'top_charts':
          query = 'SELECT * FROM songs ORDER BY views desc LIMIT 10';
          break;
        case 'all':
        default:
          query = 'SELECT * FROM songs';
      }
      var results = await conn.query(query);
      return results.map((row) {
        var fields = row.fields;
        fields['songID'] = fields['id'];
        fields['songUrl'] = fields['file'];
        return fields;
      }).toList();
    } catch (e) {
      print('Failed to get songs: $e');
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<void> addSong(Song song) async {
    var conn = await getConnection();
    try {
      await conn.query(
        'INSERT INTO songs (title, artist, image, views, file) VALUES (?, ?, ?, ?, ?)',
        [song.title, song.artist, song.image, song.views, song.songUrl],
      );
    } catch (e) {
      print('Failed to add song: $e');
    } finally {
      await conn.close();
    }
  }

  Future<void> editSong(Song song) async {
    var conn = await getConnection();
    try {
      await conn.query(
        'UPDATE songs SET title = ?, artist = ?, image = ?, views = ?, file = ? WHERE id = ?',
        [
          song.title,
          song.artist,
          song.image,
          song.views,
          song.songUrl,
          song.songID
        ],
      );
    } catch (e) {
      print('Failed to edit song: $e');
    } finally {
      await conn.close();
    }
  }

  Future<void> deleteSong(int id) async {
    var conn = await getConnection();
    try {
      await conn.query(
        'DELETE FROM songs WHERE id = ?',
        [id],
      );
    } catch (e) {
      print('Failed to delete song: $e');
    } finally {
      await conn.close();
    }
  }

  Future<void> toggleSongActive(int songID, int currentStatus) async {
    var conn = await getConnection();
    try {
      int newStatus = currentStatus == 0 ? 1 : 0;
      await conn.query(
        'UPDATE songs SET active = ? WHERE id = ?',
        [newStatus, songID],
      );
    } catch (e) {
      print('Failed to toggle song active status: $e');
    } finally {
      await conn.close();
    }
  }

  // GET USER
  Future<List<Map<String, dynamic>>> searchUser(String keyword) async {
    var conn = await getConnection();
    try {
      var results = await conn.query(
        'SELECT * FROM users WHERE username LIKE ? OR email LIKE ?',
        ['%$keyword%', '%$keyword%'],
      );
      var list = results.map((row) => row.fields).toList();
      print('Search results: $list'); // Debug
      return list;
    } catch (e) {
      print('Search failed: $e');
      return [];
    } finally {
      await conn.close();
    }
  }

  // GET SONG BY ID
  Future<Map<String, dynamic>?> getSongById(int id) async {
    var conn = await getConnection();
    try {
      var results = await conn.query('SELECT * FROM songs WHERE id = ?', [id]);
      if (results.isNotEmpty) {
        var fields = results.first.fields;
        fields['audioUrl'] = fields['file'];
        return fields;
      }
      return null;
    } catch (e) {
      print('Failed to get song by ID: $e');
      return null;
    } finally {
      await conn.close();
    }
  }

  // SEARCH SONG
  Future<List<Map<String, dynamic>>> searchSongs(String keyword) async {
    var conn = await getConnection();
    try {
      var results = await conn.query(
        'SELECT * FROM songs WHERE title LIKE ?',
        ['%$keyword%'],
      );
      return results.map((row) => row.fields).toList();
    } catch (e) {
      print('Search failed: $e');
      return [];
    } finally {
      await conn.close();
    }
  }

  // RESET PASSWORD
  Future<bool> resetPassword(String email, String newPassword) async {
    var conn = await getConnection();
    try {
      var result = await conn.query(
        'UPDATE users SET password = ? WHERE email = ?',
        [newPassword, email],
      );
      return result.affectedRows! > 0;
    } catch (e) {
      print('Failed to reset password: $e');
      return false;
    } finally {
      await conn.close();
    }
  }

  // ACTIVE USER
  Future<void> updateUserActivation(int userId, bool isActive) async {
    var conn = await getConnection();
    try {
      await conn.query(
        'UPDATE users SET active = ? WHERE id = ?',
        [isActive ? 0 : 1, userId], // 0 là hoạt động, 1 là không hoạt động
      );
      print('Update query executed'); // Debug
    } catch (e) {
      print('Update failed: $e');
    } finally {
      await conn.close();
    }
  }

  closeConnection() {}
}

void main() async {
  var db = new Mysql();
  try {
    var conn = await db.getConnection();
    print('Kết nối thành công!');
    await conn.close();
  } catch (e) {
    print('Kết nối thất bại: $e');
  }
}
