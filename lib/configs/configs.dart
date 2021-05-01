import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/configs/about.dart';
import 'package:hackernewsfschmtz/configs/changelog.dart';
import 'package:hackernewsfschmtz/util/theme.dart';
import '../util/nameChangelog.dart';
import 'package:provider/provider.dart';

class Configs extends StatefulWidget {
  @override
  _ConfigsState createState() => _ConfigsState();

  Configs({Key key}) : super(key: key);
}

class _ConfigsState extends State<Configs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 1,
                margin: const EdgeInsets.fromLTRB(16, 20, 16, 30),
                color: Color(0xFFFF965b),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: ListTile(
                  title: Text(
                    NameChangelog.appName + " " + NameChangelog.appVersion,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17.5, color: Colors.black),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                ),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 17.5),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => About(),
                        fullscreenDialog: true,
                      ));
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.text_snippet_outlined,
                ),
                title: Text(
                  "Changelog",
                  style: TextStyle(fontSize: 17.5),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => Changelog(),
                        fullscreenDialog: true,
                      ));
                },
              ),

              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 5, 0),
                child: Text(
                  "General:",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.7),)
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => SwitchListTile(
                    title: Text(
                      "Dark Theme",
                      style: TextStyle(fontSize: 17.5),
                    ),
                    activeColor: Colors.blue,
                    value: notifier.darkTheme,
                    onChanged: (value) {
                      notifier.toggleTheme();
                    }),
              ),
            ],
          ),
        ));
  }
}
