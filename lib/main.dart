import 'package:flutter/material.dart';
import 'package:mobile_anwendungen/api_controller.dart';
import 'package:mobile_anwendungen/screens/cat_detail.dart';
import 'package:mobile_anwendungen/screens/cat_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database/cat_model.dart';
import 'json_parser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'cat_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE cats(id INTEGER PRIMARY KEY, breed TEXT, temperament TEXT, origin TEXT, expectedAge TEXT, photo TEXT)',
      );
    },
    version: 1,
  );

  Future<void> insertCat(CatDB cat) async {
    final db = await database;

    await db.insert(
      'cats',
      cat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: CatList(),
    );
  }
}
