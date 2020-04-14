import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';

/* CLASE SINGLETON PARA MANEJAR EL BLOC DE LA APP */

class ScansBloc {
  // constructor privado inicializar clase
  static final ScansBloc _singleton = new ScansBloc._internal();

  // cuando llamemos a la clase haciendo variable = new ScansBloc, llamaremos al factory,
  // que retornará una instancia del factory
  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    // Obtener scans de la bd y añadir al stream
    obtenerScans();
  }

  // STREAMS (SERÍA MEJOR INICIALIZAR TODAS LAS VARIABLE ARRIBA)

  // stream controller que emitirá en forma de broadcast a todos y fluirá una lista de scans
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  // getter para escuchar la info del stream
  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  // IMPORTANTE, MÉTODO PARA CERRAR STREAM
  void dispose() {
    _scansController?.close();
  }

  // EVENTS BLOC
  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getAllScans());
  }

  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id); // borramos el scan
    obtenerScans(); // volvemos a añadir la info de la bd
  }

  borrarScanTODOS() async {
    await DBProvider.db.deleteAll(); // borramos todos
    // para actualizar el stream tenemos dos formas ya que está vacío
    //_scansController.sink.add([]);
    obtenerScans();
  }
}
