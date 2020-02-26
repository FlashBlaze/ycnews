import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _enableJS = false;
  bool _enableWebView = true;
  SharedPreferences prefs;

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
                onTap: () async {
                  var url =
                      'https://play.google.com/store/apps/details?id=com.flashblaze.ycnews';
                  if (await canLaunch(url)) {
                    await launch(
                      url,
                    );
                  } else {
                    throw 'Could not open Play Store';
                  }
                },
              )),
              SimpleDialogOption(
                  child: ListTile(
                      leading: Icon(Icons.launch),
                      title: Text('View on GitHub'),
                      onTap: () async {
                        var url = 'https://github.com/FlashBlaze/ycnews';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                          );
                        } else {
                          throw 'Could not open GitHub';
                        }
                      })),
              SimpleDialogOption(
                  child: ListTile(
                leading: Icon(Icons.launch),
                title: Text('View my website'),
                onTap: () async {
                  var url = 'https://flashblaze';
                  if (await canLaunch(url)) {
                    await launch(
                      url,
                    );
                  } else {
                    throw 'Could not launch website';
                  }
                },
              )),
            ],
          );
        })) {
    }
  }

  @override
  void initState() {
    super.initState();

    _getJS();
    _getWebView();
  }

  _getJS() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _enableJS = prefs.getBool('_enableJS');
    });
  }

  _setJS(bool value) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _enableJS = value;
      prefs.setBool('_enableJS', value);
    });
  }

  _getWebView() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _enableWebView = prefs.getBool('_enableWebView');
    });
  }

  _setWebView(bool value) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _enableWebView = value;
      prefs.setBool('_enableWebView', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              SwitchListTile(
                  activeColor: Colors.grey[850],
                  title: Text('Javascript'),
                  value: _enableJS ?? true,
                  onChanged: _enableWebView
                      ? (bool value) {
                          _setJS(value);
                        }
                      : null),
              SwitchListTile(
                  activeColor: Colors.grey[850],
                  title: Text('WebView'),
                  value: _enableWebView ?? true,
                  onChanged: (bool value) {
                    _setWebView(value);
                  }),
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
