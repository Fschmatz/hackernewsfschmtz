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

  void _getStoriesOnStartup() async {
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

  void _getStoriesSecondary() async {
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

  void _getStoriesButtonRefresh() async {
    final responses = await Webservice().getTopStories(articleType, 10);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      _stories = stories;
      Navigator.of(context).pop();
    });
    _getStoriesSecondary();
  }

  //SCROLLING
  void _getMoreStoriesScrolling() async {
    if (loadStoriesOnScroll == false) {
      //bottom animation
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

  //ANIMATION LOADING REFRESH
  Future<Null> _showAlertDialogLoading(BuildContext context) async {
    return await showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        });
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
                    margin: const EdgeInsets.fromLTRB(90, 10, 90, 10),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child:ListTile(
                      dense: true,
                      title:  Text(
                        "Hacker News", //
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17.5, ),
                      ),
                      subtitle:Text(
                        "news.ycombinator.com",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).hintColor),
                      ),
                    )
                  ),
                  const SizedBox(height: 10,),
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
                        leading: Icon(Icons.article_outlined,
                            color: Theme.of(context).hintColor),
                        title: Text(
                          listArticlePages[index].name,
                          style: TextStyle(fontSize: 17.5),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            color: Theme.of(context).hintColor),
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
        duration: Duration(milliseconds: 700),
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
                        height: 45,
                      ),
                      const Text(
                        "Hacker News", //
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        pageName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, color: Theme.of(context).hintColor),
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
                      Icons.refresh,
                      size: 24,
                      color: Theme.of(context).hintColor,
                    ),
                    onPressed: () {
                      //scroll to top
                      _scrollController.animateTo(0,
                          duration: Duration(milliseconds: 950),
                          curve: Curves.fastOutSlowIn);

                      _getStoriesButtonRefresh();
                      _getStoryIdsLidos();
                      _showAlertDialogLoading(context);
                    }),
                IconButton(
                    icon: Icon(
                      Icons.menu,
                      //size: 24,
                      color: Theme.of(context).hintColor,
                    ),
                    onPressed: () {
                      openBottomSheet();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.settings,
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
