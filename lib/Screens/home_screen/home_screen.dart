import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db_provider/Data/my_tmdb_api/keys.dart';
import 'package:movie_db_provider/Provider/movies_provider.dart';
import 'package:movie_db_provider/Screens/home_screen/my_widgets/movie_widget.dart';
import 'package:movie_db_provider/Screens/movie_details/movie_details_screen.dart';
import 'package:movie_db_provider/Screens/search_screen/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context),
      backgroundColor: Colors.white10,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Hello  ${widget.userName} !",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 20),
                        ),
                      ),
                      Text(
                        "Welcome to MovieDB app",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.white60,
                              letterSpacing: .5,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider.value(
                                value: Provider.of<MovieProvider>(context),
                                child: const SearchScreen(),
                              )));
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.white60,
                      size: 28.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "Feature Movies",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.white, letterSpacing: .5, fontSize: 20),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<MovieProvider>(
                builder: (context, value, Widget? child) => myMovieTiles(value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView myMovieTiles(MovieProvider value) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      itemCount: value.treandingMovies.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        value.fatchTrendingMovie();
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(
                      movieName:
                          value.treandingMovies[index]['title'] ?? 'Loading',
                      movieDiscP:
                          value.treandingMovies[index]['overview'] ?? 'Loading',
                      imagePath: Keys.imageBasicPath +
                          value.treandingMovies[index]['poster_path'],
                      rating: value.treandingMovies[index]['vote_average']
                          .toString(),
                    )));
          },
          child: MovieWidget(
            imagePath: Keys.imageBasicPath +
                value.treandingMovies[index]['poster_path'],
            rating: value.treandingMovies[index]['vote_average'].toString(),
            movieName: value.treandingMovies[index]['title'] ?? 'Loading',
            deckP: value.treandingMovies[index]['overview'] ?? 'Loading',
          ),
        );
      },
    );
  }

  Drawer myDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.white, letterSpacing: .5, fontSize: 30),
                  ),
                ),
                Text(
                  "Edit Profile",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.white, letterSpacing: .5, fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Logout',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    color: Colors.black, letterSpacing: .5, fontSize: 20),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
