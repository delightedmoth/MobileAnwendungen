import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mobile_anwendungen/main.dart';

class CatDB {
  final int id;
  final String? name;
  final String breed;
  final String temperament;
  final String origin;
  final String expectedAge;
  final String? photoURL;

  const CatDB({
    required this.id,
    this.name,
    required this.breed,
    required this.temperament,
    required this.origin,
    required this.expectedAge,
    this.photoURL,
  });

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'breed': breed,
      'temperament': temperament,
      'origin': origin,
      'expectedAge': expectedAge,
      'photo': photoURL,
    };
  }

  @override
  String toString() {
    return 'Cat{name: $name, breed: $breed, temperament: $temperament, origin: $origin, expectedAge: $expectedAge, photo: $photoURL}';
  }
}
