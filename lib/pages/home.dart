import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/classes/webservice.dart';
import 'package:hackernewsfschmtz/configs/configs.dart';
import 'package:hackernewsfschmtz/pages/containerStory.dart';
import 'package:hackernewsfschmtz/pages/loading.dart';
import 'package:share/share.dart';
import 'package:skeleton_text/skeleton_text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Story> _stories = List<Story>();
  bool carregando = true;
  ScrollController _scrollController = ScrollController();
  bool tapDown1 = false;
  bool tapDown2 = false;
  bool _showAppbar = true;
  bool isScrollingDown = false;
  bool loadMaisStoriesScroll = false;

  @override
  void initState() {
    super.initState();
    _getTopStoriesInicial();

    //scroll noticias
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMaisTopStories();
        loadMaisStoriesScroll = true;
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
      tapDown1 = false;
      tapDown2 = false;
      carregando = false;
      _stories = stories;
    });
  }

  void _getTopStoriesRefresh() async {
    final responses = await Webservice().getTopStories(15);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    setState(() {
      tapDown1 = false;
      tapDown2 = false;
      carregando = false;
      _stories = stories;
      Navigator.of(context).pop();
    });
  }

  void _getTopStoriesNoTapDown(TapDownDetails details) async {
    if (tapDown1 == false) {
      final responses = await Webservice().getTopStories(_stories.length + 15);
      final stories = responses.map((response) {
        final json = jsonDecode(response.body);
        return Story.fromJSON(json);
      }).toList();
      setState(() {
        tapDown1 = true;
        _stories = stories;
      });
    }
    if (tapDown2 == false && _stories.length > 20) {
      final responses = await Webservice().getTopStories(_stories.length + 15);
      final stories = responses.map((response) {
        final json = jsonDecode(response.body);
        return Story.fromJSON(json);
      }).toList();
      setState(() {
        tapDown2 = true;
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
      loadMaisStoriesScroll = false;
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
                padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                child: IconButton(
                    //color: Theme.of(context).hintColor,
                    icon: Icon(
                      Icons.refresh_outlined,
                      size: 24,
                    ),
                    onPressed: () {
                      _getTopStoriesRefresh();
                      _showAlertDialogLoading(context);

                      //scroll to top
                      _scrollController.animateTo(0,
                          duration: Duration(milliseconds: 600),
                          curve: Curves.fastOutSlowIn);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: IconButton(
                    //color: Theme.of(context).hintColor,
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
            ],
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 700),
            child: carregando
                ? Loading()
                : ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black, //.withOpacity(0.7)
                    ),
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: _stories.length,
                    itemBuilder: (context, index) {
                      return ContainerStory(
                          getTopStoriesNoTapDown: _getTopStoriesNoTapDown,
                          contador: index,
                          launchBrowser: _launchBrowser,
                          story: new Story(
                            storyId: _stories[index].storyId,
                            title: _stories[index].title,
                            url: _stories[index].url,
                          ));
                    },
                  ),
          ),
        ),
      ])),

      bottomSheet: loadMaisStoriesScroll ?
      PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: LinearProgressIndicator(
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.3),//Colors.red.withOpacity(0.3),
          //valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
         // value: 0.25,
        ),
      )
       :
        SizedBox.shrink()
    );
  }
}
