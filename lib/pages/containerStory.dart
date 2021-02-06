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
    return Column(
      children: [
        StoryUrl(
          story: widget.story,
          launchBrowser: _launchBrowser,
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
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
