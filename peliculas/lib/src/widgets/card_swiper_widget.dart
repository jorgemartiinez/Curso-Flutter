/* WIDGET PERSONALIZADO PARA CREAR UN SWIPER DE TARJETAS */
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart'; // LIBRERÍA SWIPER DE TARJETAS

//
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas; // const array de peliculas

  // constructor con parámetro con nombre, requerido
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    // Utilizamos media query para obtener ancho, alto del dispositivo y poder adaptarnos a la pantalla

    // obtenemos el tamaño entero de la pantalla
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        // queremos que ocupe el 70% del ancho de nuestra pantalla
        itemWidth: _screenSize.width * 0.7,
        // que ocupe la mitad del dispositivo de alto 50%
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          // el item builder hará un bucle en base a itemCount
          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              // bordes redondeados
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () =>
                  Navigator.pushNamed(context, 'detalle',
                      // nos moveremos a la página de detalle pasándole el objeto peli
                      arguments: peliculas[index]),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(peliculas[index]
                      .getPosterImg()), // podemos acceder mediante el index del bucle
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: peliculas.length, // dinamico en base al param pasado
      ),
    );
  }
}
