import 'package:flutter/material.dart';

// Imports páginas
import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/pages/avatar_page.dart';
import 'package:componentes/src/pages/home_page.dart';
import 'package:componentes/src/pages/card_page.dart';
import 'package:componentes/src/pages/animated_container.dart';
import 'package:componentes/src/pages/input_page.dart';
import 'package:componentes/src/pages/slider_page.dart';
import 'package:componentes/src/pages/listview_page.dart';
import 'package:componentes/src/pages/safearea_page.dart';
import 'package:componentes/src/pages/expanded_page.dart';
import 'package:componentes/src/pages/wrap_page.dart';
import 'package:componentes/src/pages/opacity_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => HomePage(),
    'alert': (context) => AlertPage(),
    'avatar': (context) => AvatarPage(),
    'card': (context) => CardPage(),
    'animatedContainer': (context) => AnimatedContainerPage(),
    'inputs': (context) => InputPage(),
    'sliders': (context) => SliderPage(),
    'list': (context) => ListaPage(),
    'safeArea': (context) => SafeAreaPage(),
    'expanded': (context) => ExpandedPage(),
    'wrap': (context) => WrapPage(),
    'opacity': (context) => OpacityPage()
  };
}
