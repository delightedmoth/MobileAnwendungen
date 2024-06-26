import 'package:flutter/material.dart';
import 'package:mobile_anwendungen/api_controller.dart';
import 'package:mobile_anwendungen/database/cat_model.dart';
import 'package:mobile_anwendungen/database/database_helper.dart';
import 'package:mobile_anwendungen/json_parser.dart';
import 'package:uuid/uuid.dart';

class NavBar extends StatelessWidget {
  DatabaseHelper helper = DatabaseHelper.getInstance();
  ApiProvider catGetter = ApiProvider();
  List<Cat> onlineCatList = <Cat>[];
  int count = 0;
  late CatDB cat;
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/NavBarCat.png"),
                  fit: BoxFit.cover),
            ),
            child: Text('Settings'),
          ),
          ListTile(
            title: const Text('Fill Database'),
            onTap: () {
              _addOnlineCats();
            },
          ),
          ListTile(
            title: const Text('Dump Database'),
            onTap: () {
              _deleteAllCats();
            },
          )
        ],
      ),
    );
  }

  void _addOnlineCats() async {
    onlineCatList = await catGetter.getCats();
    count = onlineCatList.length;

    for (int i = 0; i < count; i++) {
      cat = CatDB(
          name: ' ',
          breed: onlineCatList[i].breeds[0].name,
          temperament: onlineCatList[i].breeds[0].temperament,
          origin: onlineCatList[i].breeds[0].origin,
          expectedAge: onlineCatList[i].breeds[0].lifeSpan,
          photoURL: onlineCatList[i].url,
          uuid: uuid.v4().toString());

      await helper.insertCat(cat);
    }
  }

  void _deleteAllCats() async {
    await helper.deleteData();
  }
}
