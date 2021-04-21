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
          padding: const EdgeInsets.all(17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 1,
                margin: const EdgeInsets.all(2.0),
                color: Color(0xFFFF965b),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ListTile(
                  title: Text(
                    "Flutter " +
                        NameChangelog.appName +
                        " " +
                        NameChangelog.appVersion,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                    color: Colors.grey[800].withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  leading: Icon(Icons.text_snippet_outlined),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(
                    "About",
                    style: TextStyle(fontSize: 18),
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
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                    color: Colors.grey[800].withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  leading: Icon(Icons.text_snippet_outlined),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(
                    "Changelog",
                    style: TextStyle(fontSize: 18),
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
              ),
              const SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  "Options: ",
                  style: TextStyle(fontSize: 19),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                title: Text(
                  "Dark Theme",
                  style: TextStyle(fontSize: 17.5),
                ),
                trailing: Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => Switch(
                      activeColor: Colors.blue,
                      value: notifier.darkTheme,
                      onChanged: (value) {
                        notifier.toggleTheme();
                      }),
                ),
              ),

            ],
          ),
        ));
  }
}
