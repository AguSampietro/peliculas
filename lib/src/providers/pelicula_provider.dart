import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:http/http.dart' as http;

class PeliculasProvider {

  String _apiKey = '344c42154ebcee7d766d9330628a839f';
  String _url = 'api.themoviedb.org';
  String _lenguage = 'es-ES';

  bool _cargando = false;

  int _popularesPage = 0;
  
  List<Pelicula> _populares = List();
  
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularStream => _popularesStreamController.stream;

  void disposeStream(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {

    // obtiene el String de la respuesta
    final resp = await http.get(url);
    // decodifica el string en el JSON
    final decodedData = json.decode(resp.body);
    // carga la lista de peliculas en una lista
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;

  }



  Future<List<Pelicula>> getEnCines() async {

    // arma el URL para llamar la API
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key': _apiKey,
      'language': _lenguage
    });

    return await _procesarRespuesta(url);

  }


  Future<List<Pelicula>> getPopulares() async {


    if(_cargando) return [];

    _cargando = true;

    print("Cargando peliculas...");


    _popularesPage++;

    // arma el URL para llamar la API
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key': _apiKey,
      'language': _lenguage,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);
    
    _populares.addAll(resp);

    popularSink(_populares);

    _cargando = false;

    return resp;

  }




  Future<List<Actor>> getCast(String peliId) async {

    // arma el URL para llamar la API
    final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key': _apiKey,
      'language': _lenguage
    });

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

     final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;

  }


 Future<List<Pelicula>> buscarPelicula(String query) async {

    // arma el URL para llamar la API
    final url = Uri.https(_url, '3/search/movie',{
      'api_key': _apiKey,
      'language': _lenguage,
      'query': query
    });

    return await _procesarRespuesta(url);

  }

}