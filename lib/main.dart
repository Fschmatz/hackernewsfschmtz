import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/app.dart';
import 'package:hackernewsfschmtz/util/theme.dart';
import './db/criador_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelperCriadorDB = CriadorDB.instance;
  dbHelperCriadorDB.initDatabase();

  runApp(
    EasyDynamicThemeWidget(
      child: const StartAppTheme(),
    ),
  );
}

class StartAppTheme extends StatelessWidget {
  const StartAppTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: light,
      darkTheme: dark,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: const App(),
    );
  }
}
