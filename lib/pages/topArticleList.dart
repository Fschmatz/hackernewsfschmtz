import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/classes/webservice.dart';
import 'package:hackernewsfschmtz/configs/configs.dart';
import 'package:share/share.dart';

class TopArticleList extends StatefulWidget {
  @override
  _TopArticleListState createState() => _TopArticleListState();
}

class _TopArticleListState extends State<TopArticleList> {
  List<Story> _stories = List<Story>();
  bool carregando = true;
  ScrollController _scrollController = ScrollController();
  bool primeiroTap = false;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _getTopStoriesInicial();

    //scroll noticias
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMaisTopStories();
      }
    });

    //topbar
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  //get noticias
  void _getTopStoriesInicial() async {
    final responses = await Webservice().getTopStories(15);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      primeiroTap = false;
      carregando = false;
      _stories = stories;
    });
  }

  void _getTopStoriesNoPrimeiroTap(TapDownDetails details) async {
    if (primeiroTap == false) {
      final responses = await Webservice().getTopStories(_stories.length + 15);
      final stories = responses.map((response) {
        final json = jsonDecode(response.body);
        return Story.fromJSON(json);
      }).toList();
      setState(() {
        primeiroTap = true;
        _stories = stories;
      });
    }
  }

  void _getMaisTopStories() async {
    final responses = await Webservice().getTopStories(_stories.length + 10);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      _stories = stories;
    });
  }

  //Chrome Tabs
  _launchBrowser(String url) async {
    FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: CustomTabsOptions(
        addDefaultShareMenuItem: true,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      AnimatedContainer(
        height: _showAppbar ? 55.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: AppBar(
          elevation: 0,
          title: Text("HN Fschmtz"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: IconButton(
                  //color: Theme.of(context).hintColor,
                  icon: Icon(
                    Icons.refresh,
                    size: 25.0,
                  ),
                  onPressed: () {
                    //scroll to top
                    _scrollController.animateTo(0,
                        duration: Duration(milliseconds: 600),
                        curve: Curves.fastOutSlowIn);

                    _getTopStoriesInicial();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: IconButton(
                  //color: Theme.of(context).hintColor,
                  icon: Icon(
                    Icons.settings,
                    size: 25.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Configs(),
                          fullscreenDialog: true,
                        ));
                  }),
            ),
          ],
        ),
      ),
      Expanded(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 900),
          child: carregando
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Carregando...",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(),
                  ],
                ))
              : GestureDetector(
                  onTapDown: _getTopStoriesNoPrimeiroTap,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black.withOpacity(0.8),
                    ),
                    //physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: _stories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _launchBrowser(_stories[index].url);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(18, 8, 18, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(_stories[index].title,
                                      style: TextStyle(
                                        fontSize: 18,
                                      )),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(_stories[index].url,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).hintColor)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                                  child: Text("${1 + index}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          // color: Theme.of(context).hintColor
                                          color: Theme.of(context).accentColor)),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        color: Theme.of(context).hintColor,
                                        icon: Icon(
                                          Icons.share_outlined,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          Share.share(_stories[index].url);
                                        }),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        color: Theme.of(context).hintColor,
                                        icon: Icon(
                                          Icons.comment_outlined,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          _launchBrowser(
                                              'https://news.ycombinator.com/item?id=' +
                                                  _stories[index]
                                                      .storyId
                                                      .toString());
                                        }),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ),
      )
    ])));
  }
}
