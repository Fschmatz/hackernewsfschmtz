class ArticlePages {
  final String? name;
  final String? maskLink;

  ArticlePages({this.name, this.maskLink});

  List<ArticlePages> listArticlePages = [];

  List<ArticlePages> getArticlePages() {
    listArticlePages.add(ArticlePages(name: 'Top Stories', maskLink: 'topstories'));
    listArticlePages.add(ArticlePages(name: 'New Stories', maskLink: 'newstories'));
    listArticlePages.add(ArticlePages(name: 'Best Stories', maskLink: 'beststories'));
    listArticlePages.add(ArticlePages(name: 'Show HN', maskLink: 'showstories'));
    listArticlePages.add(ArticlePages(name: 'Ask HN', maskLink: 'askstories'));
    return listArticlePages;
  }
}
