import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() => runApp(YCNews());

class YCNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'YCNews',
        home: Scaffold(
          body: Center(
            child: PostData(),
          ),
        ));
  }
}

class PostData extends StatefulWidget {
  @override
  _PostDataState createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  void getPosts() async {
    var uri =
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty&orderBy="\$key"&limitToFirst=5';
    var response = await http.get(uri);
    List ids = convert.jsonDecode(response.body);

    for (var i = 0; i < ids.length; i++) {
      var postUri =
          'https://hacker-news.firebaseio.com/v0/item/${ids[i]}.json?print=pretty';
      var postResponse = await http.get(postUri);
      print(convert.jsonDecode(postResponse.body)['title']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: RaisedButton(
        onPressed: () {
          getPosts();
        },
        child: Text('Get 5 post titles'),
      )),
    );
  }
}
