import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ycnews/stories.dart';

class TopStories extends StatefulWidget {
  @override
  _TopStoriesState createState() => _TopStoriesState();
}

class _TopStoriesState extends State<TopStories> {
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getStories() async {
    Story story = Story();
    fetchedStories = await story.getStories(
        startValue: scrolled * 30, endValue: scrolled * 30 + 29);

    if (mounted) {
      setState(() {
        allStories.addAll(fetchedStories);
        scrolled += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                    subtitle: allStories[index].url == null
                        ? Text('news.ycombinator.com')
                        : Text(Uri.parse('${allStories[index].url}').host),
                    onTap: () async {
                      var url = '';
                      if (allStories[index].url == null) {
                        // Temporary code added to view raw comments in web view for now
                        url =
                            'https://news.ycombinator.com/item?id=${allStories[index].id}';
                      } else {
                        url = '${allStories[index].url}';
                      }
                      if (await canLaunch(url)) {
                        await launch(url,
                            forceWebView: true, enableJavaScript: true);
                      } else {
                        throw 'Could not launch ${allStories[index].url}';
                      }
                    },
                    leading: Column(
                      children: <Widget>[
                        Icon(Icons.arrow_drop_up),
                        allStories[index].score == null
                            ? Text('0')
                            : Text('${allStories[index].score}')
                      ],
                    ),
                    trailing: InkWell(
                      // Temporary code added to view raw comments in web view for now
                      onTap: () async {
                        var url =
                            'https://news.ycombinator.com/item?id=${allStories[index].id}';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            forceWebView: true,
                          );
                        } else {
                          throw 'Could not launch ${allStories[index].url}';
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.comment),
                          allStories[index].kids == null
                              ? Text('0')
                              : Text('${allStories[index].kids.length}'),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )
            : SpinKitFoldingCube(
                color: Colors.grey[850],
              ),
      ),
    );
  }
}
