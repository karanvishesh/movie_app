import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/movies.dart';
import 'package:movie_app/widgets/landing_page/movie_card.dart';
import 'package:movie_app/widgets/landing_page/popular_movies_page.dart';
import 'package:movie_app/widgets/landing_page/toprated_movies_page.dart';
import 'package:movie_app/widgets/landing_page/upcoming_movies_page.dart';
class TabPage extends StatefulWidget {
  const TabPage({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);
  final TabController _tabController;
  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  List<Movies> popularMovies = [];
  List<Movies> topRatedMovies = [];
  List<Movies> upcomingMovies = [];
  Future getPopularMovieData() async {
    Uri uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=67dc45fcc0ae1e2c2810cbcad8f97d8d&language=en-US&page=1');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var movie in data["results"]) {
        setState(() {
          popularMovies.add(Movies(
              title: movie["title"],
              id: movie["id"],
       
               rating : movie["vote_average"],
              release_date: movie["release_date"],
              image: "https://image.tmdb.org/t/p/w500${movie['poster_path']}"));
        });
      }
    }
  }
  Future getTopRatedMovieData() async {
    Uri uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=67dc45fcc0ae1e2c2810cbcad8f97d8d&language=en-US&page=1');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var movie in data["results"]) {
        setState(() {
          topRatedMovies.add(Movies(
              title: movie["title"],
               id: movie["id"],
                rating :  movie["vote_average"],
              release_date: movie["release_date"],
              image: "https://image.tmdb.org/t/p/w500${movie['poster_path']}"));
        });
      }
    }
  }
  Future getUpcomimgMovieData() async {
    Uri uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=67dc45fcc0ae1e2c2810cbcad8f97d8d&language=en-US&page=1');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var movie in data["results"]) {
        setState(() {
          upcomingMovies.add(Movies(
              title: movie["title"],
                rating :  movie["vote_average"],
                 id: movie["id"],
              release_date: movie["release_date"],
              image: "https://image.tmdb.org/t/p/w500${movie['poster_path']}"));
        });
      }
    }
  }
  @override
  void initState() {
    getPopularMovieData();
    getTopRatedMovieData();
    getUpcomimgMovieData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget._tabController,
      children: [
        PopularMoviesPage(popularMovies: popularMovies),
        TopRatedMoviesPage(topRatedMovies: topRatedMovies),
        UpcomingMoviesPage(upcomingMovies: upcomingMovies)
      ],
    );
  }
}

