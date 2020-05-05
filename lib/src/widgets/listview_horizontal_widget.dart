import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class ListViewHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;

  ListViewHorizontal({ @required this.peliculas });
  
  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;
    

    return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: 170.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _listaPeliculas(),
          ),
        );
    /*
    
    Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
          itemBuilder: (BuildContext context,int index){
            return  ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(peliculas[index].getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ),              
            );
          },
          itemCount: peliculas.length,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          layout: SwiperLayout.STACK,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        ),
    );
    */


  }


  List<Widget> _listaPeliculas(){
    List<Widget> lista = new List<Widget>();

    for(var peli in peliculas){
      lista.add(
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(peli.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),              
              ),
        )
        
      );
    }

    return lista;
  }
}