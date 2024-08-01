
import 'dart:developer';
import 'package:alibaba/models/now_playing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../apis/api_related.dart';
import '../data/datafunc.dart';
import '../data/datas.dart';
import '../models/mov_model.dart';

class NowPlayingCard extends StatefulWidget {
  final Future<NowPlaying> future;
  final String headline;

  NowPlayingCard({super.key, required this.future, required this.headline});

  @override
  _NowPlayingCardState createState() => _NowPlayingCardState();
}

class _NowPlayingCardState extends State<NowPlayingCard> {
// Set to keep track of wishlist items

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NowPlaying>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          log("Error in ${widget.headline}: ${snapshot.error}");
          return Center(child: Text('Error loading data: ${snapshot.error}'));
        } else
        if (!snapshot.hasData || snapshot.data?.results.isEmpty == true) {
          log("${widget.headline} has no data");
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
                    return Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(15)),
                            child: CachedNetworkImage(
                              imageUrl: "$imageUrl${movie.posterPath ?? ""}",
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Container(
                                width: 200,
                                color: Colors.white10,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 200,
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
                              watchList.isNotEmpty
                                  ? DataUtills.containId(watchList, movie.id)
                                  ? Icons.bookmark : Icons.bookmark_outline
                                  : Icons.bookmark_outline,
                              color: watchList.isNotEmpty
                                  ? DataUtills.containId(watchList, movie.id)
                                  ? Colors.blueAccent : Colors.white : Colors
                                  .white,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                if (watchList.isEmpty || !(DataUtills.containId(watchList, movie.id))) {
                                  //add movie to wishlist
                                  DataUtills.addMovieToWatchList(WishlistMovies(backdropPath: movie.backdropPath, id: movie.id, originalTitle: movie.originalTitle, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title));

                                }
                                else if ((DataUtills.containId(watchList, movie.id))) {
                                  //remove movie from wishlist
                                  DataUtills.removeMovieFromWatchList(movie.id);

                                }
                              });
                            },
                          ),
                        ),
                      ],
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


/*import 'dart:developer';
import 'package:flutter/material.dart';
import '../apis/api_related.dart';
import '../data/datafunc.dart';
import '../data/datas.dart';
import '../models/now_playing.dart';

class NowPlayingCard extends StatefulWidget {
  final Future<NowPlaying> future;
  final String headline;

  NowPlayingCard({super.key, required this.future, required this.headline});

  @override
  _NowPlayingCardState createState() => _NowPlayingCardState();
}

class _NowPlayingCardState extends State<NowPlayingCard> {
 // Set to keep track of wishlist items

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NowPlaying>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          log("Error in ${widget.headline}: ${snapshot.error}");
          return Center(child: Text('Error loading data: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data?.results.isEmpty == true) {
          log("${widget.headline} has no data");
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
                    //final isWishlisted = _wishlist.contains(movie.id);
                    return Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              "$imageUrl${movie.posterPath}",
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Container(
                                    width: 200,
                                    color: Colors.white10,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              myWatchlist.isNotEmpty
                                  ?DataUtills.containsId(myWatchlist,movie.id)
                                  ? Icons.bookmark : Icons.bookmark_outline:Icons.bookmark_outline,
                              color: myWatchlist.isNotEmpty
                                  ?DataUtills.containsId(myWatchlist,movie.id)
                                  ?  Colors.blueAccent: Colors.white:Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                *//*if (myWatchlist.isEmpty||!(DataUtills.containsId(myWatchlist,movie.id))) {
                                  //add movie to wishlist
                                  DataUtills.add_movie_to_wishlist(movie);
                                } else if(myWatchlist.isNotEmpty&&(DataUtills.containsId(myWatchlist,movie.id))){
                                  //remove movie from wishlist
                                  DataUtills.remove_movie_from_wishlist(movie);

                                }*//*
                              });
                            },
                          ),
                        ),
                      ],
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


}*/
