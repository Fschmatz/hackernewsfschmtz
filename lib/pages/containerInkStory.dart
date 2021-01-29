import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ContainerInkStory extends StatelessWidget {
  Story story;
  int contador;
  Function(String) launchBrowser;

  ContainerInkStory({Key key, this.story, this.launchBrowser, this.contador})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    String timeAgo = timeago.format(DateTime.fromMillisecondsSinceEpoch(story.time * 1000));

    return InkWell(
      onTap: () {
        if (story.url != null) {
          launchBrowser(story.url);
        } else {
          // PARA ABRIR COMENTARIOS QUANDO HOUVER UM ASK HN
          launchBrowser('https://news.ycombinator.com/item?id=' +
              story.storyId.toString());
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 12, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: "${1 + contador}. ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).accentColor)),
                      TextSpan(
                          text: story.title,
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  .color)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                //AS VEZES PODE SER NULO
                Visibility(
                  visible: story.url != null,
                  child: Text(story.url.toString(),
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 12, color: Theme.of(context).hintColor)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_upward_outlined,
                      color: Theme.of(context).accentColor,
                      size: 18,
                    ),
                    Text(" ${story.score} Points",
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).accentColor)),
                    SizedBox(width: 15),
                    Text(timeAgo,
                        style: TextStyle(
                            fontSize: 16, color: Theme.of(context).hintColor)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                              visible: story.commentsCount != null,
                              child: Text(story.commentsCount.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).hintColor,
                                  )),
                            ),
                          ],
                        ),
                        onPressed: () {
                          launchBrowser(
                              'https://news.ycombinator.com/item?id=' +
                                  story.storyId.toString());
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
                          Share.share(story.url);
                        }),
                    /*SizedBox(
                      width: 15,
                    ),*/
                  ],
                ),
              ),
            ],
          ),
          Container(
              child: Divider(
            thickness: 1,
            color: Colors.black38,
          ))
        ],
      ),
    );
  }
}
