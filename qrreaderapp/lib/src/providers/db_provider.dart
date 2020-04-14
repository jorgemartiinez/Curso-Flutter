import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
//
import 'package:qrreaderapp/src/models/scan_model.dart';
// exponer el modelo a los archivos que llamen a dbProvider
export 'package:qrreaderapp/src/models/scan_model.dart';

/* Clase SINGLETON que se encargará de realizar operaciones con la base de datos */

class DBProvider {
  static Database _database; // instancia de la base de datos
  static final DBProvider db =
      DBProvider._(); // llamada a nuestro constructor privado

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      // existe la db, solo tenemos que devolverla
      return _database;
    }

    // no existe la db, creemosla

    _database = await initDB();

    return _database;
  }

  initDB() async {
    // obtener el path de la base de datos en el dispositivo
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // path completo de la base de datos
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path,
        version: 1, // incrementar la versión cuando haya cambios en la db
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      // aqui dentro la base de datos ya está lista
      await db.execute('CREATE TABLE SCANS ('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')');
    });
  }

  // * CREAR REGISTROS, DOS FORMAS
  nuevoScanRaw(ScanModel nuevoScan) async {
    // comprobamos que la db esté lista llamando al get database de arriba
    final db = await database;

    final res = await db.rawInsert(
        "INSERT INTO SCANS (id, tipo, valor) " // ! OJO CON LOS ESPACIOS AQUÍ!
        "VALUES ( ${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}' )" // ! PONER LOS STRING ENTRE COMILLAS
        );

    return res;
  }

  nuevoScan(ScanModel nuevoScan) async {
    // comprobamos que la db esté lista llamando al get database
    final db = await database;

    // a esta función le pasamos dos parámetros, la tabla y el map con los valores
    final res = await db.insert('SCANS', nuevoScan.toJson());

    return res;
  }

  // * SELECT - OBTENER INFORMACIÓN

  Future<ScanModel> getScanById(int id) async {
    final db = await database;

    // realizamos la query, utilizamos ? para indicar que vamos a recibir ese arg
    // y lo indicamos en whereArgs
    final res = await db.query('SCANS', where: 'id = ?', whereArgs: [id]);

    // en res recibiremos un mapa con los datos, deberemos de comprobar si está vacío
    // si no lo está, devolveremos un scan model con el objeto
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  // ahora queremos todos los scan models, devolveremos un future que contenga la lista
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;

    final res = await db.query('SCANS'); // los devuelve todos

    // necesitamos una lista, entonces, si no está vacia la res, lo que haremos es
    // mediante el map generaremos una lista de ScanModels, llamando mediante el iterable
    // al constructor fromJson del modelo

    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : []; // devuelve un listado vacío

    return list;
  }

  // obtener scans por tipo
  Future<List<ScanModel>> getAllScansByType(String tipo) async {
    final db = await database;

    final res = await db.query('SCANS',
        where: 'tipo = ?', whereArgs: [tipo]); // los devuelve todos

    // necesitamos una lista, entonces, si no está vacia la res, lo que haremos es
    // mediante el map generaremos una lista de ScanModels, llamando mediante el iterable
    // al constructor fromJson del modelo

    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : []; // devuelve un listado vacío

    return list;
  }

  // * ACTUALIZAR REGISTROS

  // devuelve 1 ó 0 si lo hizo bien o mal
  Future<int> updateScan(ScanModel updatedScan) async {
    final db = await database;

    final res = await db.update('SCANS', updatedScan.toJson(),
        where: 'id = ?', whereArgs: [updatedScan.id]);

    return res;
  }

  // * BORRAR REGISTROS

  Future<int> deleteScan(int id) async {
    final db = await database;

    // ! OJO ESPECIFICAR SIEMPRE EL ID!
    final res = await db.delete('SCANS', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM SCANS');

    return res;
  }
}
