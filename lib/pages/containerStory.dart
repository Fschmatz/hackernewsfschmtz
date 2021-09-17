import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/db/lidosDao.dart';
import 'package:hackernewsfschmtz/pages/containerStory/infoWithButtons.dart';
import 'package:hackernewsfschmtz/pages/containerStory/titleWithUrl.dart';
import 'package:url_launcher/url_launcher.dart';

class ContainerStory extends StatefulWidget {
  @override
  _ContainerStoryState createState() => _ContainerStoryState();

  Story story;
  int contador;
  Function() refreshIdLidos;

  ContainerStory({required Key key, required this.story, required this.contador, required this.refreshIdLidos})
      : super(key: key);
}

class _ContainerStoryState extends State<ContainerStory> {
  void _markRead(int idStory) async {
    final dbLidos = lidosDao.instance;
    Map<String, dynamic> row = {
      lidosDao.columnidTopStory: idStory,
    };
    final id = await dbLidos.insert(row);
  }

  //URL LAUNCHER
  _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.story.url != null) {
          _launchBrowser(widget.story.url!);

          //DB
          if (!widget.story.lido!) {
            _markRead(widget.story.storyId!);
            widget.refreshIdLidos();
          }
        } else {
          // IF ASK/SHOW HN
          _launchBrowser('https://news.ycombinator.com/item?id=' +
              widget.story.storyId.toString());

          //DB
          if (!widget.story.lido!) {
            _markRead(widget.story.storyId!);
            widget.refreshIdLidos();
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, widget.contador == 0 ? 5 : 20, 0, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            TitleWithUrl(
              story: widget.story,
              markRead: _markRead,
              refreshIdLidos: widget.refreshIdLidos, key: UniqueKey(),
            ),
            InfoWithButtons(contador: widget.contador,
              story: widget.story,launchBrowser: _launchBrowser, key: UniqueKey(),)
          ],
        ),
      ),
    );
  }
}
