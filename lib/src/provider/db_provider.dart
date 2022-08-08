import 'dart:io';

import 'package:path/path.dart';
import 'package:scaner_qr/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')');
    });
  }

  // CREAR Registros
  Future<int?> nuevoScanRaw(ScanModel nuevoScan) async {
    final db = await database;

    final res = await db?.rawInsert("INSERT Into Scans (id, tipo, valor) "
        "VALUES ( ${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}' )");
    return res;
  }

  Future<int?> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db?.insert('Scans', nuevoScan.toMap());
    // print(nuevoScan.toMap());
    return res;
  }

  // SELECT - Obtener información
  Future<ScanModel?> getScanId(int id) async {
    final db = await database;
    final res = await db?.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res!.isNotEmpty ? ScanModel.fromMap(res.first) : null;
  }

  Future<List<ScanModel>> getTodosScans() async {
    final db = await database;
    final res = await db?.query('Scans');

    if (res == null) {
      return [];
    }

    List<ScanModel> list =
        res.isNotEmpty ? res.map((c) => ScanModel.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    if (db == null) {
      return [];
    }
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");

    List<ScanModel> list =
        res.isNotEmpty ? res.map((c) => ScanModel.fromMap(c)).toList() : [];
    return list;
  }

  // Actualizar Registros
  Future<int?> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db?.update('Scans', nuevoScan.toMap(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  // Eliminar registros
  Future<int?> deleteScan(int id) async {
    final db = await database;
    final res = await db?.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int?> deleteAll() async {
    final db = await database;
    final res = await db?.rawDelete('DELETE FROM Scans');
    return res;
  }
}
