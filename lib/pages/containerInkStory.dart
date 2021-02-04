import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/pages/storyContainer/buttons.dart';
import 'package:hackernewsfschmtz/pages/storyContainer/pointsPosition.dart';
import 'package:hackernewsfschmtz/pages/storyContainer/storyContainer.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:hackernewsfschmtz/db/lidosDao.dart';


class ContainerInkStory extends StatefulWidget {
  @override
  _ContainerInkStoryState createState() => _ContainerInkStoryState();

  Story story;
  int contador;
  Function() refreshLidos;

  ContainerInkStory(
      {Key key,
        this.story,
        this.contador,
        this.refreshLidos})
      : super(key: key);
}

class _ContainerInkStoryState extends State<ContainerInkStory> {

  final dbLidos = lidosDao.instance;
  String timeAgo = " ";

  void _markRead(int idStory) async {
    final dbLidos = lidosDao.instance;
    Map<String, dynamic> row = {
      lidosDao.columnidTopStory: idStory,
    };
    final id = await dbLidos.insert(row);
    print("id->  $id");
  }

  @override
  void initState() {
    timeAgo =
    timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.story.time * 1000));
    super.initState();
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


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.story.url != null) {
          _launchBrowser(widget.story.url);

          //DB
          if(!widget.story.lido){
            _markRead(widget.story.storyId);
            widget.refreshLidos();
          }
        } else {

          // PARA ABRIR COMENTARIOS QUANDO HOUVER UM ASK HN
          _launchBrowser('https://news.ycombinator.com/item?id=' +
              widget.story.storyId.toString());

          //DB
          if(!widget.story.lido){
            _markRead(widget.story.storyId);
            widget.refreshLidos();
          }
        }
      },
      child: Column(
        children: [
          StoryContainer(story: widget.story),

          SizedBox(
            height: 17,
          ),

          Column(
            children: [
              PointsPosition(contador: widget.contador,story: widget.story,),

              Buttons(timeAgo: timeAgo,story: widget.story,launchBrowser: _launchBrowser,)
            ],
          ),
        ],
      ),
    );

  }
}
