class ArticlePage {
  final String name;
  final String maskLink;

  ArticlePage({this.name, this.maskLink});

  List<ArticlePage> listArticlePages = [];

  List<ArticlePage> getArticlePages() {
    listArticlePages.add(new ArticlePage(name: 'Top Stories', maskLink: 'topstories'));
    listArticlePages.add(new ArticlePage(name: 'New Stories', maskLink: 'newstories'));
    listArticlePages.add(new ArticlePage(name: 'Best Stories', maskLink: 'beststories'));
    listArticlePages.add(new ArticlePage(name: 'Show HN', maskLink: 'showstories'));
    listArticlePages.add(new ArticlePage(name: 'Ask HN', maskLink: 'askstories'));
    return listArticlePages;
  }
}
