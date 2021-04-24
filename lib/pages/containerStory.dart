import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/db/lidosDao.dart';
import 'package:hackernewsfschmtz/pages/containerStory/positionPoints.dart';
import 'package:hackernewsfschmtz/pages/containerStory/storyUrl.dart';
import 'package:hackernewsfschmtz/pages/containerStory/timeButtons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContainerStory extends StatefulWidget {
  @override
  _ContainerStoryState createState() => _ContainerStoryState();

  Story story;
  int contador;
  Function() refreshIdLidos;

  ContainerStory({Key key, this.story, this.contador, this.refreshIdLidos})
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
    return Card(
      color:  widget.story.lido ? Theme.of(context).cardTheme.color.withOpacity(0.7) : Theme.of(context).cardTheme.color,
      margin: widget.contador == 0
          ? const EdgeInsets.fromLTRB(15, 0, 15, 10)
          : const EdgeInsets.fromLTRB(15, 10, 15, 10),
      elevation: widget.story.lido ? 1 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(
          color: widget.story.lido ? Colors.grey[800].withOpacity(0.2) : Colors.grey[850],
          width: 1,
        ),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onTap: () {
          if (widget.story.url != null) {
            _launchBrowser(widget.story.url);

            //DB
            if (!widget.story.lido) {
              _markRead(widget.story.storyId);
              widget.refreshIdLidos();
            }
          } else {
            // IF ASK/SHOW HN
            _launchBrowser('https://news.ycombinator.com/item?id=' +
                widget.story.storyId.toString());

            //DB
            if (!widget.story.lido) {
              _markRead(widget.story.storyId);
              widget.refreshIdLidos();
            }
          }
        },
        child: Column(
          children: [
            StoryUrl(
              story: widget.story,
              markRead: _markRead,
              refreshIdLidos: widget.refreshIdLidos,
            ),
            PositionPoints(
              contador: widget.contador,
              story: widget.story,
            ),
            TimeButtons(
              story: widget.story,
              launchBrowser: _launchBrowser,
            ),
          ],
        ),
      ),
    );
  }
}
