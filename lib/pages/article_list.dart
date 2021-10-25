import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/article_pages.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/classes/webservice.dart';
import 'package:hackernewsfschmtz/configs/settings_page.dart';
import 'package:hackernewsfschmtz/db/lidos_dao.dart';
import 'package:hackernewsfschmtz/widgets/container_story.dart';
import 'package:hackernewsfschmtz/pages/loading.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class ArticleList extends StatefulWidget {
  int paginaAtual;

  ArticleList({required Key key, required this.paginaAtual}) : super(key: key);

  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  List<Story> _stories = [];
  List<ArticlePages> listArticlePages = ArticlePages().getArticlePages();
  bool loading = true;
  bool loadStoriesOnScroll = false;
  bool getTopStoriesSecondaryIsDone = false;
  List<int> listIdsRead = [];
  String? articleType;
  final controllerScrollHideAppbar = ScrollController();

  @override
  void initState() {
    articleType = listArticlePages[widget.paginaAtual].maskLink;
    _getStoryIdsRead();
    _getStoriesOnStartup();
    super.initState();
  }

  @override
  void dispose() {
    controllerScrollHideAppbar.dispose();
    super.dispose();
  }

  void refreshIdRead() {
    _getStoryIdsRead();
  }

  Future<void> _getStoryIdsRead() async {
    final dbLidos = LidosDao.instance;
    var resp = await dbLidos.queryAllStoriesLidosIds();
    for (int i = 0; i < resp.length; i++) {
      listIdsRead.add(resp[i]['idTopStory']);
    }
    setState(() {});
  }

  //LOAD STORIES STARTUP
  Future<void> _getStoriesOnStartup() async {
    final responses =
        await Webservice().getTopStories(articleType!, 20).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: const Text('Loading Error'),
          duration: const Duration(seconds: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: _getStoriesOnStartup,
          ),
        ));
      },
    );
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
        await Webservice().getTopStoriesScrolling(articleType!, 20, 20);
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
            .getTopStoriesScrolling(articleType!, _stories.length, 20);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ScrollAppBar(
          controller: controllerScrollHideAppbar,
          title: const Text('HN',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              )),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: Theme.of(context)
                      .textTheme
                      .headline6!
                      .color!
                      .withOpacity(0.7),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => SettingsPage(
                          key: UniqueKey(),
                        ),
                        fullscreenDialog: true,
                      ));
                }),
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: loading
              ? Loading(
                  key: UniqueKey(),
                )
              : LazyLoadScrollView(
                  scrollOffset: 15,
                  onEndOfPage: _getMoreStoriesScrolling,
                  isLoading: loadStoriesOnScroll,
                  child: RefreshIndicator(
                      onRefresh: _getStoriesOnStartup,
                      color: Theme.of(context).accentColor,
                      child: ListView(
                        controller: controllerScrollHideAppbar,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _stories.length,
                            itemBuilder: (context, index) {
                              return ContainerStory(
                                  key: UniqueKey(),
                                  contador: index,
                                  refreshIdLidos: refreshIdRead,
                                  story: Story(
                                    storyId: _stories[index].storyId,
                                    title: _stories[index].title,
                                    url: _stories[index].url,
                                    score: _stories[index].score,
                                    commentsCount:
                                        _stories[index].commentsCount ?? 0,
                                    time: _stories[index].time,
                                    lido: listIdsRead
                                            .contains(_stories[index].storyId)
                                        ? true
                                        : false,
                                  ));
                            },
                          ),
                          loadLine(context, loadStoriesOnScroll),
                        ],
                      )),
                ),
        ));
  }
}

Widget loadLine(BuildContext ctx, bool loading) {
  return Column(children: [
    const Divider(
      height: 0,
    ),
    const SizedBox(
      height: 16,
    ),
    loading
        ? LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(ctx).accentColor.withOpacity(0.8)),
            backgroundColor: Theme.of(ctx).accentColor.withOpacity(0.3),
          )
        : const SizedBox.shrink(),
  ]);
}
