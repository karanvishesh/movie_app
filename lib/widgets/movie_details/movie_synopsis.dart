import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_details._page.dart';

class MovieSynopsis extends StatelessWidget {
  const MovieSynopsis({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final MovieDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(
        widget.movie.synopsis.length == 0 ? "" : widget.movie.synopsis,
        style: TextStyle(color: Colors.white, fontSize: 13.5),
      ),
    );
  }
}
