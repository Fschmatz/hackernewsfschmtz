import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import './db/db_creator.dart';
import 'app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelperCriadorDB = DBCreator.instance;
  dbHelperCriadorDB.initDatabase();

  runApp(
    EasyDynamicThemeWidget(
      child: const AppTheme(),
    ),
  );
}

