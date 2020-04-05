import 'package:flutter/material.dart';

//
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function
      siguientePagina; // pasamos un callback del padre para añadir la siguiente página al stream

  // queremos saber cuando estamos al final del pageview para cargar las siguientes peliculas
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3, // muestra 3 imagenes y un poco de la 4ta
  );

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      // si la posicion del pageview en pixeles es mayor o igual a la posición final de su scroll menos 200
      // entonces carga las nuevas peliculas
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        this.siguientePagina();
      }
    });

    return Container(
      height: screenSize.height * 0.30,
      child: PageView.builder(
        // el pageview muestra de 1 en 1 en horizontal, creamos un controller para que aparezcan varias
        controller: _pageController,
        // función que, a diferencia del pageview normal, le pasaremos las tarjetas una a una mediante el page builder a medida que el usuario vaya haciendo scroll, mejorando así el rendimiento de la app
        itemBuilder: (BuildContext context, int index) =>
            _unaTarjeta(context, peliculas[index]),
        itemCount: peliculas.length,
      ),
    );
  }

  Widget _unaTarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-poster';

    final tarjetaPelicula = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow
                .ellipsis, // cuando no quepa el texto añade al final los ...
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    // devolvemos un gesture detector para detectar gestos
    return GestureDetector(
      onTap: () {
        print('Título de la película ${pelicula.title}');
        Navigator.pushNamed(context, 'detalle',
            arguments:
                pelicula); // nos moveremos a la página de detalle pasándole el objeto peli
      },
      child: tarjetaPelicula,
    );
  }

  /* List<Widget> _tarjetas(context) {
    // devuelve una lista que puede transformarse en un iterable de widgets
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow
                  .ellipsis, // cuando no quepa el texto añade al final los ...
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  } */
}
