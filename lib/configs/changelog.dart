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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: ListView(children: <Widget>[
            ListTile(
              dense: true,
              title: Text(
                  "Current Version".toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor)
              ),
            ),
            ListTile(
              title: Text(
                NameChangelog.changelogCurrent,
                style: TextStyle(fontSize: 17),
              ),
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text(
                  "Previous Versions".toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor)
              ),
            ),
            ListTile(
              title: Text(
                NameChangelog.changelogsOld,
                style: TextStyle(fontSize: 17),
              ),
            ),


          ]),
        ));
  }
}
