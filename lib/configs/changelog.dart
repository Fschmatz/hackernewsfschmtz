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
        body: ListView(children: <Widget>[
          ListTile(
              leading: SizedBox(
                height: 0.1,
              ),
              title: Text("Current Version".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor))),
          ListTile(
            leading: Icon(
              Icons.article_outlined,
            ),
            title: Text(
              NameChangelog.changelogCurrent,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text("Previous Versions".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor)),
          ),
          ListTile(
            leading: Icon(
              Icons.article_outlined,
            ),
            title: Text(
              NameChangelog.changelogsOld,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ]));
  }
}
