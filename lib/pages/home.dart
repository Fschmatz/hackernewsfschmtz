import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/articlePage.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/classes/webservice.dart';
import 'package:hackernewsfschmtz/configs/configs.dart';
import 'package:hackernewsfschmtz/db/lidosDao.dart';
import 'package:hackernewsfschmtz/pages/containerStory.dart';
import 'package:hackernewsfschmtz/pages/loading.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List<Story> _stories = [];
  List<ArticlePage> listArticlePages = new ArticlePage().getArticlePages();
  bool loading = true;
  bool loadStoriesOnScroll = false;
  bool getTopStoriesSecondaryIsDone = false;
  ScrollController _scrollController;
  List<int> listIdsRead = [];
  String articleType;
  String pageName;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    //always start with TopStories
    articleType = listArticlePages[0].maskLink;
    pageName = listArticlePages[0].name;

    _scrollController = ScrollController();
    _getStoryIdsLidos();
    _getStoriesOnStartup();
    super.initState();
  }

  Future<void> _getStoryIdsLidos() async {
    final dbLidos = lidosDao.instance;
    var resposta = await dbLidos.queryAllStoriesLidosIds();
    for (int i = 0; i < resposta.length; i++) {
      listIdsRead.add(resposta[i]['idTopStory']);
    }
    setState(() {});
  }

  void refreshIdLidos() {
    _getStoryIdsLidos();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> changeArticlePage(ArticlePage article) {
    setState(() {
      loading = true;
      pageName = article.name;
      articleType = article.maskLink;
    });
  }

  //LOAD STORIES STARTUP
  Future<void> _getStoriesOnStartup() async {
    final responses = await Webservice().getTopStories(articleType, 10);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      loading = false;
      _stories = stories;
    });
    _getStoriesSecondary();
  }

  //LOAD STORIES SECONDARY
  Future<void> _getStoriesSecondary() async {
    final responses =
        await Webservice().getTopStoriesScrolling(articleType, 10, 10);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      _stories.addAll(stories);
      getTopStoriesSecondaryIsDone = true;
      loadStoriesOnScroll = false;
    });
  }

  //LOAD STORIES SCROLLING
  Future<void> _getMoreStoriesScrolling() async {
    if (loadStoriesOnScroll == false) {
      //bottom animation start
      setState(() {
        loadStoriesOnScroll = true;
      });
      if (getTopStoriesSecondaryIsDone) {
        final responses = await Webservice()
            .getTopStoriesScrolling(articleType, _stories.length, 10);
        final stories = responses.map((response) {
          final json = jsonDecode(response.body);
          return Story.fromJSON(json);
        }).toList();
        setState(() {
          loadStoriesOnScroll = false;
          _stories.addAll(stories);
        });
      }
    }
  }

  void openBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Column(
                children: [
                  Card(
                      color: Theme.of(context).bottomAppBarColor,
                      margin: const EdgeInsets.fromLTRB(90, 10, 90, 10),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        dense: true,
                        title: Text(
                          "Hacker News", //
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                        subtitle: Text(
                          "news.ycombinator.com",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, color: Theme.of(context).hintColor),
                        ),
                      )),
                  const SizedBox(
                    height: 14,
                  ),
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      thickness: 1.2,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listArticlePages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          changeArticlePage(listArticlePages[index]);
                          _getStoriesOnStartup();
                        },
                        leading: Icon(
                          Icons.article_outlined,
                          color: listArticlePages[index]
                                  .name
                                  .compareTo(pageName)
                                  .isEven
                              ? Theme.of(context).accentColor.withOpacity(0.9)
                              : Theme.of(context).hintColor,
                        ),
                        title: Text(
                          listArticlePages[index].name,
                          style: TextStyle(
                              color: listArticlePages[index]
                                      .name
                                      .compareTo(pageName)
                                      .isEven
                                  ? Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.9)
                                  : Theme.of(context).textTheme.headline6.color,
                              fontSize: 17),
                        ),
                        trailing: Visibility(
                          visible: listArticlePages[index]
                              .name
                              .compareTo(pageName)
                              .isOdd,
                          child: Icon(Icons.keyboard_arrow_right,
                              color: Theme.of(context).hintColor),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 650),
        child: loading
            ? Loading()
            : LazyLoadScrollView(
                onEndOfPage: () => _getMoreStoriesScrolling(),
                scrollOffset: 5,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(27, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'HN  ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text: pageName,
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _stories.length,
                        itemBuilder: (context, index) {
                          return ContainerStory(
                              key: UniqueKey(),
                              contador: index,
                              refreshIdLidos: refreshIdLidos,
                              story: new Story(
                                storyId: _stories[index].storyId,
                                title: _stories[index].title,
                                url: _stories[index].url,
                                score: _stories[index].score,
                                commentsCount: _stories[index].commentsCount,
                                time: _stories[index].time,
                                lido: listIdsRead
                                        .contains(_stories[index].storyId)
                                    ? true
                                    : false,
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: loadStoriesOnScroll,
            child: PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: LinearProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor.withOpacity(0.8)),
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.3),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.refresh_outlined,
                      size: 24,
                      color: Theme.of(context).hintColor,
                    ),
                    onPressed: () {
                      //START ANIMATION
                      setState(() {
                        loading = true;
                      });

                      _getStoriesOnStartup();
                      _getStoryIdsLidos();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.menu_outlined,
                      size: 25,
                      color: Theme.of(context).hintColor,
                    ),
                    onPressed: () {
                      openBottomSheet();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      size: 24,
                      color: Theme.of(context).hintColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => Configs(),
                            fullscreenDialog: true,
                          ));
                    }),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
