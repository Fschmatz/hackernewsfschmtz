class UrlHelper {

  static String urlForStory(int storyId) {
    return "https://hacker-news.firebaseio.com/v0/item/$storyId.json?print=pretty";
  }

  static String urlStories(String page) {
    return "https://hacker-news.firebaseio.com/v0/$page.json?print=pretty";
  }

}
