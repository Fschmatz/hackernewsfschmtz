import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hackernewsfschmtz/pages/article_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  bool _showBottomBar = true;
  EdgeInsetsGeometry navBarPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 8);
  int _currentIndex = 0; //always start with TopStories

  final List<Widget> _articlesList = [
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
    TextStyle styleFontNavBar = TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).accentColor);

    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() => _showBottomBar = true);
            } else if (notification.direction == ScrollDirection.reverse) {
              setState(() => _showBottomBar = false);
            }
            return true;
          },
          child: SafeArea(child: _articlesList[_currentIndex])),
      bottomNavigationBar: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: _showBottomBar ? 1 : 0,
        child: Container(
          height:  _showBottomBar ? 60 : 0 ,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          child: SafeArea(
            child: Padding(
              padding:
                   EdgeInsets.symmetric(horizontal: 18.0, vertical: _showBottomBar ? 10 : 0),
              child: GNav(
                rippleColor: Theme.of(context).accentColor.withOpacity(0.4),
                hoverColor: Theme.of(context).accentColor.withOpacity(0.4),
                color: Theme.of(context)
                    .textTheme
                    .headline6!
                    .color!
                    .withOpacity(0.8),
                gap: 8,
                activeColor: Theme.of(context).accentColor,
                iconSize: 24,
                padding:
                     EdgeInsets.symmetric(horizontal: 12, vertical: _showBottomBar ? 8 : 0),
                duration: const Duration(milliseconds: 500),
                tabBackgroundColor:
                    Theme.of(context).accentColor.withOpacity(0.3),
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
                tabs: [
                  GButton(
                    icon: Icons.bar_chart_outlined,
                    padding: navBarPadding,
                    text: 'Top',
                    textStyle: styleFontNavBar,
                  ),
                  GButton(
                    icon: Icons.schedule_outlined,
                    padding: navBarPadding,
                    text: 'New',
                    textStyle: styleFontNavBar,
                    iconSize: 23,
                  ),
                  GButton(
                    icon: Icons.star_outline,
                    padding: navBarPadding,
                    text: 'Best',
                    textStyle: styleFontNavBar,
                  ),
                  GButton(
                    icon: Icons.campaign_outlined,
                    padding: navBarPadding,
                    text: 'Show',
                    textStyle: styleFontNavBar,
                  ),
                  GButton(
                    icon: Icons.messenger_outline_outlined,
                    padding: navBarPadding,
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
      ),
    );
  }
}
