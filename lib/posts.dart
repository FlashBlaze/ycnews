import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Post {
  List<Map<String, dynamic>> posts = [];

  Future<void> getPosts() async {
    var uri =
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty&orderBy="\$key"&limitToFirst=5';
    var response = await http.get(uri);
    var ids = convert.jsonDecode(response.body);

    for (var i = 0; i < ids.length; i++) {
      var postUri =
          'https://hacker-news.firebaseio.com/v0/item/${ids[i]}.json?print=pretty';
      var postResponse = await http.get(postUri);
      posts.add(convert.jsonDecode(postResponse.body));
      // print(convert.jsonDecode(postResponse.body)['title']);
    }
  }
}
