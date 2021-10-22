import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_provider/Data/my_tmdb_api/keys.dart';
import 'package:movie_db_provider/Provider/movies_provider.dart';
import 'package:movie_db_provider/Screens/movie_details/movie_details_screen.dart';
import 'package:movie_db_provider/Screens/search_screen/search_movie_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextField(
                        onSubmitted: (value) {
                          Provider.of<MovieProvider>(context, listen: false)
                              .searchMovies(value);
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Movie Name',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Consumer<MovieProvider>(
                  builder: (context, value, Widget? child) =>
                      searchedMovieList(value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView searchedMovieList(MovieProvider value) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      itemCount: value.searchedMovies.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(
                      movieName:
                          value.searchedMovies[index]['title'] ?? 'Loading',
                      movieDiscP:
                          value.searchedMovies[index]['overview'] ?? 'Loading',
                      imagePath: value.searchedMovies[index]['poster_path'] ==
                              null
                          ? "https://www.cssauthor.com/wp-content/uploads/2015/03/Movies-Text-Effect-PSD.jpg"
                          : Keys.imageBasicPath +
                              value.searchedMovies[index]['poster_path'],
                      rating: value.searchedMovies[index]['vote_average']
                          .toString(),
                    )));
          },
          child: SearchMovieWidget(
            imagePath: value.searchedMovies[index]['poster_path'] == null
                ? "https://www.cssauthor.com/wp-content/uploads/2015/03/Movies-Text-Effect-PSD.jpg"
                : Keys.imageBasicPath +
                    value.searchedMovies[index]['poster_path'],
            rating: value.searchedMovies[index]['vote_average'].toString(),
            movieName: value.searchedMovies[index]['title'] ?? 'Loading',
            deckP: value.searchedMovies[index]['overview'] ?? 'Loading',
          ),
        );
      },
    );
  }
}
