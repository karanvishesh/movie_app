import 'package:flutter/material.dart';
import 'package:movie_app/model/movies.dart';
import 'package:movie_app/widgets/landing_page/movie_card.dart';

class UpcomingMoviesPage extends StatelessWidget {
  const UpcomingMoviesPage({
    Key? key,
    required this.upcomingMovies,
  }) : super(key: key);
  final List<Movies> upcomingMovies;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: upcomingMovies.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: upcomingMovies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 9,
                  childAspectRatio: 0.58,
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return MovieCard(movie: upcomingMovies[index]);
              },
            ),
    );
  }
}

