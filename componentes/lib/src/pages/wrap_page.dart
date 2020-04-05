import 'package:flutter/material.dart';

class WrapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wrap',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
            child: Wrap(
          // hacer que si no caben, vayan a la siguiente linea
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          spacing: 10.0,
          children: <Widget>[
            TagChip('Metal Gear'),
            TagChip('Overwatch'),
            TagChip('Cyberpunk'),
            TagChip('Control'),
            TagChip('Smash Bros'),
            TagChip('Zelda'),
            TagChip('Sekiro'),
          ],
        )),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final String texto;

  TagChip(this.texto);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        child: Text(this.texto[0]),
        backgroundColor: Colors.white,
      ),
      label: Text(
        this.texto,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );
  }
}
