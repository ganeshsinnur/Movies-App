import 'package:alibaba/pages/info_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../apis/api_related.dart';
import '../models/hive/wishlist_model.dart';
import '../models/top_rated.dart';
import '../pages/info_final_page.dart';

class TopMoviesCard extends StatefulWidget {
  final Future<TopRated> future;
  final String headline;

  const TopMoviesCard({super.key, required this.future, required this.headline});

  @override
  _TopMoviesCardState createState() => _TopMoviesCardState();
}

class _TopMoviesCardState extends State<TopMoviesCard> {
  late Box<WishMovies> _wishlistBox;

  @override
  void initState() {
    super.initState();
    _wishlistBox = Hive.box<WishMovies>('wishlistBox');
  }



  bool _isInWishlist(int id) {
    return _wishlistBox.containsKey(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopRated>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error in loading'));
        } else if (!snapshot.hasData || snapshot.data?.results.isEmpty == true) {
          return const Center(child: Text('No data available'));
        } else {
          var data = snapshot.data?.results;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  widget.headline,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: data!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final movie = data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                            DetailedInfoPage(movieId: movie.id,)  ,
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
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              child: CachedNetworkImage(
                                imageUrl: "$imageUrl${movie.posterPath}",
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Container(
                                  width: 215,
                                  color: Colors.white10,
                                  child: const Center(
                                    child: CircularProgressIndicator(color: Colors.transparent,),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 215,
                                  color: Colors.white10,
                                  child: const Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                            _isInWishlist(movie.id)
                                    ? Icons.bookmark : Icons.bookmark_outline,
                                color: _isInWishlist(movie.id)
                                    ? Colors.blueAccent : Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (!_isInWishlist(movie.id)) {
                                    // Add movie to wishlist box
                                    _wishlistBox.put(movie.id, WishMovies(
                                      backdropPath: movie.backdropPath,
                                      genreIds: movie.genreIds,
                                      id: movie.id,
                                      originalLanguage: movie.originalLanguage,
                                      originalTitle: movie.originalTitle,
                                      overview: movie.overview,
                                      posterPath: movie.posterPath,
                                      releaseDate: movie.releaseDate,
                                      title: movie.title,
                                    ));
                                  } else if (_isInWishlist(movie.id)) {
                                    _wishlistBox.delete(movie.id);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
