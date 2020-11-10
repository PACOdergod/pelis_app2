import 'package:flutter/material.dart';
import 'package:pelis_app2/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
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
    return CardSwiper(peliculas: [1, 2, 3]);
  }
}
