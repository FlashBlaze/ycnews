import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'stories.dart';

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
  var allStories = [];
  var fetchedStories = [];
  int scrolled = 0;
  ScrollController _scrollController = ScrollController();

  // Built in lifecycle method which gets called as soons as the widget is loaded
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

  void getStories() async {
    Story story = Story();
    var fetchedStories = await story.getStories(
        startValue: scrolled * 30, endValue: scrolled * 30 + 29);
    setState(() {
      allStories.addAll(fetchedStories);
      scrolled += 1;
    });
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
        child: allStories.length != 0
            ? ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: allStories.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      '${allStories[index].title}',
                    ),
                    subtitle: Text(Uri.parse('${allStories[index].url}').host),
                    onTap: () async {
                      var url = '${allStories[index].url}';
                      if (await canLaunch(url)) {
                        await launch(url,
                            forceWebView: true, enableJavaScript: true);
                      } else {
                        throw 'Could not launch ${allStories[index]['url']}';
                      }
                    },
                  );
                  // return Container(
                  //     height: 50,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: <Widget>[
                  //         Flexible(
                  //           child: FlatButton(
                  //             child: Text(
                  //               '${allStories[index].title}',
                  //             ),
                  //             onPressed: () async {
                  //               var url = '${allStories[index].url}';
                  //               if (await canLaunch(url)) {
                  //                 await launch(url, forceWebView: true);
                  //               } else {
                  //                 throw 'Could not launch ${allStories[index]['url']}';
                  //               }
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     ));
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
