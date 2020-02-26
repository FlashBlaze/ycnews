import 'package:flutter/material.dart';

import 'package:ycnews/screens/home.dart';
import 'package:ycnews/screens/settings.dart';

void main() => runApp(YCNews());

class YCNews extends StatefulWidget {
  @override
  _YCNewsState createState() => _YCNewsState();
}

class _YCNewsState extends State<YCNews> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final _widgetOptions = [
    TopStories(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News Reader',
      home: Scaffold(
        body: Container(
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.grey[850],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
