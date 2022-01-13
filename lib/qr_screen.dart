import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key, required this.scNo, required this.name})
      : super(key: key);
  final String scNo;
  final String name;
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr'),
        centerTitle: true,
      ),
      body: Center(
        child: QrImage(
          data: "{name:${widget.name},sicilNo:${widget.scNo}}",
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
