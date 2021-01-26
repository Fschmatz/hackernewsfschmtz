import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/classes/webservice.dart';
import 'package:hackernewsfschmtz/configs/configs.dart';
import 'package:hackernewsfschmtz/pages/containerInkStory.dart';
import 'package:hackernewsfschmtz/pages/loading.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Story> _stories = List<Story>();
  bool carregando = true;
  bool isScrollingDown = false;
  bool loadMaisStoriesScroll = false;

  @override
  void initState() {
    super.initState();
    _getTopStoriesInicial();
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

    Timer(const Duration(milliseconds: 8000), () {
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
      carregando = false;
      _stories = stories;
      Navigator.of(context).pop();
    });

    Timer(const Duration(milliseconds: 7000), () {
      _getTopStoriesSecundario();
    });
  }

  void _getTopStoriesSecundario() async {
    final responses = await Webservice().getTopStories(_stories.length + 15);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      _stories = stories;
    });
  }

  void _getMaisTopStories() async {
    if(_stories.length > 20) {
      //animacao
      setState(() {
        loadMaisStoriesScroll = true;
      });
      final responses = await Webservice().getTopStories(_stories.length + 10);
      final stories = responses.map((response) {
        final json = jsonDecode(response.body);
        return Story.fromJSON(json);
      }).toList();
      setState(() {
        loadMaisStoriesScroll = false;
        _stories = stories;
      });
    }
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
        appBar: AppBar(
            toolbarHeight: 52,
            elevation: 0,
            title: Text("HN Fschmtz"),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                child: IconButton(
                    icon: Icon(
                      Icons.refresh_outlined,
                      size: 24,
                    ),
                    onPressed: () {

                      setState(() {
                        carregando = true;
                      });

                      _getTopStoriesRefresh();
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
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 700),
          child: carregando
              ? Loading()
              : LazyLoadScrollView(
            onEndOfPage: () => _getMaisTopStories(),
            child: ListView.builder(
              //physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _stories.length,
              itemBuilder: (context, index) {
                return ContainerInkStory(  // teste stateless
                    contador: index,
                    launchBrowser: _launchBrowser,
                    story: new Story(
                      storyId: _stories[index].storyId,
                      title: _stories[index].title,
                      url: _stories[index].url,
                    )
                );

              },
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




