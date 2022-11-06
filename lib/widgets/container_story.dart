import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:hackernewsfschmtz/db/lidos_dao.dart';
import 'package:hackernewsfschmtz/widgets/info_with_buttons.dart';
import 'package:hackernewsfschmtz/widgets/title_with_url.dart';
import 'package:share/share.dart';
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

  void _markRead() async {
    final dbLidos = LidosDao.instance;
    Map<String, dynamic> row = {
      LidosDao.columnidTopStory: widget.story.storyId!,
    };
    final id = await dbLidos.insert(row);
  }

  //URL LAUNCHER
  _launchBrowser(String url) async {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.story.url != null) {
          _launchBrowser(widget.story.url!);

          //DB
          if (!widget.story.lido!) {
            _markRead();
            widget.refreshIdLidos();
          }
        } else {
          // IF ASK/SHOW HN
          _launchBrowser('https://news.ycombinator.com/item?id=' +
              widget.story.storyId.toString());

          //DB
          if (!widget.story.lido!) {
            _markRead();
            widget.refreshIdLidos();
          }
        }
      },
      onLongPress: () {
        if (widget.story.url != null) {
          Share.share(widget.story.url!);
        } else {
          // ASK/SHOW HN
          Share.share('https://news.ycombinator.com/item?id=' +
              widget.story.storyId.toString());
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 10 ,bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWithUrl(
              story: widget.story,
              refreshIdLidos: widget.refreshIdLidos,
              key: UniqueKey(),
            ),
           InfoWithButtons(contador: widget.contador,
              story: widget.story,
             launchBrowser: _launchBrowser,
             key: UniqueKey(),)
          ],
        ),
      ),
    );
  }
}
