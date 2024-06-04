import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:mobile_anwendungen/database/cat_model.dart';
import 'package:flutter/material.dart';
import 'package:mobile_anwendungen/database/database_helper.dart';
import 'package:mobile_anwendungen/screens/cat_detail.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  String appBarTitle;
  QRCodeScanner(this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    return QRCodeScannerState(appBarTitle);
  }
}

class QRCodeScannerState extends State<QRCodeScanner> {
  String appBarTitle;
  DatabaseHelper helper = DatabaseHelper.getInstance();
  CatDB cat = CatDB(
      name: 'name',
      breed: 'breed',
      temperament: 'temperament',
      origin: 'origin',
      expectedAge: 'expectedAge',
      photoURL: 'photoURL',
      uuid: 'uuid');
  QRCodeScannerState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          appBarTitle,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: MobileScanner(
        controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates, returnImage: true),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          getCat(barcodes.first.rawValue);
          for (final barcode in barcodes) {
            print('Barcode found $barcode.rawValue');
          }

          if (image != null) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(cat.breed),
                    content: Image(
                      image: MemoryImage(image),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            navigateToDetail(cat, 'View/Edit Cat');
                          },
                          child: const Text('Open Cat')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'))
                    ],
                  );
                });
          }
        },
      ),
    );
  }

  void getCat(String? uniqueID) async {
    cat = await helper.getCatfromID(uniqueId: uniqueID);
  }

  void navigateToDetail(CatDB cat, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CatDetail(cat, title);
    }));
  }
}
