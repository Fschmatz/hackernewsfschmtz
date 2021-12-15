import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/configs/app_info_page.dart';
import 'package:hackernewsfschmtz/configs/changelog_page.dart';
import 'package:hackernewsfschmtz/util/theme.dart';
import '../util/changelog.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

  SettingsPage({required Key key}) : super(key: key);
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 1,
                margin: const EdgeInsets.fromLTRB(16, 20, 16, 25),
                color: const Color(0xFFFF965b),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: ListTile(
                  title: Text(
                    Changelog.appName + " " + Changelog.appVersion,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 17.5, color: Colors.black),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const SizedBox(
                  height: 0.1,
                ),
                title: Text("About".toUpperCase(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary)),
              ),
              ListTile(
                leading: const Icon(
                  Icons.info_outline,
                ),
                title: const Text(
                  "App Info",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const AppInfoPage(),
                        fullscreenDialog: true,
                      ));
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: const Icon(
                  Icons.article_outlined,
                ),
                title: const Text(
                  "Changelog",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const ChangelogPage(),
                        fullscreenDialog: true,
                      ));
                },
              ),
              const Divider(),
              ListTile(
                leading: const SizedBox(
                  height: 0.1,
                ),
                title: Text("General".toUpperCase(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary)),
              ),
              Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => SwitchListTile(
                    title: const Text(
                      "Dark Theme",
                      style: TextStyle(fontSize: 16),
                    ),
                    secondary: const Icon(Icons.brightness_6_outlined),
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
