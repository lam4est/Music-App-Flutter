import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '10.0.2.2',
      user = 'root',
      // password = '',
      db = 'music_db';
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

  // Future<bool> search(String title) async {
  //   var conn = await getConnection();
  //   try {
  //     var results = await conn.query(
  //       'SELECT * FROM songs WHERE title LIKE ?',
  //       [title],
  //     );
  //   } catch (e) {
  //     print('Đăng ký thất bại: $e');
  //     return false;
  //   } finally {
  //     await conn.close();
  //   }
  // }
}

void main() async {
  var db = new Mysql();
  try {
    var conn = await db.getConnection();
    print('Kết nối thành công!');
    await conn.close(); // Đóng kết nối sau khi sử dụng xong
  } catch (e) {
    print('Kết nối thất bại: $e');
  }
}
