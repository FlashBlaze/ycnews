import 'package:flutter/material.dart';
import 'package:ycnews/custom_drawer.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: CustomDrawer()),
      body: Container(
          child: Center(
        child: Text("Settings screen"),
      )),
    );
  }
}
