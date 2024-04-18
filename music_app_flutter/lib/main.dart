import 'package:flutter/material.dart';
import 'package:music_app_flutter/navigations/tabbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(

      themeMode: ThemeMode.dark ,
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
        ),
      ),

      home: Tabbar(),
    );
  }
}
