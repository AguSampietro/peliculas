import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';

class DataSearch extends SearchDelegate {

  final peliculasProvider = new PeliculasProvider();
  

  final peliculas = [
    'Spiderman',
    'Harry Potter',
    'Batman',
    'Shazam',
    'Aquaman',
    'Ironman',
    'Capitan America'
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan America'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //  acciones de AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query = '';
        }
      ),

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //  Icono a la izquierda del AppBar
    return IconButton(
      icon:AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //  crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //  son las sugerencias que aparecen cuando la persona escribe

    if(query.isEmpty){
      return Container();
    }else{
      return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          
          if(snapshot.hasData){

            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map((pelicula){
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'), 
                    image: NetworkImage(pelicula.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text( pelicula.originalTitle),
                  onTap: (){
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, '/detalle',arguments: pelicula);
                  },
                );
              }).toList(),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        },
      );
    }

  }


  /*
  
  @override
  Widget buildSuggestions(BuildContext context) {
    //  son las sugerencias que aparecen cuando la persona escribe

    final listaSugerida = (query.isEmpty ) 
                          ? peliculasRecientes 
                          : peliculas.where( 
                            (p)=> p.toLowerCase().startsWith(query.toLowerCase())
                          ).toList();

    return ListView.builder(
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){
             
          },
        );
      },
      itemCount: listaSugerida.length,
    );

  }

   */

}