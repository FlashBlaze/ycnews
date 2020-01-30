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
  // Built in lifecycle method which gets called on as soons as the widget is loaded
  @override
  void initState() {
    super.initState();

    getPosts();
  }

  void getPosts() async {
    Post post = Post();
    fetchedPosts = await post.getPosts();
    print(fetchedPosts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YCNews'),
      ),
      body: Column(
        children: fetchedPosts.map((post) => Text(post['title'])).toList(),
      ),
    );
  }
}
