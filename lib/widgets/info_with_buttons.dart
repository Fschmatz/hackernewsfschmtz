import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:share/share.dart';

class InfoWithButtons extends StatelessWidget {
  Story story;
  int contador;
  Function(String) launchBrowser;

  InfoWithButtons({required Key key, required this.story, required this.contador, required this.launchBrowser})
      : super(key: key);

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
                    color: story.lido!
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  Text(" ${1 + contador}    ",
                      style: TextStyle(
                          fontSize: 13,
                          color: story.lido!
                              ? Theme.of(context).disabledColor.withOpacity(0.2)
                              : Theme.of(context).hintColor.withOpacity(0.6))),
                  Icon(
                    Icons.arrow_upward_outlined,
                    color: story.lido!
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  story.score == 1
                      ? Text(" ${story.score} Point",
                          style: TextStyle(
                              fontSize: 13,
                              color: story.lido!
                                  ? Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.2)
                                  : Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.6)))
                      : Text(" ${story.score} Points",
                          style: TextStyle(
                              fontSize: 13,
                              color: story.lido!
                                  ? Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.2)
                                  : Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.6))),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: story.lido!
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 16,
                  ),
                  Text(" " + story.timeAgo,
                      style: TextStyle(
                          fontSize: 13,
                          color: story.lido!
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
            SizedBox(
              width: story.commentsCount == 0
                  ? 50
                  : story.commentsCount!.toDouble() > 99
                      ? (story.commentsCount!.toDouble() > 999 ? 95 : 85)
                      : 75,
              height: 40,
              child: TextButton(
                onLongPress: () {
                  Share.share('https://news.ycombinator.com/item?id=' +
                      story.storyId.toString());
                },
                onPressed: () {
                  launchBrowser('https://news.ycombinator.com/item?id=' +
                      story.storyId.toString());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      size: 21,
                      color: story.lido!
                          ? Theme.of(context).disabledColor.withOpacity(0.2)
                          : Theme.of(context)
                              .textTheme
                              .headline6!
                              .color!
                              .withOpacity(0.7),
                    ),
                    Visibility(
                      visible: story.commentsCount == null,
                      child: const SizedBox(
                        width: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                      child: Visibility(
                        visible: story.commentsCount != null,
                        maintainState: true,
                        child: story.commentsCount != 0
                            ? Text('  ' + story.commentsCount.toString(),
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: story.lido!
                                      ? Theme.of(context)
                                          .disabledColor
                                          .withOpacity(0.2)
                                      : Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .color!
                                          .withOpacity(0.7),
                                ))
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).cardTheme.color,
                  onPrimary: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 50,
              height: 40,
              child: TextButton(
                onPressed: () {
                  if (story.url != null) {
                    Share.share(story.url!);
                  } else {
                    // ASK/SHOW HN
                    Share.share('https://news.ycombinator.com/item?id=' +
                        story.storyId.toString());
                  }
                },
                child: Icon(
                  Icons.share_outlined,
                  size: 21,
                  color: story.lido!
                      ? Theme.of(context).disabledColor.withOpacity(0.2)
                      : Theme.of(context)
                          .textTheme
                          .headline6!
                          .color!
                          .withOpacity(0.7),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).cardTheme.color,
                  onPrimary: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
      ],
    );
  }
}
