class CatDB {
  late int? id;
  late String name;
  late String breed;
  late String temperament;
  late String origin;
  late String expectedAge;
  late String photoURL;
  late String uuid;

  CatDB(
      {this.id,
      required this.name,
      required this.breed,
      required this.temperament,
      required this.origin,
      required this.expectedAge,
      required this.photoURL,
      required this.uuid});

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'breed': breed,
      'temperament': temperament,
      'origin': origin,
      'expectedAge': expectedAge,
      'photoURL': photoURL,
      'uuid': uuid
    };
  }

  @override
  String toString() {
    return 'Cat{name: $name, breed: $breed, temperament: $temperament, origin: $origin, expectedAge: $expectedAge, photo: $photoURL, uuid: $uuid}';
  }

  CatDB.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    breed = map['breed'];
    temperament = map['temperament'];
    origin = map['origin'];
    expectedAge = map['expectedAge'];
    photoURL = map['photoURL'];
    uuid = map['uuid'];
  }
}
