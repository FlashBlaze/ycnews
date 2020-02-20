import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _showAboutDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('About'),
            children: <Widget>[
              SimpleDialogOption(
                child:
                    Text('Open source Hacker News Reader app built in Flutter'),
              ),
              SimpleDialogOption(
                  child: ListTile(
                leading: Icon(Icons.grade),
                title: Text('Rate on Play Store'),
                onTap: () {},
              )),
              SimpleDialogOption(
                  child: ListTile(
                leading: Icon(Icons.launch),
                title: Text('View on GitHub'),
                onTap: () {},
              )),
              SimpleDialogOption(
                  child: ListTile(
                leading: Icon(Icons.launch),
                title: Text('View my website'),
                onTap: () {},
              )),
            ],
          );
        })) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('About'),
                onTap: () {
                  _showAboutDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
