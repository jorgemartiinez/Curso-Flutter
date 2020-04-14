import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }) {
    if (valor.contains('http')) {
      // si contiene http es una página web
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  // Un factory crea una nueva instancia
  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  // Retorna un objeto en formato JSON a partir del modelo
  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };

  // retorna la latitud y la longitud del scan
  LatLng getLatLng() {

    final lalo = valor.substring(4).split(','); // devuelve los dos valores lat y long
    final lat = double.parse(lalo[0]); // los convertimos a double
    final lng = double.parse(lalo[1]);

    return LatLng(lat, lng);
  }
}
