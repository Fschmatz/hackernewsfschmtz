import 'package:flutter/material.dart';
import '../util/app_details.dart';

class ChangelogPage extends StatelessWidget {
  const ChangelogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Changelog"),
        ),
        body: ListView(children: <Widget>[
          ListTile(
              title: Text("Current Version",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary))),
          ListTile(
            leading: const Icon(
              Icons.article_outlined,
            ),
            title: Text(
              AppDetails.changelogCurrent,
            ),
          ),
          ListTile(
            title: Text("Previous Versions",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          ListTile(
            leading: const Icon(
              Icons.article_outlined,
            ),
            title: Text(
              AppDetails.changelogsOld,
            ),
          ),
        ]));
  }
}
