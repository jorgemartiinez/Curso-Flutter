import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget {
  @override
  /* State createState() {
    return _ContadorPageState();
  } es lo mismo que */

  State createState() => _ContadorPageState();
}

// esta clase solo se usará dentro de este archivo
class _ContadorPageState extends State<ContadorPage> {
  // variables
  final TextStyle _estiloTexto = new TextStyle(fontSize: 30.0);
  int _conteo = 0;
  // override build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Stateful'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              'Número de taps:',
              style: _estiloTexto,
            ),
            Text(
              '$_conteo',
              style: _estiloTexto,
            ),
          ])),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _crearBotones(),
    );
  }

  Widget _crearBotones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 30.0),
        FloatingActionButton(
            child: Icon(Icons.add),
            onPressed:
                _agregar // se pone sin paréntesis para que la llame cuando se pulse el botón
            ),
        Expanded(
          child: SizedBox(
            width: 10.0,
          ),
        ),
        FloatingActionButton(
          child: Icon(Icons.remove),
          onPressed: _sustraer,
        ),
        SizedBox(
          width: 10.0,
        ),
        FloatingActionButton(
          child: Icon(Icons.exposure_zero),
          onPressed: _reset,
        ),
      ],
    );
  }

  void _agregar() {
    setState(() {
      // actualizar la variable en pantalla
      _conteo++;
    });
  }

  void _sustraer() {
    setState(() => _conteo--); // actualizar la variable en pantalla
  }

  void _reset() {
    setState(() => _conteo = 0);
  }
}
