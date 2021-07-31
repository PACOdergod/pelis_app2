import 'package:flutter/material.dart';
import 'package:pelis_app2/src/models/pelicula_model.dart';
import 'package:pelis_app2/src/providers/peliculas_provider.dart';
import 'package:pelis_app2/src/widgets/card_swiper_widget.dart';
import 'package:pelis_app2/src/widgets/movie_horizontal.dart';
import 'package:pelis_app2/src/search/search_delegate.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
        appBar: AppBar(
          title: Text('PelisPaco'),
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: DataSearch(),
                  );
                })
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _swiperTarjetas(), 
              _footer(context)
            ],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data[0].title);
          //peliculasProvider.getCast(snapshot.data[0].id.toString());
          return CardSwiper(
            peliculas: snapshot.data!,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _footer(context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Populares',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              //print(snapshot.data[1].title);
              //snapshot.data.forEach((e) => print(e.title));
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data!,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
