import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';

class TitleWithUrl extends StatelessWidget {
  Story story;
  Function(int) markRead;
  Function() refreshIdLidos;

  TitleWithUrl({Key key, this.story, this.markRead, this.refreshIdLidos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedUrl = " ";

    if(story.url != null) {
      formattedUrl = Uri
          .parse(story.url)
          .host;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(13, 0, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(story.title,
              style: TextStyle(
                  fontSize: 16,
                  color: story.lido
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).textTheme.headline6.color)),

          const SizedBox(
            height: 10,
          ),

          //Can be null
          Visibility(
            visible: story.url != null,
            child: Text(formattedUrl,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 12.5,
                    color: story.lido
                        ? Theme.of(context).accentColor.withOpacity(0.3)
                        : Theme.of(context).accentColor.withOpacity(0.9))),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
