import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';

class StoryContainer extends StatelessWidget {

  Story story;

  StoryContainer(
      {Key key,
        this.story})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(18, 12, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Text(story.title,
              style: TextStyle(
                  fontSize: 17,
                  color: story.lido ? Theme.of(context).disabledColor :
                  Theme.of(context).textTheme.headline6.color
              )),

          SizedBox(
            height: 8,
          ),

          //AS VEZES PODE SER NULO
          Visibility(
            visible: story.url != null,
            child: Text(story.url.toString(),
                maxLines: 2,
                style: TextStyle(
                    fontSize: 12,
                    color: story.lido ? Theme.of(context).disabledColor :
                    Theme.of(context).hintColor)),
          ),
        ],
      ),
    );
  }
}
