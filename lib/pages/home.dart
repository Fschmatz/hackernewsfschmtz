import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hackernewsfschmtz/pages/article_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  bool _showBottomBar = true;
  EdgeInsetsGeometry navBarPadding =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 8);
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
            height: _showBottomBar
                ? (80 + MediaQuery.of(context).padding.bottom)
                : 0,
            color: Theme.of(context).navigationBarTheme.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
                animationDuration: const Duration(seconds: 1),
                selectedIndex: _currentIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.bar_chart_outlined),
                    selectedIcon: Icon(Icons.bar_chart),
                    label: 'Top',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.schedule_outlined),
                    selectedIcon: Icon(Icons.schedule),
                    label: 'New',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.star_outline),
                    selectedIcon: Icon(Icons.star),
                    label: 'Best',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.campaign_outlined),
                    selectedIcon: Icon(Icons.campaign),
                    label: 'Show',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.messenger_outline_outlined),
                    selectedIcon: Icon(Icons.messenger),
                    label: 'Ask',
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
