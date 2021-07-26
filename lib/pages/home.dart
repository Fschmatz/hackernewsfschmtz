import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hackernewsfschmtz/classes/articlePages.dart';
import 'package:hackernewsfschmtz/pages/articleList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List<ArticlePages> listArticlePages = new ArticlePages().getArticlePages();
  List<int> listIdsRead = [];
  String articleType;
  String pageName;
  int indexAtual = 0;

  //always start with TopStories
  int _currentIndex = 0;
  List<Widget> _articlesList = [
    ArticleList(
      key: UniqueKey(),
      paginaAtual: 0,
    ),
    ArticleList(
      key: UniqueKey(),
      paginaAtual: 1,
    ),
    ArticleList(
      key: UniqueKey(),
      paginaAtual: 2,
    ),
    ArticleList(
      key: UniqueKey(),
      paginaAtual: 3,
    ),
    ArticleList(
      key: UniqueKey(),
      paginaAtual: 4,
    )
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _articlesList[_currentIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Theme.of(context).accentColor.withOpacity(0.4),
              hoverColor: Theme.of(context).accentColor.withOpacity(0.4),
              color:
                  Theme.of(context).textTheme.headline6.color.withOpacity(0.7),
              gap: 3,
              activeColor: Theme.of(context).accentColor,
              iconSize: 22,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor:
                  Theme.of(context).accentColor.withOpacity(0.3),
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              tabs: [
                GButton(
                  icon: Icons.new_releases_outlined,
                  text: 'Top',
                ),
                GButton(
                  icon: Icons.schedule_outlined,
                  text: 'New',
                ),
                GButton(
                  icon: Icons.star_outline,
                  text: 'Best',
                ),
                GButton(
                  icon: Icons.campaign_outlined,
                  text: 'Show',
                ),
                GButton(
                  icon: Icons.question_answer_outlined,
                  text: 'Ask',
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
