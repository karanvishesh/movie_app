import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_details._page.dart';
class GenresList extends StatelessWidget {
  const GenresList({
    Key? key,
    required this.genres,
  }) : super(key: key);

  final List genres;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: double.infinity,
      child: genres.length == 0
          ? Container()
          : ListView.builder(
              itemCount: genres.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      genres[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
    );
  }
}

