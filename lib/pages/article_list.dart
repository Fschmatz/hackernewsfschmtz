import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/classes/web_service.dart';
import 'package:hackernewsfschmtz/configs/settings.dart';
import 'package:hackernewsfschmtz/db/lidos_dao.dart';
import 'package:hackernewsfschmtz/widgets/container_story.dart';
import 'package:hackernewsfschmtz/pages/loading.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class ArticleList extends StatefulWidget {
  String page;

  ArticleList({required Key key, required this.page}) : super(key: key);

  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  String urlPageApi = '';
  List<dynamic> _storiesIds = [].obs;
  final RxList _storiesList = [].obs;
  RxBool loading = true.obs;
  RxBool loadingStoriesOnScroll = true.obs;
  RxBool getTopStoriesSecondaryIsDone = false.obs;
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
      loading.value = true;
    }
    await _getStoryIdsRead();
    await _getStoriesIds();
    _populateStories(0, 20, true);
  }

  @override
  void dispose() {
    scrollControllerAppbar.dispose();
    super.dispose();
  }

  Future<void> _getStoriesIds() async {
    final response = await http.get(Uri.parse(urlPageApi)).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: const Text('Loading Error'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              appStartFunctions;
            },
          ),
        ));
      },
    );
    if (response.statusCode == 200) {
      _storiesIds = jsonDecode(response.body);
    }
  }

  Future<void> _populateStories(
      int skipValue, int takeValue, bool start) async {
    loadingStoriesOnScroll.value = true;

    if (_storiesList.length < _storiesIds.length) {
      final responses = await WebService()
          .getStoriesList(_storiesIds, skipValue, takeValue)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: const Text('Loading Error'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              _populateStories(_storiesList.length, 20, false);
            },
          ),
        ));

      });
      final stories = responses.map((response) {
        final json = jsonDecode(response.body);
        return Story.fromJSON(json);
      }).toList();

      if (start) {
        _storiesList.addAll(stories);
        loading.value = false;
      } else {
        _storiesList.addAll(stories);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text('No more stories to load'),
        duration: const Duration(seconds: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ));

    }
    loadingStoriesOnScroll.value = false;
  }

  Future<void> _getStoryIdsRead() async {
    final dbLidos = LidosDao.instance;
    var resp = await dbLidos.queryAllReadStoriesIds();
    for (int i = 0; i < resp.length; i++) {
      listIdsRead.add(resp[i]['idTopStory']);
    }
    setState(() => listIdsRead);
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
        body: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: loading.value
                ? Loading(
                    key: UniqueKey(),
                  )
                : LazyLoadScrollView(
                    onEndOfPage: () =>
                        _populateStories(_storiesList.length, 20, false),
                    isLoading: loadingStoriesOnScroll.value,
                    scrollOffset: 500,
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
                                          _storiesList[index].commentsCount ??
                                              0,
                                      time: _storiesList[index].time,
                                      lido: listIdsRead.contains(
                                              _storiesList[index].storyId)
                                          ? true
                                          : false,
                                    ));
                              },
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
                            )
                          ],
                        )),
                  ),
          ),
        ));
  }
}
