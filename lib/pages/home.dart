import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/articlePages.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/classes/webservice.dart';
import 'package:hackernewsfschmtz/configs/settingsPage.dart';
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
  List<ArticlePages> listArticlePages = new ArticlePages().getArticlePages();
  bool loading = true;
  bool loadStoriesOnScroll = false;
  bool getTopStoriesSecondaryIsDone = false;
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

    _getStoryIdsLidos();
    _getStoriesOnStartup();
    super.initState();
  }

  Future<void> _getStoryIdsLidos() async {
    final dbLidos = lidosDao.instance;
    var resp = await dbLidos.queryAllStoriesLidosIds();
    for (int i = 0; i < resp.length; i++) {
      listIdsRead.add(resp[i]['idTopStory']);
    }
    setState(() {});
  }

  void refreshIdLidos() {
    _getStoryIdsLidos();
  }

  changeArticlePage(ArticlePages article) {
    setState(() {
      loading = true;
      pageName = article.name;
      articleType = article.maskLink;
    });
  }

  //LOAD STORIES STARTUP
  Future<void> _getStoriesOnStartup() async {
    final responses = await Webservice().getTopStories(articleType, 15);
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
    await Webservice().getTopStoriesScrolling(articleType, 15, 15);
    final storiesResp = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    _stories.addAll(storiesResp);

    //REMOVE DUPLICATES
    final ids = _stories.map((e) => e.storyId).toSet();
    _stories.retainWhere((x) => ids.remove(x.storyId));

    setState(() {
      _stories = _stories;
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
        final storiesResp = responses.map((response) {
          final json = jsonDecode(response.body);
          return Story.fromJSON(json);
        }).toList();
        _stories.addAll(storiesResp);

        //REMOVE DUPLICATES
        final ids = _stories.map((e) => e.storyId).toSet();
        _stories.retainWhere((x) => ids.remove(x.storyId));

        setState(() {
          loadStoriesOnScroll = false;
          _stories = _stories;
        });
      }
    }
  }

  void openBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Column(
                children: [
                  Center(
                    child: ListTile(
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
                    ),
                  ),
                  const Divider(),
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
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
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'HN  ',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.9),
                      fontSize: 20,
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
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        child: loading
            ? Loading(
          key: UniqueKey(),
          pageName: pageName,
        )
            : LazyLoadScrollView(
          onEndOfPage: () => _getMoreStoriesScrolling(),
          isLoading: loadStoriesOnScroll,
          child: RefreshIndicator(
            onRefresh: _getStoriesOnStartup,
            color: Theme.of(context).accentColor,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
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
                          commentsCount: _stories[index].commentsCount == null ? 0 : _stories[index].commentsCount,
                          time: _stories[index].time,
                          lido: listIdsRead
                              .contains(_stories[index].storyId)
                              ? true
                              : false,
                        ));
                  },
                ),
                Visibility(
                    visible: loadStoriesOnScroll,
                    child:  Align(
                      alignment: Alignment.bottomCenter,
                      child: PreferredSize(
                        preferredSize: Size.fromHeight(2),
                        child: LinearProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).accentColor.withOpacity(0.8)),
                          backgroundColor:
                          Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.refresh_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.8),
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
                      color: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.8),
                    ),
                    onPressed: () {
                      openBottomSheet();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.8),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => SettingsPage(),
                            fullscreenDialog: true,
                          ));
                    }),
              ],
            ),
          )),
    );
  }
}

