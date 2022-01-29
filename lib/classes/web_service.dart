import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class WebService {
  static String urlForStory(int storyId) {
    return "https://hacker-news.firebaseio.com/v0/item/$storyId.json?print=pretty";
  }

  Future<Response> _getStory(int storyId) {
    return http.get(Uri.parse(urlForStory(storyId)));
  }

  Future<List<Response>> getStoriesList(
      List<dynamic> storiesIds, int skipValue, int takeValue) async {
    return Future.wait(
        storiesIds.skip(skipValue).take(takeValue).map((storyId) {
      return _getStory(storyId);
    }));
  }
}
