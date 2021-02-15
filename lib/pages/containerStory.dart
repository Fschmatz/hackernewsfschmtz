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

class _ContainerStoryState extends State<ContainerStory>{

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
      margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.3),
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
            // PARA ABRIR COMENTARIOS QUANDO HOUVER UM ASK/SHOW HN
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
