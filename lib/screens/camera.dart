import 'package:flutter/material.dart';
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
      body: MobileScanner(onDetect: (capture) {}),
    );
  }
}
