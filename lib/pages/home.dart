import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hackernewsfschmtz/pages/articleList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {

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

    TextStyle styleFontNavBar =
    TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: Theme.of(context).accentColor);

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
              gap: 8,
              activeColor: Theme.of(context).accentColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              duration: Duration(milliseconds: 500),
              tabBackgroundColor:
                  Theme.of(context).accentColor.withOpacity(0.3),
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              tabs: [
                GButton(
                  icon: Icons.bar_chart_outlined,
                  text: 'Top',
                  textStyle: styleFontNavBar,
                ),
                GButton(
                  icon: Icons.schedule_outlined,
                  text: 'New',
                  textStyle: styleFontNavBar,
                ),
                GButton(
                  icon: Icons.star_outline,
                  text: 'Best',
                  textStyle: styleFontNavBar,
                ),
                GButton(
                  icon: Icons.campaign_outlined,
                  text: 'Show',
                  textStyle: styleFontNavBar,
                ),
                GButton(
                  icon: Icons.messenger_outline_outlined,
                  text: 'Ask',
                  textStyle: styleFontNavBar,
                  iconSize: 22,
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
