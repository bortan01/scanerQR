import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scaner_qr/src/provider/scan_provider.dart';
import 'package:scaner_qr/src/utils/utils.dart';

class FloatingBottonWidget extends StatelessWidget {
  const FloatingBottonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     '#308BEF', "Cancelar", false, ScanMode.QR);
        final scanProvider = Provider.of<ScanProvider>(context, listen: false);

        // const String barcodeScanRes = 'https://twitter.com';
        const String barcodeScanRes =
            'geo:13.647925084424752,-88.87259263551265';
        if (barcodeScanRes == '-1') return;
        final scan = await scanProvider.nuevoScan(barcodeScanRes);
        launchURL(context, scan);
      },
    );
  }
}
