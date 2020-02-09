import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Post {
  List<Map<String, dynamic>> posts = [];

  Future getPosts({int startValue = 0, int endValue = 9}) async {
    var uri =
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty&orderBy="\$key"&startAt="$startValue"&endAt="$endValue"';
    var response = await http.get(uri);
    Map<String, dynamic> ids = convert.jsonDecode(response.body);
    for (var entry in ids.entries) {
      var postUri =
          'https://hacker-news.firebaseio.com/v0/item/${entry.value}.json?print=pretty';
      var postResponse = await http.get(postUri);
      posts.add(convert.jsonDecode(postResponse.body));
    }
    return posts;
  }
}
