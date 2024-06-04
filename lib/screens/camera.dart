import 'package:flutter/material.dart';

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
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
