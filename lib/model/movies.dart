class Movies {
  Movies(
      {required this.title,
      required this.image,
      required this.release_date,
      required this.rating,
      required this.id,
      this.synopsis = "",
      this.budget = 0,
      this.original_title = "",
      this.premier = "",
      this.revenue = 0,
      this.runtime = 0,
      this.status = "",
      this.homepage = "",
      this.genres = ""
      });
  final String title;
  final String image;
  final String release_date;
  final dynamic rating;
  final int id;
  String synopsis;
  String original_title;
  String status;
  var runtime;
  String premier;
  var budget;
  var revenue;
  String homepage;
  String genres;
}
