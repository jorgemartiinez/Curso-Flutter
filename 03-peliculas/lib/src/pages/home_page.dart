import 'package:flutter/material.dart';
//
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal_widget.dart';

// Página Home, para crear un stateless widget utilizar stless

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares(); // necesitamos añadir información al stream

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(), query: '');
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceAround, // espacio entre los elementos de la column
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
        future: peliculasProvider.getEnCines(), // el future es el getEnCines
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          // devolvemos nuestro widget personalizado

          if (snapshot.hasData) {
            // comprobamos que no esté a null, osea que hayamos recibido los datos
            return CardSwiper(
                peliculas: snapshot.data); // aqui se encuentra la lista
          } else {
            // todavía no tenemos los datos, muestranos un loading
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Widget _footer(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // comienzo de la columna
        children: <Widget>[
          // tema global app
          Container( // container para mover el texto 'Populares'
              margin: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 10.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  // pasamos la función que se ejecutará en el hijo
                  siguientePagina: peliculasProvider.getPopulares);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
  //   peliculasProvider.getEnCines();
}
