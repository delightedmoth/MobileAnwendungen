class CatDB {
  late int? id;
  late String name;
  late String breed;
  late String temperament;
  late String origin;
  late String expectedAge;
  late String photoURL;

  CatDB({
    this.id,
    required this.name,
    required this.breed,
    required this.temperament,
    required this.origin,
    required this.expectedAge,
    required this.photoURL,
  });

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'breed': breed,
      'temperament': temperament,
      'origin': origin,
      'expectedAge': expectedAge,
      'photoURL': photoURL,
    };
  }

  @override
  String toString() {
    return 'Cat{name: $name, breed: $breed, temperament: $temperament, origin: $origin, expectedAge: $expectedAge, photo: $photoURL}';
  }

  CatDB.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    breed = map['breed'];
    temperament = map['temperament'];
    origin = map['origin'];
    expectedAge = map['expectedAge'];
    photoURL = map['photoURL'];
  }
}
