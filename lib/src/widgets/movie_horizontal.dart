import 'package:flutter/material.dart';
import 'package:pelis_app2/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({required this.peliculas, required this.siguientePagina});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      //width: _screenSize.width,
      height: _screenSize.height * .25,

      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas(),
        itemCount: peliculas.length,
        itemBuilder: (context, index) => _tarjeta(context, peliculas[index]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 5.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
                fit: BoxFit.cover,
                height: 130.0,
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg())),
          ),
          Text(
            pelicula.title!,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, '/detalle', arguments: pelicula);
      },
    );
  }

  /*
  List<Widget> _tarjetas() {
    return peliculas.map((e) {
      return Container(
        margin: EdgeInsets.only(right: 5.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  height: 130.0,
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(e.getPosterImg())),
            ),
            Text(
              e.title,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }).toList();
  }*/
}
