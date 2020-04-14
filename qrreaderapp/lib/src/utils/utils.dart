import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//
import 'package:qrreaderapp/src/models/scan_model.dart';

Future<void> abrirScanNavegador(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    // comprobamos que el scan sea un url para abrirlo en el nav o no
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'Could not launch ${scan.valor}';
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
