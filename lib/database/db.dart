import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

  WidgetsFlutterBinding.ensureInitialized();
}
