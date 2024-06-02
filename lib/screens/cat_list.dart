import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_anwendungen/database/cat_model.dart';
import 'package:mobile_anwendungen/database/database_helper.dart';
import 'package:mobile_anwendungen/screens/cat_detail.dart';
import 'package:mobile_anwendungen/screens/nav_bar.dart';
import 'package:sqflite/sqflite.dart';

int count = 4;

class CatList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CatListState();
  }
}

class CatListState extends State<CatList> {
  DatabaseHelper databaseHelper = DatabaseHelper.getInstance();
  List<CatDB> catList = <CatDB>[];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    updateListView();

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text(
          'Random Cat App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: getCatListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(
              CatDB(
                  name: ' ',
                  breed: ' ',
                  temperament: ' ',
                  origin: ' ',
                  expectedAge: ' ',
                  photoURL: 'https://cdn2.thecatapi.com/images/8D--jCd21.jpg'),
              'Add Cat');
        },
        tooltip: 'Add Cat',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getCatListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.headlineMedium;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: const Color.fromARGB(255, 248, 246, 255),
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              backgroundImage: NetworkImage(catList[position].photoURL),
            ),
            title: Text(
              catList[position].breed,
              style: titleStyle,
            ),
            subtitle: Text(catList[position].origin),
            trailing: GestureDetector(
              child: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, catList[position]);
              },
            ),
            onTap: () {
              debugPrint('ListTile tapped');
              navigateToDetail(catList[position], 'View/Edit Cat Details');
            },
          ),
        );
      },
    );
  }

  void _delete(
    BuildContext context,
    CatDB cat,
  ) async {
    int? result = await databaseHelper.deleteCat(cat.id);
    if (result != 0) {
      _showSnackBar(context, 'Cat Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(CatDB cat, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CatDetail(cat, title);
    }));
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<CatDB>> catListFuture = databaseHelper.getCatList();
      catListFuture.then((catList) {
        setState(() {
          this.catList = catList;
          count = catList.length;
        });
      });
    });
  }
}
