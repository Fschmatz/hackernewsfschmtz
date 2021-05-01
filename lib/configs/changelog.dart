import 'package:flutter/material.dart';
import '../util/nameChangelog.dart';

class Changelog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Changelog"),
          elevation: 0,
        ),
        body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Text("Current Version\n".toUpperCase(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).accentColor)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  NameChangelog.changelogCurrent,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text("Previous Versions\n".toUpperCase(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).accentColor)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  NameChangelog.changelogsOld,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ]));
  }
}
