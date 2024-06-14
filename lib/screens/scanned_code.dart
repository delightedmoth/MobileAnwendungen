import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_anwendungen/database/cat_model.dart';
import 'package:mobile_anwendungen/database/database_helper.dart';
import 'package:mobile_anwendungen/screens/cat_detail.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannedCode extends StatefulWidget {
  final List<Barcode> barcodes;
  final Uint8List? image;
  ScannedCode(this.barcodes, this.image);
  @override
  State<ScannedCode> createState() => _ScannedCode(this.barcodes, this.image);
}

class _ScannedCode extends State<ScannedCode> {
  final List<Barcode> barcodes;
  final Uint8List? image;
  DatabaseHelper helper = DatabaseHelper.getInstance();
  CatDB cat = CatDB(
      name: 'name',
      breed: 'breed',
      temperament: 'temperament',
      origin: 'origin',
      expectedAge: 'expectedAge',
      photoURL: 'photoURL',
      uuid: 'uuid');

  _ScannedCode(this.barcodes, this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Scanned Code Details',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: FutureBuilder(
              future: getCat(barcodes.first.rawValue),
              builder: (BuildContext context, AsyncSnapshot<CatDB> snapshot) {
                List<Widget> children;
                if (snapshot.hasData &&
                    image != null &&
                    cat.photoURL != 'ERROR') {
                  children = <Widget>[
                    Image.memory(image!),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(cat.breed),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            navigateToDetail(cat, 'View/Edit Details');
                          },
                          child: const Text(
                            'Open Details',
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Return',
                          ),
                        ))
                  ];
                } else if ((snapshot.hasError && image != null) ||
                    (snapshot.hasData &&
                        image != null &&
                        cat.photoURL == 'ERROR')) {
                  children = <Widget>[
                    Image.memory(image!),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Error: Not a cat code or cat not in database',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Return',
                          ),
                        ))
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Awaiting result...',
                      ),
                    ),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              }),
        ));
  }

  Future<CatDB> getCat(String? uniqueID) async {
    cat = await helper.getCatfromID(uniqueId: uniqueID);
    return cat;
  }

  void navigateToDetail(CatDB cat, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CatDetail(cat, title);
    }));
  }
}
