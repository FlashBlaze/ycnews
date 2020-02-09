import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    print('Pressed: $pressed and ${fetchedPosts.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YCNews',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: fetchedPosts.length != 0
            ? ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: fetchedPosts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child:
                        Center(child: Text('${fetchedPosts[index]['title']}')),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )
            : SpinKitFoldingCube(
                color: Colors.black54,
              ),
      ),
    );
  }
}
