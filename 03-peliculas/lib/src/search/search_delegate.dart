import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculas = [
    'Ad Astra',
    'John Wick',
    'Batman',
    'Transformers',
    'Spiderman',
    'Capitán América'
  ];

  final peliculasRecientes = ['Spiderman', 'Capitán América'];

  final peliculasProvider = new PeliculasProvider();

  String seleccion = ''; // cuando hacemos clic en la sugerencia

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appBar (como la cruz de cancelar en el input del search)
    return [
      IconButton(
        // icono clickable boton
        icon: Icon(Icons.clear),
        onPressed: () {
          print('CLICK!!!!!');
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appBar (como el icono del buscador, o de volver)
    return IconButton(
        icon: AnimatedIcon(
          // boton animado
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context,
              null); // cerramos la pantalla y pasamos argumento, en este caso, ninguno
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
            // con el map creamos una lista de tiles en base a la lista de pelis
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null); // cerramos la búsqueda y vamos a peli detalle
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando la persona escribe

  //   final listaSugerida = (query.isEmpty)
  //       ? peliculasRecientes
  //       : peliculas.where((p) => p.toLowerCase().startsWith(query)).toList();

  //   return ListView.builder(
  //     itemBuilder: (context, int i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: () {
  //           seleccion = listaSugerida[i];
  //           showResults(context);
  //         },
  //       );
  //     },
  //     itemCount: listaSugerida.length,
  //   );
  // }
}
