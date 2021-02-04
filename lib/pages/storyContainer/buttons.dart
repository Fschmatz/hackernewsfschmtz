import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:share/share.dart';

class Buttons extends StatelessWidget {

  Story story;
  String timeAgo = " ";
  Function(String) launchBrowser;

  Buttons(
      {Key key,
        this.story,
        this.timeAgo,
        this.launchBrowser,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(timeAgo,
                style: TextStyle(
                    fontSize: 15,
                    color: story.lido ? Theme.of(context).disabledColor :
                    Theme.of(context).hintColor)),
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
                          visible: story.commentsCount != null,
                          maintainState: true,
                          child: story.commentsCount != 0
                              ? Text(story.commentsCount.toString(),
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
                SizedBox(
                  width: 6,
                ),
              ],
            ),
          ]),
    );
  }
}