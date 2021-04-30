import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:share/share.dart';

class InfoWithButtons extends StatelessWidget {
  Story story;
  int contador;
  Function(String) launchBrowser;

  InfoWithButtons({Key key, this.story, this.contador,this.launchBrowser}) : super(key: key);

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
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  Text(" ${1 + contador}   ",
                      style: TextStyle(
                          fontSize: 13,
                          color: story.lido
                              ? Theme.of(context).disabledColor.withOpacity(0.2)
                              : Theme.of(context).hintColor.withOpacity(0.6))),
                  Icon(
                    Icons.arrow_upward_outlined,
                    color: story.lido
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  Text(" ${story.score} Points",
                      style: TextStyle(
                          fontSize: 13,
                          color: story.lido
                              ? Theme.of(context).disabledColor.withOpacity(0.2)
                              : Theme.of(context).hintColor.withOpacity(0.6))),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: story.lido
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  Text(" "+story.timeAgo,
                      style: TextStyle(
                          fontSize: 13,
                          color: story.lido
                              ? Theme.of(context).disabledColor.withOpacity(0.2)
                              : Theme.of(context).hintColor.withOpacity(0.6))),
                ],
              ),
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
                      size: 21,
                      color: story.lido
                          ? Theme.of(context).disabledColor.withOpacity(0.2)
                          : Theme.of(context).textTheme.headline6.color.withOpacity(0.7),
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
                                : Theme.of(context).textTheme.headline6.color.withOpacity(0.7),
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
              width: 54,
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.share_outlined,size: 21,color: story.lido
                      ? Theme.of(context).disabledColor.withOpacity(0.2)
                      : Theme.of(context).textTheme.headline6.color.withOpacity(0.7),),
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

          ],
        ),
      ],
    );
  }
}

