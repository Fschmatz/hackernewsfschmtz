import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:share/share.dart';

class ContainerStory extends StatefulWidget {

  Story story;
  int contador;
  Function(String) launchBrowser;

  @override
  _ContainerStoryState createState() => _ContainerStoryState();

  ContainerStory({Key key,this.story, this.launchBrowser,this.contador}) : super(key: key);
}

class _ContainerStoryState extends State<ContainerStory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.launchBrowser(widget.story.url);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 8, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(widget.story.title,
                    style: TextStyle(
                      fontSize: 18,
                    )),
                SizedBox(
                  height: 4,
                ),

                //AS VEZES PODE SER NULO
                Visibility(
                  visible: widget.story.url != null,
                  child: Text(widget.story.url.toString(),
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).hintColor)),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                child: Text("${1 + widget.contador}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).accentColor)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      color: Theme.of(context).hintColor,
                      icon: Icon(
                        Icons.share_outlined,
                        size: 20,
                      ),
                      onPressed: () {
                        Share.share(widget.story.url);
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      color: Theme.of(context).hintColor,
                      icon: Icon(
                        Icons.comment_outlined,
                        size: 20,
                      ),
                      onPressed: () {
                        widget.launchBrowser(
                            'https://news.ycombinator.com/item?id=' +
                                widget.story
                                    .storyId
                                    .toString());
                      }),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
