import 'package:flutter/material.dart';
import 'package:scaner_qr/src/models/scan_model.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(scan.valor),
      ),
    );
  }
}
