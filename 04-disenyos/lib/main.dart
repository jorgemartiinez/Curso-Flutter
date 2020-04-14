import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//
import 'package:disenyos/src/pages/basico_page.dart';
import 'package:disenyos/src/pages/scroll_page.dart';
import 'package:disenyos/src/pages/botones_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // barra status color transparente
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños',
      initialRoute: 'botones',
      routes: {
        'basico': (BuildContext context) => BasicoPage(),
        'scroll': (BuildContext context) => ScrollPage(),
        'botones': (context) => BotonesPage(),
      },
    );
  }
}
