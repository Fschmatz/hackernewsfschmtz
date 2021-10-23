import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackernewsfschmtz/app.dart';
import 'package:hackernewsfschmtz/util/theme.dart';
import 'package:provider/provider.dart';
import './db/criador_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelperCriadorDB = CriadorDB.instance;
  dbHelperCriadorDB.initDatabase();

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),
    child: Consumer<ThemeNotifier>(
      builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: const App(),
        );
      },
    ),
  ));
}
