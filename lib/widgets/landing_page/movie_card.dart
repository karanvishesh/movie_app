import 'package:flutter/material.dart';
import 'package:movie_app/model/movies.dart';
import 'package:movie_app/screens/movie_details._page.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movies movie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  MovieDetailsPage(movie: movie),),);
      },
      child: Column(
        children: [
          Image.network(
            movie.image,
            height: 155,
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
