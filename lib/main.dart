import 'package:flutter/material.dart';

// import 'package:ycnews/screens/settings.dart';
import 'package:ycnews/screens/home.dart';

void main() => runApp(YCNews());

class YCNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YCNews',
      home: StoryData(),
    );
  }
}
