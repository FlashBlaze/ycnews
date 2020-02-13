import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'posts.dart';

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

class StoryData extends StatefulWidget {
  @override
  _StoryDataState createState() => _StoryDataState();
}

class _StoryDataState extends State<StoryData> {
  List<Map<String, dynamic>> allStories = [], fetchedStories = [];
  int scrolled = 0, startValue = 0;
  ScrollController _scrollController = ScrollController();

  // Built in lifecycle method which gets called on as soons as the widget is loaded
  @override
  void initState() {
    super.initState();
    getStories();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // If we are at the bottom of the page
        getStories();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getStories() async {
    Story story = Story();
    fetchedStories = await story.getStories(
        startValue: startValue, endValue: startValue + 9);
    setState(() {
      allStories.addAll(fetchedStories);
      scrolled += 1;
      startValue = scrolled * 10;
    });
    print('Scrolled: $scrolled and ${allStories.length}');
  }

  // _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

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
        child: allStories.length != 0
            ? ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: allStories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Center(
                        child: FlatButton(
                      child: Text('${allStories[index]['title']}'),
                      onPressed: () async {
                        var url = '${allStories[index]['url']}';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch ${allStories[index]['url']}';
                        }
                      },
                    )),
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
