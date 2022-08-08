import 'package:flutter/material.dart';
import 'package:scaner_qr/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    final url = Uri.parse(scan.valor);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  } else {
    Navigator.pushNamed(context, 'maps', arguments: scan);
  }
}
