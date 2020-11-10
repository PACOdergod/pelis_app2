import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

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
    return Container(
      width: double.infinity,
      height: 300,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "http://via.placeholder.com/350x150",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        itemWidth: 200.0,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
