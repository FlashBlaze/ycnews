import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Story {
  int id;
  bool deleted;
  String type;
  String by;
  int time;
  String text;
  bool dead;
  int parent;
  int poll;
  List<dynamic> kids;
  String url;
  int score;
  String title;
  List<dynamic> parts;
  int descendants;

  Story({
    this.id,
    this.deleted,
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

  factory Story.fromJson(Map<String, dynamic> parsedJson) {
    return Story(
      id: parsedJson['id'],
      deleted: parsedJson['deleted'],
      type: parsedJson['type'],
      by: parsedJson['by'],
      time: parsedJson['time'],
      text: parsedJson['text'],
      dead: parsedJson['dead'],
      parent: parsedJson['parent'],
      poll: parsedJson['poll'],
      kids: parsedJson['kids'],
      url: parsedJson['url'],
      score: parsedJson['score'],
      title: parsedJson['title'],
      parts: parsedJson['parts'],
      descendants: parsedJson['descendants'],
    );
  }

  Future getStories() async {
    final topStoriesUri =
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty';
    final response = await http.get(topStoriesUri);
    if (response.statusCode == 200) {
      List<int> ids = convert.jsonDecode(response.body).cast<int>();
      return await Future.wait(ids.sublist(0, 10).map((id) async {
        var storyResponse = await http.get(
            'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');
        return Story.fromJson(convert.jsonDecode(storyResponse.body));
      }));
    }
  }
}
