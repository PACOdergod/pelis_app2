import 'package:flutter/material.dart';
import 'package:pelis_app2/src/pages/home_page.dart';
import 'package:pelis_app2/src/pages/pelicula_detalle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'peliculas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/detalle': (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}
