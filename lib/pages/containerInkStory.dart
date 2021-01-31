import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
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
          Container(
            padding: EdgeInsets.fromLTRB(18, 12, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(widget.story.title,
                    style: TextStyle(
                        fontSize: 17,
                        color: widget.story.lido ? Theme.of(context).disabledColor :
                        Theme.of(context).textTheme.headline6.color
                    )),

                SizedBox(
                  height: 8,
                ),

                //AS VEZES PODE SER NULO
                Visibility(
                  visible: widget.story.url != null,
                  child: Text(widget.story.url.toString(),
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 12,
                          color: widget.story.lido ? Theme.of(context).disabledColor :
                          Theme.of(context).hintColor)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 17,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.text_snippet_outlined, //article
                          color: Theme.of(context).accentColor,
                          size: 18,
                        ),
                        Text(" ${1 + widget.contador}    ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).accentColor)),
                        Icon(
                          Icons.arrow_upward_outlined,
                          color: Theme.of(context).accentColor,
                          size: 18,
                        ),
                        Text(" ${widget.story.score} Points",
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).accentColor)),
                      ],
                    ),
                  ),
                ],
              ),

              //SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(timeAgo,
                          style: TextStyle(
                              fontSize: 15,
                              color: widget.story.lido ? Theme.of(context).disabledColor :
                              Theme.of(context).textTheme.headline6.color)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.comment_outlined,
                                    size: 20,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Visibility(
                                    visible: widget.story.commentsCount != null,
                                    maintainState: true,
                                    child: widget.story.commentsCount != 0
                                        ? Text(widget.story.commentsCount.toString(),
                                        style: TextStyle(
                                          fontSize: 15.2,
                                          color:
                                          Theme.of(context).hintColor,
                                        ))
                                        : SizedBox.shrink(),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                _launchBrowser(
                                    'https://news.ycombinator.com/item?id=' +
                                        widget.story.storyId.toString());
                              }),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minWidth: 0,
                              child: Icon(
                                Icons.share_outlined,
                                size: 20,
                                color: Theme.of(context).hintColor,
                              ),
                              onPressed: () {
                                Share.share(widget.story.url);
                              }),
                          SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                    ]),
              )
            ],
          ),
        ],
      ),
    );

  }
}
