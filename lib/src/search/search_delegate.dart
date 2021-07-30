import 'package:flutter/material.dart';
import 'package:pelis_app2/src/models/pelicula_model.dart';
import 'package:pelis_app2/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculas = ['Zootopia', 'Bob Esponja', 'After', 'Enola', 'Batman'];
  final peliculasRecientes = ['mulan', 'frozen'];
  final peliculasProvider = new PeliculasProvider();
  
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuetro appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que mostrar
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // las sugerencias que aparecen cuando las personas escriben

    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((p) {
              return ListTile(
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, '/detalle', arguments: p);
                },
                leading: FadeInImage(
                    fit: BoxFit.cover,
                    width: 50.0,
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(p.getPosterImg())),
                title: Text(p.title),
                subtitle: Text(p.originalTitle),
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
