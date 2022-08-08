import 'package:flutter/material.dart';
import 'package:scaner_qr/src/models/scan_model.dart';
import 'package:scaner_qr/src/provider/db_provider.dart';

class ScanProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    if (id == null) null;
    if (tipoSeleccionado == nuevoScan.tipo) {
      nuevoScan.id = id;
      scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  Future<void> cargarScans() async {
    final scansDB = await DBProvider.db.getTodosScans();
    scans = [...scansDB];
    notifyListeners();
  }

  Future<void> cargarScansByType(String tipo) async {
    tipoSeleccionado = tipo;
    final scansDB = await DBProvider.db.getScansPorTipo(tipo);
    scans = [...scansDB];
    notifyListeners();
  }

  Future<void> borrarTodos() async {
    await DBProvider.db.deleteAll();
    scans = [];
    notifyListeners();
  }

  Future<void> borrarById(int id) async {
    await DBProvider.db.deleteScan(id);
    cargarScansByType(tipoSeleccionado);
  }
}
