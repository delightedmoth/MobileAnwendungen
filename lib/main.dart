import 'package:flutter/material.dart';
import 'package:mobile_anwendungen/api_controller.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Random Cat App")),
        body: FutureBuilder<List<Cat>>(
            future: ApiProvider().getCats(),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    final catData = data?[index];
                    return Text(catData!.breeds[0].name);
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
