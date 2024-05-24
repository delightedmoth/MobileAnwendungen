import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mobile_anwendungen/main.dart';

class CatDB {
  final String? name;
  final String breed;
  final String temperament;
  final String origin;
  final String expectedAge;
  final String photo;

  const CatDB({
    this.name,
    required this.breed,
    required this.temperament,
    required this.origin,
    required this.expectedAge,
    required this.photo,
  });

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'breed': breed,
      'temperament': temperament,
      'origin': origin,
      'expectedAge': expectedAge,
      'photo': photo,
    };
  }

  @override
  String toString() {
    return 'Cat{name: $name, breed: $breed, temperament: $temperament, origin: $origin, expectedAge: $expectedAge, photo: $photo}';
  }
}
