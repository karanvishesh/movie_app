import 'package:flutter/material.dart';
import 'package:movie_app/model/movies.dart';
import 'package:movie_app/widgets/landing_page/movie_card.dart';

class TopRatedMoviesPage extends StatelessWidget {
  const TopRatedMoviesPage({
    Key? key,
    required this.topRatedMovies,
  }) : super(key: key);

  final List<Movies> topRatedMovies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: topRatedMovies.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: topRatedMovies.length,
              shrinkWrap: true,
              primary: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 9,
                  childAspectRatio: 0.58,
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return MovieCard(movie: topRatedMovies[index]);
              },
            ),
    );
  }
}
