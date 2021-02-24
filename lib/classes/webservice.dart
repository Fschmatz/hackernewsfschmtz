import 'dart:convert';
import 'package:hackernewsfschmtz/classes/urlHelper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Webservice {

  Future<Response> _getStory(int storyId) {
    return http.get(UrlHelper.urlForStory(storyId));
  }

  Future<List<Response>> getTopStories(int quant) async {
    final response = await http.get(UrlHelper.urlForTopStories());
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);
      return Future.wait(storyIds.take(quant).map((storyId) {
        return _getStory(storyId);
      }));
    } else {
      throw Exception("Nothing");
    }
  }

  Future<List<Response>> getTopStoriesTimerSecundario(int valorSkip,int quant) async {
    final response = await http.get(UrlHelper.urlForTopStories());
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);
      return Future.wait(storyIds.skip(valorSkip).take(quant).map((storyId) {
        return _getStory(storyId);
      }));
    } else {
      throw Exception("Nothing");
    }
  }

  Future<List<Response>> getTopStoriesScrolling(int valorSkip,int quantidade) async {
    final response = await http.get(UrlHelper.urlForTopStories());
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);
      return Future.wait(storyIds.skip(valorSkip).take(quantidade).map((storyId) {
        return _getStory(storyId);
      }));
    } else {
      throw Exception("Sem resposta");
    }
  }
}

