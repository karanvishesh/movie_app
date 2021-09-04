import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_details._page.dart';
class OverlayGradient extends StatelessWidget {
  const OverlayGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 470.0,
      decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.black.withOpacity(0.9),
              ],
              stops: [
                0,
                4
              ])),
    );
  }
}
