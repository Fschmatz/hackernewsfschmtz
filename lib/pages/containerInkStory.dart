import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';
import 'package:share/share.dart';

class ContainerInkStory extends StatelessWidget {
  Story story;
  int contador;
  Function(String) launchBrowser;

  ContainerInkStory({Key key,this.story, this.launchBrowser,this.contador}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (story.url != null){
          launchBrowser(story.url);
        } else {
          // PARA ABRIR COMENTARIOS QUANDO HOUVER UM ASK HN
          launchBrowser('https://news.ycombinator.com/item?id='+story.storyId.toString());
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 12, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(story.title,
                    style: TextStyle(
                      fontSize: 18,
                    )),
                SizedBox(
                  height: 4,
                ),

                //AS VEZES PODE SER NULO
                Visibility(
                  visible: story.url != null,
                  child: Text(story.url.toString(),
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
                child: Text("${1 + contador}",
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
                        Share.share(story.url);
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
                        launchBrowser('https://news.ycombinator.com/item?id='+story.storyId.toString());
                      }),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ],
          ),
          Container(child: Divider(thickness: 1,color: Colors.black38,))
        ],
      ),
    );
  }
}

