import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../apis/api_related.dart';
import '../models/hive/wishlist_model.dart';
import 'info_page.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Box<WishMovies>? movieBox;
  late List<WishMovies> watchList = [];

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    movieBox = await Hive.openBox<WishMovies>('wishlistBox');
    _loadWatchlist();
  }

  void _loadWatchlist() {
    setState(() {
      if (movieBox != null) {
        watchList = movieBox!.values.toList();
      }
    });
  }

  void _removeFromWishlist(WishMovies movie) {
    setState(() {
      movieBox?.delete(movie.id);
      watchList.removeWhere((item) => item.id == movie.id);
      log('Removed movie with ID: ${movie.id}');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/images/logo.png",
          height: 120,
        ),
      ),
      backgroundColor: Colors.black,
      body: movieBox == null
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder(
        valueListenable: movieBox!.listenable(),
        builder: (context, Box<WishMovies> box, _) {
          final moviesKeys = box.keys.toList();
          log("$moviesKeys");
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: watchList.length,
            itemBuilder: (context, index) {
              var movie = watchList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => InfoPage(
                        movie: WishMovies(
                          backdropPath: movie.backdropPath,
                          genreIds: movie.genreIds,
                          id: movie.id,
                          originalLanguage: movie.originalLanguage,
                          originalTitle: movie.originalTitle,
                          overview: movie.overview,
                          posterPath: movie.posterPath,
                          releaseDate: movie.releaseDate,
                          title: movie.title,
                        ),
                      ),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); // Start from the right
                        const end = Offset.zero; // End at the current position
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                }
                ,
                child: Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: "$imageUrl${movie.posterPath}",
                          height: 150,
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(color: Colors.transparent,),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Release Year: ${movie.releaseDate.year}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    _removeFromWishlist(movie);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
