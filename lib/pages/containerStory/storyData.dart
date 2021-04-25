import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:share/share.dart';

class StoryData extends StatelessWidget {
  Story story;
  int contador;
  Function(String) launchBrowser;

  StoryData({Key key, this.story, this.contador,this.launchBrowser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.article_outlined,
                    color: story.lido
                        ? Theme.of(context).accentColor.withOpacity(0.4)
                        : Theme.of(context).accentColor.withOpacity(0.9),
                    size: 16.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Text(" ${1 + contador}    ",
                        style: TextStyle(
                            fontSize: 12.5,
                            color: story.lido
                                ? Theme.of(context).accentColor.withOpacity(0.4)
                                : Theme.of(context).accentColor.withOpacity(0.9))),
                  ),
                  Icon(
                    Icons.arrow_upward_outlined,
                    color: story.lido
                        ? Theme.of(context).accentColor.withOpacity(0.4)
                        : Theme.of(context).accentColor.withOpacity(0.9),
                    size: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Text(" ${story.score} Points",
                        style: TextStyle(
                            fontSize: 12.5,
                            color: story.lido
                                ? Theme.of(context).accentColor.withOpacity(0.4)
                                : Theme.of(context).accentColor.withOpacity(0.9))),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(story.timeAgo,
                  style: TextStyle(
                      fontSize: 13,
                      color: story.lido
                          ? Theme.of(context).disabledColor.withOpacity(0.2)
                          : Theme.of(context).hintColor)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      size: 20,
                      color: story.lido
                          ? Theme.of(context).disabledColor.withOpacity(0.2)
                          : Theme.of(context).hintColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Visibility(
                      visible: story.commentsCount != null,
                      maintainState: true,
                      child: story.commentsCount != 0
                          ? Text(story.commentsCount.toString(),
                          style: TextStyle(
                            fontSize: 14.5,
                            color: story.lido
                                ? Theme.of(context).disabledColor.withOpacity(0.2)
                                : Theme.of(context).hintColor,
                          ))
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
                onPressed: () {
                  launchBrowser('https://news.ycombinator.com/item?id=' +
                      story.storyId.toString());
                }),
            const SizedBox(
              width: 15,
            ),
            Container(
              width: 60,
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.share_outlined,size: 20,color: story.lido
                      ? Theme.of(context).disabledColor.withOpacity(0.2)
                      : Theme.of(context).hintColor,),
                  onPressed: () {
                    if (story.url != null) {
                      Share.share(story.url);
                    } else {
                      // ASK/SHOW HN
                      Share.share('https://news.ycombinator.com/item?id=' +
                          story.storyId.toString());
                    }
                  }),
            ),
            const SizedBox(
              width: 2,
            )
          ],
        ),
      ],
    );
  }
}
