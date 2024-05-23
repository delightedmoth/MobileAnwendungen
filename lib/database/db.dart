import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mobile_anwendungen/main.dart';

class CatDB {
  final String breed;
  final String temperament;
  final String origin;
  final String expectedAge;
  final String photo;

  const CatDB({
    required this.breed,
    required this.temperament,
    required this.origin,
    required this.expectedAge,
    required this.photo,
  });

  Map<String, Object?> toMap() {
    return {
      'breed': breed,
      'temperament': temperament,
      'origin': origin,
      'expectedAge': expectedAge,
      'photo': photo,
    };
  }

  @override
  String toString() {
    return 'Cat{breed: $breed, temperament: $temperament, origin: $origin, expectedAge: $expectedAge, photo: $photo}';
  }
}

Future<void> insertCat(CatDB cat) async {
  final db = await database;

  await db.insert(
    'cats',
    cat.toMap(),
    conflictAlgorith: ConflictAlgorithm.replace,
  );
}
