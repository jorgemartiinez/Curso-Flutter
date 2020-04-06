// Paquetes que no hemos hecho
import 'package:flutter/material.dart';

// Imports nuestros después de estos
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';

// Generamos el main con mateapp
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/', // ruta inicial de nuestra aplicación
      routes: { // esquema de rutas de nuestra aplicación
        '/' : (BuildContext context) => HomePage(),
        'detalle': (context) => PeliculaDetalle()
      }
    );
  }
}
