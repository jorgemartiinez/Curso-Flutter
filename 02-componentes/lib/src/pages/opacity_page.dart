import 'package:flutter/material.dart';

class OpacityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: MiPagina1(),
    );
  }
}

/* SI UTILIZASEMOS UN STLESS WIDGET PODRÍAMOS USAR EL OPACITY NORMAL */

class MiPagina1 extends StatefulWidget {
  const MiPagina1({
    Key key,
  }) : super(key: key);

  @override
  _MiPagina1State createState() => _MiPagina1State();
}

class _MiPagina1State extends State<MiPagina1> {
  double opacidad = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.opacity,
            ),
            onPressed: () {
              setState(() {
                opacidad = (opacidad == 1) ? 0 : 1;
              });
            }),
        body: Container(
          alignment: Alignment.center,
          width: double.infinity, // todo el ancho posible
          height: double.infinity,
          child: Wrap(
            direction: Axis.vertical,
            spacing: 50,
            children: <Widget>[
              Cuadrado(Color(0xff00E057), 1),
              Cuadrado(Color(0xff00BFF4),
                  opacidad), // se mantiene el espacio pero no se ve el widget
              Cuadrado(Color(0xffFEBF2F), 1),
            ],
          ),
        ));
  }
}

class Cuadrado extends StatelessWidget {
  final Color color;
  final double opacity;

  Cuadrado(this.color, this.opacity);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      // el opacity normal es igual pero sin el duration
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      opacity: this.opacity,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(color: this.color),
      ),
    );
  }
}
