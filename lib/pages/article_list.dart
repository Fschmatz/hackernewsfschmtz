import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/classes/web_service.dart';
import 'package:hackernewsfschmtz/db/lidos_dao.dart';
import 'package:hackernewsfschmtz/widgets/container_story.dart';
import 'package:hackernewsfschmtz/pages/loading.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import '../configs/settings.dart';

class ArticleList extends StatefulWidget {
  String page;

  ArticleList({required Key key, required this.page}) : super(key: key);

  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  List<dynamic> _allStoriesIds = [];
  List<Story> _storiesList = [];
  bool loading = true;
  bool loadingStoriesOnScroll = false;
  bool getTopStoriesSecondaryIsDone = false;
  String urlPageApi = '';
  List<int> listIdsRead = [];
  final scrollControllerAppbar = ScrollController();

  @override
  void initState() {
    urlPageApi =
        "https://hacker-news.firebaseio.com/v0/${widget.page}.json?print=pretty";
    appStartFunctions();
    super.initState();
  }

  Future<void> appStartFunctions([bool showAnimation = false]) async {
    if (showAnimation) {
      setState(() {
        loading = true;
      });
    }
    await _getStoryIdsRead();
    await get_allStoriesIds();
    _populateStoriesOnStart();
  }

  @override
  void dispose() {
    scrollControllerAppbar.dispose();
    super.dispose();
  }

  Future<void> get_allStoriesIds() async {
    final response = await http.get(Uri.parse(urlPageApi)).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Loading Error'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              appStartFunctions();
            },
          ),
        ));
      },
    );
    if (response.statusCode == 200) {
      _allStoriesIds = jsonDecode(response.body);
    }
  }

  List<dynamic> _getQuantityStoriesIDs(int start, int end) {
    List<dynamic> quantStoryList = [];
    quantStoryList = _allStoriesIds.sublist(start, (start + end));
    return quantStoryList;
  }

  Future<void> _populateStoriesOnStart() async {
    final responses = await WebService()
        .getStoriesList(_getQuantityStoriesIDs(0, 20))
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Loading Error'),
        action: SnackBarAction(
          label: 'RETRY',
          onPressed: () {
            _populateStoriesOnStart();
          },
        ),
      ));
    });

    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();

    _storiesList = stories;
    setState(() {
      loading = false;
    });
  }

  Future<void> _populateStoriesOnScroll() async {
    setState(() {
      loadingStoriesOnScroll = true;
    });
    final responses = await WebService()
        .getStoriesList(((_storiesList.length + 10) < _allStoriesIds.length)
            ? _getQuantityStoriesIDs(_storiesList.length, 10)
            : _getQuantityStoriesIDs(_storiesList.length,
                (_allStoriesIds.length - _storiesList.length)))
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Loading Error'),
        action: SnackBarAction(
          label: 'RETRY',
          onPressed: () {
            _populateStoriesOnScroll();
          },
        ),
      ));
    });
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      loadingStoriesOnScroll = false;
      _storiesList += stories;
    });
  }

  Future<void> _getStoryIdsRead() async {
    final dbLidos = LidosDao.instance;
    var resp = await dbLidos.queryAllReadStoriesIds();
    for (int i = 0; i < resp.length; i++) {
      listIdsRead.add(resp[i]['idTopStory']);
    }
    setState(() => listIdsRead);
  }

  void showEndListSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'No more stories to load',
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 4),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ScrollAppBar(
          controller: scrollControllerAppbar,
          title: const Text('HN'),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                ),
                onPressed: () {
                  Get.to(() => const Settings());
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
                  onEndOfPage: () => {
                    if (_storiesList.length != _allStoriesIds.length)
                      {_populateStoriesOnScroll()}
                    else
                      {showEndListSnackBar()}
                  },
                  isLoading: loadingStoriesOnScroll,
                  scrollOffset: 200,
                  child: RefreshIndicator(
                      onRefresh: () => appStartFunctions(true),
                      color: Theme.of(context).colorScheme.primary,
                      child: ListView(
                        controller: scrollControllerAppbar,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _storiesList.length,
                            itemBuilder: (context, index) {
                              return ContainerStory(
                                  key: UniqueKey(),
                                  contador: index,
                                  refreshIdLidos: _getStoryIdsRead,
                                  story: Story(
                                    storyId: _storiesList[index].storyId,
                                    title: _storiesList[index].title,
                                    url: _storiesList[index].url,
                                    score: _storiesList[index].score,
                                    commentsCount:
                                        _storiesList[index].commentsCount ?? 0,
                                    time: _storiesList[index].time,
                                    lido: listIdsRead.contains(
                                            _storiesList[index].storyId)
                                        ? true
                                        : false,
                                  ));
                            },
                          ),
                          (loadingStoriesOnScroll)
                              ? Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  LinearProgressIndicator(
                                      minHeight: 5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.8)),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.3),
                                    ),
                                ],
                              )
                              : const SizedBox(
                                  height: 20,
                                )
                        ],
                      )),
                ),
        ));
  }
}
