import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_anwendungen/database/cat_model.dart';
import 'package:mobile_anwendungen/database/database_helper.dart';

class CatDetail extends StatefulWidget {
  String appBarTitle;
  final CatDB cat;
  CatDetail(this.cat, this.appBarTitle);
  @override
  State<StatefulWidget> createState() => CatDetailState(cat, appBarTitle);
}

class CatDetailState extends State<CatDetail> {
  DatabaseHelper helper = DatabaseHelper.getInstance();

  String appBarTitle;
  CatDB cat;

  String photoURL = 'https://cdn2.thecatapi.com/images/8D--jCd21.jpg';
  TextEditingController nameController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController temperamentController = TextEditingController();
  TextEditingController originController = TextEditingController();
  TextEditingController expectedAgeController = TextEditingController();

  CatDetailState(this.cat, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    nameController.text = cat.name;
    breedController.text = cat.breed;
    temperamentController.text = cat.temperament;
    originController.text = cat.origin;
    expectedAgeController.text = cat.expectedAge;
    photoURL = cat.photoURL;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          appBarTitle,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Image(
              image: NetworkImage(photoURL),
              alignment: Alignment.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: nameController,
                style: textStyle,
                onChanged: (value) {
                  updateName();
                },
                decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: breedController,
                style: textStyle,
                onChanged: (value) {
                  updateBreed();
                },
                decoration: InputDecoration(
                    labelText: 'Breed',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: temperamentController,
                style: textStyle,
                onChanged: (value) {
                  updateTemperament();
                },
                decoration: InputDecoration(
                    labelText: 'Temperament',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: originController,
                style: textStyle,
                onChanged: (value) {
                  updateOrigin();
                },
                decoration: InputDecoration(
                    labelText: 'Origin',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: expectedAgeController,
                style: textStyle,
                onChanged: (value) {
                  updateExpectedAge();
                },
                decoration: InputDecoration(
                    labelText: 'Expected Age',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            //Padding(
            //   padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            //   child: Text(cat.uuid),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: BarcodeWidget(data: cat.uuid, barcode: Barcode.qrCode()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      _save();
                    },
                    child: const Text('Save'),
                  )),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      _delete();
                    },
                    child: const Text('Delete'),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateName() {
    cat.name = nameController.text;
  }

  void updateBreed() {
    cat.breed = breedController.text;
  }

  void updateTemperament() {
    cat.temperament = temperamentController.text;
  }

  void updateOrigin() {
    cat.origin = originController.text;
  }

  void updateExpectedAge() {
    cat.expectedAge = expectedAgeController.text;
  }

  void _save() async {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);

    int result;

    if (cat.id != null) {
      result = await helper.updateCat(cat);
    } else {
      result = await helper.insertCat(cat);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Cat Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Cat');
    }
  }

  void _delete() async {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);

    if (cat.id == null) {
      _showAlertDialog('Status', 'Cats not in Database cant be deleted');
      return;
    }

    int result = await helper.deleteCat(cat.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Cat Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
