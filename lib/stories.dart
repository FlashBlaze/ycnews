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
    Story story;
    final uri =
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty';
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<int> ids = convert.jsonDecode(response.body).cast<int>();

      var stories = [];
      await Future.forEach(ids.sublist(0, 10), (id) async {
        final storyUri =
            'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty';
        final storyResponse = await http.get(storyUri);
        final parsedJson = convert.jsonDecode(storyResponse.body);
        story = Story.fromJson(parsedJson);
        stories.add(story);
      });
      return stories;
    }
  }
}
