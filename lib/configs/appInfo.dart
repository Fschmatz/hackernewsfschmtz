import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/nameChangelog.dart';

class AppInfo extends StatelessWidget {

  _launchGithub() async {
    const url = 'https://github.com/Fschmatz/hackernewsfschmtz';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App Info"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.green,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/avatar.jpg'),
              ),
            ),
            const SizedBox(height: 15),
            Text(NameChangelog.appName,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor)),
            const SizedBox(height: 15),
            const Divider(),
            ListTile(
              leading: SizedBox(
                height: 0.1,
              ),
              title: Text("Dev".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor)),
            ),
            ListTile(
              leading: Icon(Icons.perm_device_info_outlined),
              title: Text(
                "HAMMERED AND REDONE: 0 Times !!!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              leading: SizedBox(
                height: 0.1,
              ),
              title: Text(
                "( This is The Way! )",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              leading: SizedBox(
                height: 0.1,
              ),
              title: Text(
                "Application created using Flutter and the Dart language, used for testing and learning.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: SizedBox(
                height: 0.1,
              ),
              title: Text("Github".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor)),
            ),
            ListTile(
              onTap: () {_launchGithub();},
              leading: Icon(Icons.open_in_browser_outlined),
              title: Text("https://github.com/Fschmatz/hackernewsfschmtz",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue)),
            ),
            const Divider(),
            ListTile(
              leading: SizedBox(
                height: 0.1,
              ),
              title: Text("Quote".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor)),
            ),
            ListTile(
              leading: Icon(Icons.messenger_outline_outlined),
              title: Text(
                "Software Engineering is a learning process, working code a side effect.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ]),
        ));
  }
}
