import 'package:flutter/material.dart';
import 'posts.dart';

void main() => runApp(YCNews());

class YCNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YCNews',
      home: PostData(),
    );
  }
}

class PostData extends StatefulWidget {
  @override
  _PostDataState createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  List<Map<String, dynamic>> fetchedPosts = [];
  int pressed = 0;
  int startValue = 0;
  // Built in lifecycle method which gets called on as soons as the widget is loaded
  @override
  void initState() {
    super.initState();

    getPosts();
  }

  void getPosts() async {
    Post post = Post();
    fetchedPosts =
        await post.getPosts(startValue: startValue, endValue: startValue + 9);
    setState(() {
      fetchedPosts = fetchedPosts;
      pressed += 1;
      startValue = pressed + 10;
    });
    print(fetchedPosts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YCNews'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              getPosts();
            },
            child: Text('Fetch Posts'),
          )
          // fetchedPosts.map((post) => Text(post['title'])).toList(),
        ],
      ),
    );
  }
}
