import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // para permitir el scroll y tener en cuenta el notch, también podemos usar un listView
        child: Column(
          children: <Widget>[
            _crearImagen(),
            _crearTitulo(),
            _crearAcciones(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
          ],
        ),
      ),
    );
  }

  Widget _crearImagen() {
    return Container(
      width: double.infinity,
      child: Image(
        image: NetworkImage(
            'https://images.theconversation.com/files/125391/original/image-20160606-13080-s7o3qu.jpg?ixlib=rb-1.1.0&rect=273%2C0%2C2639%2C1379&q=45&auto=format&w=926&fit=clip'),
          height: 300.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        // se envuelve el row en el container para añadir espaciado
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              // expandir el texto y el icono de la columna tomando todo el espacio horizontal
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Paisaje con un lago', style: estiloTitulo),
                  SizedBox(height: 7.0),
                  Text('Lago en Suecia', style: estiloSubtitulo)
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.red,
              size: 30.0,
            ),
            Text('41', style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment
          .spaceEvenly, // en el row el main afecta en horizontal y el crossAxis en vertical, en vertical es al reves
      children: <Widget>[
        _accion(Icons.call, 'CALL'),
        _accion(Icons.near_me, 'ROUTE'),
        _accion(Icons.share, 'SHARE')
      ],
    );
  }

  Widget _accion(IconData icon, String text) {
    // crea la columna con un icono y texto debajo
    return Column(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.blue,
          size: 40.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 15.0, color: Colors.blue),
        ),
      ],
    );
  }

  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        // decoration: BoxDecoration(border: Border.all()),
        child: Text(
          'Duis vel auctor ante. Aenean sed risus sit amet quam posuere rutrum. Integer rutrum libero ligula, quis iaculis ligula commodo id. Integer ut metus libero. Phasellus laoreet justo neque, ac convallis sem cursus non. Morbi sodales, ligula nec finibus condimentum, sapien nibh porta sem, et tincidunt leo metus rhoncus nisi. Proin et est ut risus bibendum varius.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
