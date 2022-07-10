import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/classes/story.dart';

class TitleWithUrl extends StatelessWidget {

  Story story;
  Function() refreshIdLidos;

  TitleWithUrl({required Key key, required this.story, required this.refreshIdLidos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(13, 0, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              story.title!,
              style: TextStyle(
                  fontSize: 16,
                  color: story.lido!
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).textTheme.headline6!.color)),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
