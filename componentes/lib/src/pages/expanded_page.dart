import 'package:flutter/material.dart';

class ExpandedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanded',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Expanded'),
          ),
          body: Row(
            children: <Widget>[
              Cuadrado(Colors.red),
              Expanded(
                flex: 2, // con flex asignas más espacio a un widget de expanded 
                child: Cuadrado(Colors.pink),
              ), // ignora el width y el height y expande el elemento
              Expanded(child: Cuadrado(Colors.green))
            ],
          )),
    );
  }
}

class Cuadrado extends StatelessWidget {
  final Color color;

  Cuadrado(this.color); // constructor corto -> this.color = color

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: this.color,
      ),
    );
  }
}
