import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_mobil/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrScreen extends StatefulWidget {
  const QrScreen(
      {Key? key, required this.scNo, required this.name, required this.sirket})
      : super(key: key);
  final String scNo;
  final String name;
  final String sirket;
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Qr'),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
              icon: const Icon(Icons.delete))
        ],
        centerTitle: true,
      ),
      body: Center(
        child: QrImage(
          backgroundColor: Colors.white,
          data:
              '{"sicilismi":"${widget.name}","sicilkodu":"${widget.scNo}","sirketkodu": "$widget.sirket"}',
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
