import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';

class StoryUrl extends StatelessWidget {
  Story story;
  Function(String) launchBrowser;
  Function(int) markRead;
  Function() refreshIdLidos;

  StoryUrl(
      {Key key,
        this.story,
        this.launchBrowser,
        this.markRead,
        this.refreshIdLidos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      onTap: () {
        if (story.url != null) {
          launchBrowser(story.url);

          //DB
          if (!story.lido) {
            markRead(story.storyId);
            refreshIdLidos();
          }
        } else {
          // PARA ABRIR COMENTARIOS QUANDO HOUVER UM ASK HN
          launchBrowser('https://news.ycombinator.com/item?id=' +
              story.storyId.toString());

          //DB
          if (!story.lido) {
            markRead(story.storyId);
            refreshIdLidos();
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(story.title,
                  style: TextStyle(
                      fontSize: 17.6,
                      color: story.lido
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).textTheme.headline6.color)),

              const SizedBox(
                height: 8,
              ),

              //AS VEZES PODE SER NULO
              Visibility(
                visible: story.url != null,
                child: Text(story.url.toString(),
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 12,
                        color: story.lido
                            ? Theme.of(context).disabledColor
                            : Theme.of(context).hintColor)),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
    );
  }
}



