class ArticlePages {
  final String? name;
  final String? maskLink;

  ArticlePages({this.name, this.maskLink});

  List<ArticlePages> listArticlePages = [];

  List<ArticlePages> getArticlePages() {
    listArticlePages.add(new ArticlePages(name: 'Top Stories', maskLink: 'topstories'));
    listArticlePages.add(new ArticlePages(name: 'New Stories', maskLink: 'newstories'));
    listArticlePages.add(new ArticlePages(name: 'Best Stories', maskLink: 'beststories'));
    listArticlePages.add(new ArticlePages(name: 'Show HN', maskLink: 'showstories'));
    listArticlePages.add(new ArticlePages(name: 'Ask HN', maskLink: 'askstories'));
    return listArticlePages;
  }
}
