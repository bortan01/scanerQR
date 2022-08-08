import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scaner_qr/src/utils/utils.dart';

import '../provider/scan_provider.dart';

class HistoryMapsWidget extends StatelessWidget {
  const HistoryMapsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);
    final scans = scanProvider.scans;
    return scans.isEmpty
        ? const Center(child: Text('No hay posiciones que mostrar'))
        : ListView.builder(
            itemCount: scans.length,
            itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction) =>
                  scanProvider.borrarById(scans[i].id ?? 0),
              child: ListTile(
                leading: const Icon(Icons.map),
                title: Text(scans[i].valor),
                subtitle: Text(scans[i].id.toString()),
                trailing: const Icon(Icons.close),
                onTap: () => launchURL(context, scans[i]),
              ),
            ),
          );
  }
}
