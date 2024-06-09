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
  Future<bool> login(String username, String password) async {
    var conn = await getConnection();
    try {
      var results = await conn.query(
          'SELECT * FROM users WHERE username = ? AND password = ?',
          [username, password]);

      if (results.isNotEmpty) {
        print('Đăng nhập thành công!');
        return true;
      } else {
        print('Đăng nhập thất bại: Sai tên đăng nhập hoặc mật khẩu.');
        return false;
      }
    } catch (e) {
      print('Đăng nhập thất bại: $e');
      return false;
    } finally {
      await conn.close();
    }
  }

  // SIGNUP
  Future<bool> signup(String username, String password, String email) async {
    var conn = await getConnection();
    try {
      var result = await conn.query(
          'INSERT INTO users (username, password, email) VALUES (?, ?, ?)',
          [username, password, email]);

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
          query = 'SELECT * FROM songs ORDER BY RAND() LIMIT 10';
          break;
        case 'featured_albums':
          query = 'SELECT * FROM songs ORDER BY RAND() LIMIT 10';
          break;
        case 'favorite_songs':
          query = 'SELECT * FROM songs ORDER BY RAND() LIMIT 10';
          break;
        case 'top_charts':
          query = 'SELECT * FROM songs ORDER BY views desc LIMIT 10';
          break;
      }
      var results = await conn.query(query);
      return results.map((row) {
        var fields = row.fields;
        fields['audioUrl'] = fields['file'];
        return fields;
      }).toList();
    } catch (e) {
      print('Failed to get songs: $e');
      return [];
    } finally {
      await conn.close();
    }
  }

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
