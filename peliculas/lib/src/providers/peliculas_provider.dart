import 'dart:async';
import 'dart:convert';
// alias, si no se harían directamente las petis con get() en vez de http.get como es ahora con el alias
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';

// mis paquetes
import 'package:peliculas/src/models/pelicula_model.dart';

/* SERVICIO QUE SERVIRÁ PARA REALIZAR LLAMADAS A LA API de THEMOVIEDB */
class PeliculasProvider {
  String _apiKey = '1900a894a2b23989b3fdf14c8be64e5b';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;

  List<Pelicula> _populares = new List();
  bool _cargando = false;

  // stream en el que va a fluir una lisa de películas
  // si no se pone el broadcast es de single suscription, solo tendría un listener
  final _popularesStreamController =
      new StreamController<List<Pelicula>>.broadcast();

  // sintaxis getters en dart
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add; // añadir info al stream

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  // es necesario un método para cerrar el stream para que no haya multiples instancias
  void disposeStreams() {
    _popularesStreamController.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    // esta primera vendrá con datos como el status, codigos de error, etc
    final resp = await http.get(url);
    // obtenemos el valor de la respuesta, hay que hacer decode
    final decodedData = json.decode(
        resp.body); // obtenemos el valor de la respuesta, hay que hacer decode
    final peliculas = new Peliculas.fromJsonList(
        decodedData['results']); // generamos las peliculas

    return peliculas.items; // devolvemos las peliculas
  }

  // este método regresa un future que hace la peticion al api y retorna las peliculas
  Future<List<Pelicula>> getEnCines() async {
    // en otros lenguajes creariamos la url con un string, pero en dart ya tenemos un método llamado
    // uri que sirve para generar la url
    // 1º pasamos la url
    // 2º El endpoint
    // 3º Pasamos un mapa con los parámetros de la query que vendrían después del ?

    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await _procesarRespuesta(url); // metodo centralizado
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return []; // si estoy cargando datos no seguir
    _cargando = true; // si no, empezamos a cargar los datos

    _popularesPage++; // sumamos 1 a la página

    final url = Uri.http(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = await _procesarRespuesta(url);
    _populares.addAll(
        resp); // añadimos toda la lista con AddAll añadimos varias en forma de iterable
    popularesSink(_populares);

    _cargando = false; // ya hemos cargado
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    // recibimos el id de la peli para obtener los actores de la Api

    final url = Uri.https(_url, '/3/movie/$peliId/credits',
        {'api_key': _apiKey, 'language': _language});

    final resp = await http.get(url);
    final decodedData = await jsonDecode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    return await _procesarRespuesta(url); // metodo centralizado
  }
}
