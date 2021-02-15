import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';

class PositionPoints extends StatelessWidget {
  Story story;
  int contador;

  PositionPoints({Key key, this.story, this.contador}) : super(key: key);

  //anterior 18 15 18 15
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.text_snippet_outlined, //article
                color: story.lido
                    ? Theme.of(context).accentColor.withOpacity(0.5)
                    : Theme.of(context).accentColor,
                size: 18,
              ),
              Text(" ${1 + contador}    ",
                  style: TextStyle(
                      fontSize: 15,
                      color: story.lido
                          ? Theme.of(context).accentColor.withOpacity(0.5)
                          : Theme.of(context).accentColor)),
              Icon(
                Icons.arrow_upward_outlined,
                color: story.lido
                    ? Theme.of(context).accentColor.withOpacity(0.5)
                    : Theme.of(context).accentColor,
                size: 18,
              ),
              Text(" ${story.score} Points",
                  style: TextStyle(
                      fontSize: 15,
                      color: story.lido
                          ? Theme.of(context).accentColor.withOpacity(0.5)
                          : Theme.of(context).accentColor)),
            ],
          ),
        ),
      ],
    );
  }
}

//Theme.of(context).accentColor
