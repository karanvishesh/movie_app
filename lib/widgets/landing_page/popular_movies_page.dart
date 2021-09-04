import 'package:flutter/material.dart';
import 'package:movie_app/model/movies.dart';

import 'movie_card.dart';

class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({
    Key? key,
    required this.popularMovies,
  }) : super(key: key);

  final List<Movies> popularMovies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: popularMovies.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: popularMovies.length,
              shrinkWrap: true,
              primary: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 9,
                  childAspectRatio: 0.6,
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
        
                return MovieCard(movie: popularMovies[index]);
              },
            ),
    );
  }
}
