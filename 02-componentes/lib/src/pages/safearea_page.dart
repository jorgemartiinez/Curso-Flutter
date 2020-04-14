import 'package:flutter/material.dart';

/* WIDGET PARA EVITAR QUE EL CONTENIDO INTERFIERA CON EL NOTCH O LA CURVATURA DE LA PANTALLA */

class SafeAreaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(fontSize: 20);
    return MaterialApp(
      title: 'Safe Area',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          bottom: false,
          left: true, // evitamos que se salga la lista por el lado izquierdo de la pantalla
          child: ListView(
            children: List.generate(
              100,
              (index) => Text(
                    '$index - Hola Mundo',
                    style: estilo,
                  )),
        ),
        )
      ),
    );
  }
}
