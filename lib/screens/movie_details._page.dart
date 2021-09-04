import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/model/casts.dart';
import 'package:movie_app/model/movies.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/widgets/movie_details/book_tickets_button.dart';
import 'package:movie_app/widgets/movie_details/genre_list.dart';
import 'package:movie_app/widgets/movie_details/movie_synopsis.dart';
import 'package:movie_app/widgets/movie_details/overlay_gradient.dart';
import 'package:movie_app/widgets/movie_details/title_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage({required this.movie});
  final Movies movie;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  findYear() {
    var year = "";
    for (int i = 0; i < 4; i++) {
      year += widget.movie.release_date[i];
    }
    return year;
  }

  String movieGenre = "";

  List genres = [];
  Future getMovieDetails() async {
    Uri uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/${widget.movie.id}?api_key=67dc45fcc0ae1e2c2810cbcad8f97d8d&language=en-US');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var genre in data["genres"]) {
        setState(() {
          genres.add(genre["name"]);
          movieGenre = movieGenre + genre["name"] + ", ";
        });
        widget.movie.synopsis = data["overview"];
      }
      widget.movie.budget = data["budget"];
      widget.movie.original_title = data["original_title"];
      widget.movie.premier = data["release_date"];
      widget.movie.runtime = data["runtime"];
      widget.movie.status = data["status"];
      widget.movie.revenue = data["revenue"];
      widget.movie.homepage = data["homepage"];
      widget.movie.genres = movieGenre;
    }
  }

  List<Casts> castList = [];

  Future getCast() async {
    Uri uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/${widget.movie.id}/credits?api_key=67dc45fcc0ae1e2c2810cbcad8f97d8d&language=en-US');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var details in data["cast"]) {
        if (details["known_for_department"] == "Acting") {
          setState(() {
            castList.add(Casts(
                name: details["name"],
                image:
                    "https://image.tmdb.org/t/p/w500${details['profile_path']}",
                character: details["character"]));
          });
        }
      }
    }
  }

  List<Movies> similarMovies = [];
  Future getSimilarMovies() async {
    Uri uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/${widget.movie.id}/similar?api_key=67dc45fcc0ae1e2c2810cbcad8f97d8d&language=en-US&page=1');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var movie in data["results"]) {
        setState(() {
          similarMovies.add(Movies(
              title: movie["title"],
              id: movie["id"],
              rating: movie["vote_average"],
              release_date: movie["release_date"],
              image: "https://image.tmdb.org/t/p/w500${movie['poster_path']}"));
        });
      }
    }
  }

  @override
  void initState() {
    getMovieDetails();
    getCast();
    getSimilarMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBodyColor,
      body: SlidingUpPanel(
          minHeight: 400,
          maxHeight: MediaQuery.of(context).size.height,
          color: kBodyColor,
          panel: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cast",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                castList.length == 0
                    ? CircularProgressIndicator()
                    : CastSWidget(castList: castList),
                Text(
                  'About',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Table(
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            "Original Title:",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.67),
                                fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            widget.movie.original_title,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            "Status:",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.67),
                                fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            widget.movie.status,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            "Runtime:",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.67),
                                fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            "${widget.movie.runtime.toString()}m",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            "Type:",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.67),
                                fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            widget.movie.genres,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            "Premier:",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.67),
                                fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            widget.movie.release_date,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            "Budget:",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.67),
                                fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            "\$ ${widget.movie.budget.toString()}",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            "Revenue:",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.67),
                                fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            "\$ ${widget.movie.revenue.toString()}",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        widget.movie.homepage == ""
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: Text(
                                  "HomePage:",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.67),
                                      fontSize: 15),
                                ),
                              ),
                        widget.movie.homepage == ""
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: Text(
                                  widget.movie.homepage,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Similar Movies',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SimilarMoviesWidget(similarMovies: similarMovies)
              ],
            ),
          ),
          body: Center(
            child: Stack(
              children: [
                Container(
                  height: 470,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.movie.image,
                          ),
                          fit: BoxFit.cover)),
                ),
                OverlayGradient(),
                Container(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                findYear(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(32)),
                              child: Text(
                                widget.movie.rating.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TitleWidget(widget: widget),
                        SizedBox(
                          height: 10,
                        ),
                        GenresList(genres: genres),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Synopsis",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        MovieSynopsis(
                          widget: widget,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomBackButton(),
                Positioned(right: 0, top: 20, child: BookTicketButton(
                  movieTitle:widget.movie.title
                ))
              ],
            ),
          )),
    );
  }
}

class CastSWidget extends StatelessWidget {
  const CastSWidget({
    Key? key,
    required this.castList,
  }) : super(key: key);

  final List<Casts> castList;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 210,
        child: ListView.builder(
            itemCount: castList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      castList[index].image,
                      errorBuilder: (context, _, __) {
                        return Container();
                      },
                      height: 140,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      castList[index].name,
                      style: TextStyle(
                          color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: Text(castList[index].character,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12)),
                    ),
                  ],
                ),
              );
            }),
      );
  }
}

class SimilarMoviesWidget extends StatelessWidget {
  const SimilarMoviesWidget({
    Key? key,
    required this.similarMovies,
  }) : super(key: key);

  final List<Movies> similarMovies;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          itemCount: similarMovies.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.network(
                similarMovies[index].image,
                errorBuilder: (context, _, __) {
                  return Container();
                },
              ),
            );
          }),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 25,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
