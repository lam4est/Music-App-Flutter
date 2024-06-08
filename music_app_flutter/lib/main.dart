import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app_flutter/authentication/login.dart';
import 'package:music_app_flutter/navigations/tabbar.dart';
import 'package:music_app_flutter/widgets/SongProvider.dart';
import 'package:music_app_flutter/widgets/music_player.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: Colors.transparent,
      // statusBarBrightness: Brightness.dark,
      // systemNavigationBarColor: Colors.transparent,
      // systemNavigationBarDividerColor: Colors.transparent,
      // systemNavigationBarIconBrightness: Brightness.dark,
      // statusBarIconBrightness: Brightness.dark,
      ));
  runApp(
    ChangeNotifierProvider(
      create: (_) => SongProvider(),
      child: MyAppLogin(),
    ),
  );
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
        scaffoldBackgroundColor: Color.fromRGBO(34, 40, 49, 1.0),
        brightness: Brightness.dark,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(0, 173, 181, 1.0),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
          ),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
        ),
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Tabbar(), // Main content of the app
            ),
            Positioned(
              bottom: 56.0, // Height of the BottomNavigationBar
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
    // var db = new Mysql();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 173, 181, 1.0)),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
