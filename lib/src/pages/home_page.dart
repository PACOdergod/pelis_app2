import 'package:flutter/material.dart';

import 'package:pelis_app2/src/providers/peliculas_provider.dart';
import 'package:pelis_app2/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('home page'),
          backgroundColor: Colors.amber,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: null)],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              _swiperTarjetas()
            ],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data[0].title);
          return CardSwiper(
            peliculas: snapshot.data,
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
