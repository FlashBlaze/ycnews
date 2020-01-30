import 'package:flutter/material.dart';
import 'posts.dart';

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
  // Built in lifecycle method which gets called on as soons as the widget is loaded
  @override
  void initState() {
    super.initState();

    getPosts();
  }

  void getPosts() async {
    Post post = Post();
    await post.getPosts();
    print(post.posts);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(),
    );
  }
}
