import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  final opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco', 'Seis'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: ListView(
        children: _crearItemsCorta(),
      ),
    );
  }

  List<Widget> _crearItems() {
    List<Widget> list = new List<Widget>();

    for (String opt in opciones) {
      final tempWidget = ListTile(
        title: Text(opt),
      );

      list
        ..add(
          tempWidget,
        )
        ..add(
          Divider(),
        );
      // ES LO MISMO QUE ESTAS DOS LÍNEAS list.add(tempWidget);
      // list.add(Divider());
    }

    return list;
  }

  List<Widget> _crearItemsCorta() {
    var widgets = opciones.map((String opt) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(opt + '!'),
            subtitle: Text('un subtitulo'),
            leading: Icon(Icons.person),
            trailing: Icon(Icons.arrow_right),
            onTap: () {}, // al ponerlo hará el efecto al clicar
          ),
          Divider()
        ],
      );
    }).toList();
    return widgets;
  }
}
