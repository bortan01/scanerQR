import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scaner_qr/src/utils/utils.dart';

import '../provider/scan_provider.dart';

class DirectionsWidget extends StatelessWidget {
  const DirectionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("redibujando");
    final scanProvider = Provider.of<ScanProvider>(context);
    final scans = scanProvider.scans;
    return scans.isEmpty
        ? const Center(child: Text('No hay direcciones que mostrar'))
        : ListView.builder(
            itemCount: scans.length,
            itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction) =>
                  scanProvider.borrarById(scans[i].id ?? 0),
              child: ListTile(
                leading: const Icon(Icons.home_outlined),
                title: Text(scans[i].valor),
                subtitle: Text(scans[i].id.toString()),
                trailing: const Icon(Icons.close),
                onTap: () => launchURL(context, scans[i]),
              ),
            ),
          );
  }
}
