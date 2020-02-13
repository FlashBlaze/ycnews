import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Story {
  String type;
  String by;
  int time;
  String text;
  bool dead;
  int parent;
  int poll;
  List<int> kids;
  String url;
  int score;
  String title;
  List<int> parts;
  int descendants;

  Story({
    this.type,
    this.by,
    this.time,
    this.text,
    this.dead,
    this.parent,
    this.poll,
    this.kids,
    this.url,
    this.score,
    this.title,
    this.parts,
    this.descendants,
  });

  List<Map<String, dynamic>> stories = [];

  Future getStories({int startValue = 0, int endValue = 9}) async {
    var uri =
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty&orderBy="\$key"&startAt="$startValue"&endAt="$endValue"';
    var response = await http.get(uri);
    Map<String, dynamic> ids = convert.jsonDecode(response.body);
    print(ids);
    for (var entry in ids.entries) {
      var postUri =
          'https://hacker-news.firebaseio.com/v0/item/${entry.value}.json?print=pretty';
      var postResponse = await http.get(postUri);
      stories.add(convert.jsonDecode(postResponse.body));
    }
    return stories;
  }
}
