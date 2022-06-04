import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:share/share.dart';

class InfoWithButtons extends StatelessWidget {
  Story story;
  int contador;
  Function(String) launchBrowser;

  InfoWithButtons(
      {required Key key,
      required this.story,
      required this.contador,
      required this.launchBrowser})
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
                    size: 15,
                  ),
                  Text(" ${1 + contador}    ",
                      style: TextStyle(
                          fontSize: 12,
                          color: story.lido!
                              ? Theme.of(context).disabledColor.withOpacity(0.2)
                              : Theme.of(context).hintColor.withOpacity(0.6))),
                  Icon(
                    Icons.arrow_upward_outlined,
                    color: story.lido!
                        ? Theme.of(context).disabledColor.withOpacity(0.2)
                        : Theme.of(context).hintColor.withOpacity(0.6),
                    size: 15,
                  ),
                  story.score == 1
                      ? Text(" ${story.score} Point",
                          style: TextStyle(
                              fontSize: 12,
                              color: story.lido!
                                  ? Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.2)
                                  : Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.6)))
                      : Text(" ${story.score} Points",
                          style: TextStyle(
                              fontSize: 12,
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
                    size: 15,
                  ),
                  Text(" " + story.timeAgo,
                      style: TextStyle(
                          fontSize: 12,
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
              height: 38,
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
                      Icons.mode_comment_outlined,
                      size: 20,
                      color: story.lido!
                          ? Theme.of(context).disabledColor.withOpacity(0.2)
                          : Theme.of(context).colorScheme.onSecondary,
                    ),
                    Visibility(
                      visible: story.commentsCount == null,
                      child: const SizedBox(
                        width: 8,
                      ),
                    ),
                    Visibility(
                      visible: story.commentsCount != null,
                      maintainState: true,
                      child: story.commentsCount != 0
                          ? Text('  ' + story.commentsCount.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: story.lido!
                                    ? Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.2)
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                              ))
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).cardTheme.color,
                  onPrimary:
                  Theme.of(context).textTheme.headline6!.color!.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
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
