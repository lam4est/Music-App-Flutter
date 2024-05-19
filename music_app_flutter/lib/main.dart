import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app_flutter/authentication/login.dart';
import 'package:music_app_flutter/logic/mysql.dart';
import 'package:music_app_flutter/navigations/tabbar.dart';
import 'package:music_app_flutter/widgets/music_player.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MyAppLogin());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(35, 35, 35, 0),
        brightness: Brightness.dark,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(211, 203, 203, 0),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
          ),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
        ),
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Tabbar(), // Nội dung chính của ứng dụng
            ),
            Positioned(
              bottom: 56.0, // Chiều cao của BottomNavigationBar
              left: 0,
              right: 0,
              child: MusicPlayerWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppLogin extends StatelessWidget {
  const MyAppLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var db = new Mysql();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:music_app_flutter/authentication/login.dart';
// import 'package:music_app_flutter/logic/mysql.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     statusBarBrightness: Brightness.dark,
//     systemNavigationBarColor: Colors.transparent,
//     systemNavigationBarDividerColor: Colors.transparent,
//     systemNavigationBarIconBrightness: Brightness.dark,
//     statusBarIconBrightness: Brightness.dark,
//   ));
//   runApp(const MyApp());
// }

// class MyAppLogin extends StatelessWidget {
//   const MyAppLogin({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var db = new Mysql();

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
