import 'cat_model.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  static Database? _database;

  String catTable = 'cat_table';
  String colId = 'id';
  String colName = 'name';
  String colBreed = 'breed';
  String colTemperament = 'temperament';
  String colOrigin = 'origin';
  String colAge = 'expectedAge';
  String colPhotoURL = 'photoURL';
  String colUuid = 'uuid';

  factory DatabaseHelper.getInstance() {
    return _databaseHelper;
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}cat.db';

    var catDatabase = await openDatabase(path, version: 1, onCreate: _createDb);

    return catDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $catTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colBreed TEXT, $colTemperament TEXT, $colOrigin TEXT, $colAge TEXT, $colPhotoURL TEXT, $colUuid TEXT )');
  }

  Future<List<Map<String, dynamic>>> getCatMapList() async {
    Database? db = await database;

    var result = await db!.query(catTable, orderBy: '$colBreed ASC');

    return result;
  }

  Future<int> insertCat(CatDB cat) async {
    Database? db = await database;

    var result = await db!.insert(catTable, cat.toMap());

    return result;
  }

  Future<int> updateCat(CatDB cat) async {
    Database? db = await database;

    var results = await db!.update(catTable, cat.toMap(),
        where: '$colId = ?', whereArgs: [cat.id]);

    return results;
  }

  Future<int> deleteCat(int? id) async {
    Database? db = await database;

    int result =
        await db!.rawDelete('DELETE FROM $catTable WHERE $colId = $id');
    return result;
  }

  Future<int?> getCount() async {
    Database? db = await database;
    List<Map<String, dynamic>> x =
        await db!.rawQuery('SELECT COUNT(*) from $catTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<CatDB>> getCatList() async {
    var catMapList = await getCatMapList();
    int count = catMapList.length;

    List<CatDB> catList = <CatDB>[];

    for (int i = 0; i < count; i++) {
      catList.add(CatDB.fromMapObject(catMapList[i]));
    }

    return catList;
  }

  Future<int?> deleteData() async {
    final db = await database;
    int? result = await db?.delete(catTable);
    return result;
  }
}
