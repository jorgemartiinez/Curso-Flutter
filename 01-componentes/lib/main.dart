import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// import 'package:componentes/src/pages/home_temp.dart';
import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      initialRoute: '/',
      routes: getAplicationRoutes(), // rutas de la aplicación
      onGenerateRoute: (RouteSettings settings) {
        print('Ruta llamada: ${settings.name} ');
        return MaterialPageRoute(builder: (context) => AlertPage());
      },
      // LOCALIZACIÓN
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', 'ES'),
        const Locale('es', 'US'),
      ],
    );
  }
}
