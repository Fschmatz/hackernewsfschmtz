import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/classes/webservice.dart';
import 'package:hackernewsfschmtz/configs/configs.dart';
import 'package:hackernewsfschmtz/db/lidosDao.dart';
import 'package:hackernewsfschmtz/pages/containerInkStory.dart';
import 'package:hackernewsfschmtz/pages/loading.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Story> _stories = List<Story>();
  bool carregando = true;
  bool loadMaisStoriesScroll = false;
  ScrollController _scrollController = ScrollController();


  //LOGICA DB
  List<Map<String, dynamic>> mapIdLidos = new List();
  final dbLidos = lidosDao.instance;
  List<int> listaIdsLidos = new List();

  @override
  void initState() {
    _getTopStoriesInicial();
    _getStoryIdsLidos();
    super.initState();
  }

  Future<void> _getStoryIdsLidos() async {
    var resposta = await dbLidos.queryAllStoriesLidosIds();
    setState(() {
      mapIdLidos = resposta;
    });

    int i = 0;
    while(i < resposta.length){
      listaIdsLidos.add(resposta[i]['idTopStory']);
      i++;
    }
  }

  void _markRead(int idStory) async {
    final dbLidos = lidosDao.instance;
    Map<String, dynamic> row = {
      lidosDao.columnidTopStory: idStory,
    };
    final id = await dbLidos.insert(row);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  refresh(){
    setState(() {
      _getStoryIdsLidos();
    });
  }


  //get noticias
  void _getTopStoriesInicial() async {
    final responses = await Webservice().getTopStories(15);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      carregando = false;
      _stories = stories;
    });

    Timer(const Duration(milliseconds: 6000), () {
      _getTopStoriesSecundario();
    });
  }

  void _getTopStoriesRefresh() async {
    final responses = await Webservice().getTopStories(15);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      _stories = stories;
      Navigator.of(context).pop();
    });

    Timer(const Duration(milliseconds: 6000), () {
      _getTopStoriesSecundario();
    });
  }


  //USADO PRO TIMER
  void _getTopStoriesSecundario() async {
    final responses = await Webservice().getTopStoriesTimerSecundario(15, 15);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      _stories += stories;
    });
  }

  //USADO PRO SCROLL
  void _getMaisTopStoriesScrolling() async {
    if(loadMaisStoriesScroll == false ) {
      //liga animacao bottom
      setState(() {
        loadMaisStoriesScroll = true;
      });

      final responses = await Webservice().getTopStoriesScrolling(_stories.length, 10);
      final stories = responses.map((response) {
        final json = jsonDecode(response.body);
        return Story.fromJSON(json);
      }).toList();
      setState(() {
        loadMaisStoriesScroll = false;
        _stories += stories;
      });
    }
  }

  //Chrome Tabs
  _launchBrowser(String url){
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

  //LOADING DO REFRESH
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ScrollAppBar(
            controller: _scrollController,
            elevation: 0,
            title: Text("HN Fschmtz"), //Text("HN Fschmtz")
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                child: IconButton(
                    icon: Icon(
                      Icons.refresh_outlined,
                      size: 24,
                    ),
                    onPressed: () {
                      //scroll to top
                      _scrollController.animateTo(0,
                          duration: Duration(milliseconds: 700),
                          curve: Curves.fastOutSlowIn);

                      _getTopStoriesRefresh();
                      _getStoryIdsLidos();
                      _showAlertDialogLoading(context);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 24,
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
            ]
        ),
        body: Snap(
          controller: _scrollController.appBar,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 700),
            child: carregando
                ? Loading()
                : LazyLoadScrollView(
              onEndOfPage: () => _getMaisTopStoriesScrolling(), //PrintTeste(), //
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(
                  thickness: 1,
                  color: Colors.black38,
                ),
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: _stories.length,
                itemBuilder: (context, index) {
                  return ContainerInkStory(
                      refresh: refresh,
                      contador: index,
                      launchBrowser: _launchBrowser,
                      markRead: _markRead,
                      lido: listaIdsLidos.contains(_stories[index].storyId) ? true : false,
                      story: new Story(
                        storyId: _stories[index].storyId,
                        title: _stories[index].title,
                        url: _stories[index].url,
                        score: _stories[index].score,
                        commentsCount: _stories[index].commentsCount,
                        time: _stories[index].time,
                      )
                  );
                },
              ),
            ),
          ),
        ),

        bottomNavigationBar: loadMaisStoriesScroll
            ? PreferredSize(
          preferredSize: Size.fromHeight(5.0),
          child: LinearProgressIndicator(
            backgroundColor:
            Theme.of(context).accentColor.withOpacity(0.3),
          ),
        )
            : SizedBox.shrink()
    );
  }
}





