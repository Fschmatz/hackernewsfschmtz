import 'package:flutter/material.dart';
import 'package:hackernewsfschmtz/pages/home.dart';
import 'package:hackernewsfschmtz/util/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //notifier usado para o tema
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),

    child: Consumer<ThemeNotifier>(
      builder:(context, ThemeNotifier notifier, child){

        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: Home(),
        );
      },
    ),
  )
  );
}


