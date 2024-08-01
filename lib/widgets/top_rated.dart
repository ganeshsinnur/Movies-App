import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../apis/api_related.dart';
import '../data/datafunc.dart';
import '../data/datas.dart';
import '../models/mov_model.dart';
import '../models/top_rated.dart';

class TopMoviesCard extends StatefulWidget {
  final Future<TopRated> future;
  final String headline;

  TopMoviesCard({super.key, required this.future, required this.headline});

  @override
  _TopMoviesCardState createState() => _TopMoviesCardState();
}

class _TopMoviesCardState extends State<TopMoviesCard> {
  Set<int> _wishlist = {}; // Set to keep track of wishlist items

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopRated>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data: ${snapshot.error}'));
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
                    _wishlist.contains(movie.id);
                    return Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                            /*Image.network(
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
                            ),*/
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





/*  void _handleWishlistToggle(Movie movie) {
    // Implement wishlist logic here
    log('${movie.title} wishlist status toggled');
  }
}*/

/*void _addToWishlist(Movie movie) {
    // Implement wishlist logic here
    log('Added ${movie.title} to wishlist');
  }*/

/*
import 'dart:developer';

import 'package:alibaba/apis/api_related.dart';
import 'package:alibaba/models/popular_movies.dart';
import 'package:alibaba/models/top_rated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TopMoviesCard extends StatelessWidget {
  final Future<TopRated> future;
  final String headline;

  TopMoviesCard({super.key, required this.future, required this.headline});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopRated>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          log("Error in $headline: ${snapshot.error}");
          return Center(child: Text('Error loading data: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data?.results.isEmpty == true) {
          log("$headline has no data");
          return const Center(child: Text('Loading'));
        } else {
          var data = snapshot.data?.results;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  headline,
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
                    return Container(
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        child: Image.network(
                          "$imageUrl${data[index].posterPath}",
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

*/

/*class PopMoviesCard extends StatelessWidget {
  final Future<Popular> future;
  String headline;

  PopMoviesCard({super.key, required this.future, required this.headline});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Popular>(future: future, builder: (context, snapshot) {
      if(snapshot.hasData) {
        var headlineText = headline;
        var data = snapshot.data?.results;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:15),
              child: Text(headlineText, style: const TextStyle(fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 22,),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                  itemCount: data!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // border:Border.all(color: CupertinoColors.white)

                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.network("$imageUrl${data[index].posterPath}",fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                          if(loadingProgress==null){return child;}
                          else{
                            return Container(
                              width: 200,
                              color: Colors.white10, // Black shade background while loading
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

                    );
                  }),
            )
          ],);
      }
      else {
        log("$headline not worked");
        return const SizedBox.shrink();

      }
    });
  }

}*/

