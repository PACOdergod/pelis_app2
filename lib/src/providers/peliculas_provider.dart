import 'dart:async';
import 'dart:convert';

import 'package:pelis_app2/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apikey = '50ad3ef3075abddf4124aaa0b7d2adb3';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';

  int _popularesPage = 0;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    //print(url);
    final peliculasLista = await _peticion(url);
    //print(peliculasLista);
    return peliculasLista;
  }

  Future<List<Pelicula>> getPopulares() async {
    _popularesPage++;

    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final peliculasLista = await _peticion(url);
    //print(peliculasLista);

    _populares.addAll(peliculasLista);
    popularesSink(_populares);
    return peliculasLista;
  }

  Future<List<Pelicula>> _peticion(url) async {
    final resp = await http.get(url);
    //print(resp.request);
    final decodedData = json.decode(resp.body);
    //print(decodedData['results']);
    final results = decodedData['results'];
    //print(results);
    final peliculas = new Peliculas.fromJsonList(results);
    final peliculasLista = peliculas.items;
    //print(peliculasLista);
    return peliculasLista;
  }
}
