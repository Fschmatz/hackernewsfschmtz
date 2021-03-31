import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';

class StoryUrl extends StatelessWidget {
  Story story;
  Function(int) markRead;
  Function() refreshIdLidos;

  StoryUrl(
      {Key key,
        this.story,
        this.markRead,
        this.refreshIdLidos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 14, 18, 0), //(18, 12, 18, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(story.title,
                style: TextStyle(
                    fontSize: 16.5,
                    color: story.lido
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).textTheme.headline6.color)),

            const SizedBox(
              height: 10,
            ),

            //AS VEZES PODE SER NULO
            Visibility(
              visible: story.url != null,
              child: Text(story.url.toString(),
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 12.5,
                      color: story.lido
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).hintColor)),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      );
  }
}



