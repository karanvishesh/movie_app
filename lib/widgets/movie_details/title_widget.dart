import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_details._page.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final MovieDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Text(
        widget.movie.title,
        style: TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
