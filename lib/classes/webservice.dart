import 'dart:convert';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/classes/urlHelper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Webservice {

  //recebe a story passando o id vindo do getTopStories
  Future<Response> _getStory(int storyId) {
    return http.get(UrlHelper.urlForStory(storyId));
  }

  Future<List<Response>> getTopStories(int quantidade) async {

    final response = await http.get(UrlHelper.urlForTopStories());
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);
      return Future.wait(storyIds.take(quantidade).map((storyId) {
        return _getStory(storyId);
      }));
    } else {
      throw Exception("Sem resposta");
    }
  }

}
