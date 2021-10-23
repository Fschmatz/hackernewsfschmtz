import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackernewsfschmtz/pages/home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Color bottomOverlayColor = Theme.of(context).bottomNavigationBarTheme.backgroundColor!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: bottomOverlayColor,
        ),
        child: const Home()
    );
  }
}
