import 'dart:developer';

import 'package:alibaba/utils/common_utils.dart';
import 'package:alibaba/widgets/cast_row.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../apis/api_related.dart';
import '../models/cast_model.dart';
import '../models/hive/wishlist_model.dart';
import '../models/info_model.dart';

class DetailedInfoPage extends StatefulWidget {
  final int movieId;
  const DetailedInfoPage({super.key, required this.movieId});

  @override
  State<DetailedInfoPage> createState() => _DetailedInfoPage();
}

class _DetailedInfoPage extends State<DetailedInfoPage> {
  late Box<WishMovies> _wishlistBox;
  late Future<Info> movieInfo;
  late Future<Cast> movieCast;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    movieInfo = ApiService().getInfo(widget.movieId);
    movieCast = ApiService().getCastdetails(widget.movieId);
    _wishlistBox = Hive.box<WishMovies>('wishlistBox');
  }
  bool _isInWishlist(int id) {
    return _wishlistBox.containsKey(id);
  }
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: FutureBuilder(
          future: movieInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final movie = snapshot.data;
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black,
                                    Colors.black.withOpacity(0.0),
                                  ],
                                  stops: const [0.85, 1],
                                ).createShader(rect);
                              },
                              blendMode: BlendMode.dstATop,
                              child: Container(
                                height: mq.height * 0.4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(movie!.backdropPath != null
                                        ? "$imageUrl${movie.backdropPath}"
                                        : (movie.posterPath != "originalnull"
                                        ? "$imageUrl${movie.posterPath}"
                                        : "")),
                                    fit: BoxFit.cover,
                                    onError: (_, __) {
                                      // No action needed here since the error widget will handle this case.
                                    },
                                  ),
                                ),
                                child: SafeArea(
                                  child: Stack(
                                    children: [
                                      // Display an error icon if the image fails to load.
                                      if (movie.backdropPath == null && movie.posterPath == "originalnull")
                                        const Center(
                                          child: Icon(
                                            Icons.error_outline,
                                            color: Colors.grey,
                                            size: 50,
                                          ),
                                        ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 20,
                              child:Container(
                                padding: const EdgeInsets.all(8.0), // Adjust padding as needed
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width: 1.25, // Border thickness
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                  ), // Border radius
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      double.parse(movie.voteAverage.toStringAsFixed(1)) >= 9
                                          ? Icons.star
                                          : double.parse(movie.voteAverage.toStringAsFixed(1)) >= 5
                                          ? Icons.star_half
                                          : Icons.star_border, // Star icon
                                      color: Colors.yellow, // Star color
                                      size: 24, // Star size
                                    ),
                                    const SizedBox(width: 4), // Space between the star and the rating
                                    Text(
                                      movie.voteAverage.toStringAsFixed(1), // Rating formatted to 1 decimal place
                                      style: const TextStyle(
                                        fontSize: 18, // Text size
                                        fontWeight: FontWeight.bold, // Text weight
                                      ),
                                    ),
                                  ],
                                ),
                              )



                              /*Text(
                              'Rating: ${movie.voteAverage.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),*/)

                            /* ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black,
                                    Colors.black.withOpacity(0.0),
                                  ],
                                  stops: const [0.85, 1],
                                ).createShader(rect);
                              },
                              blendMode: BlendMode.dstATop,
                              child: Container(
                                height: mq.height * 0.4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(movie!.backdropPath != "originalnull"
                                        ? "$imageUrl${movie.backdropPath}"
                                        : "$imageUrl${movie.posterPath}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: SafeArea(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_back_ios, color: Colors.white),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),*/
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              /*if(movie.originalTitle!=movie.title)
                                Text(
                                  "(${movie.originalTitle})",
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),),*/
                              const SizedBox(height: 15),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: mq.width * 0.133),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today, color: Color(0xFF92929D), size: 16),
                                    const SizedBox(width: 4),
                                    const Text('2021', style: TextStyle(color: Color(0xFF92929D), fontSize: 15)),
                                    SizedBox(width: mq.width * 0.032),
                                    const Icon(Icons.access_time, color: Color(0xFF92929D), size: 16),
                                    const SizedBox(width: 4),
                                    Text(getTime(movie.runtime), style: const TextStyle(color: Color(0xFF92929D), fontSize: 15)),
                                    SizedBox(width: mq.width * 0.032),
                                    const Icon(Icons.movie, color: Color(0xFF92929D), size: 16),
                                    const SizedBox(width: 4),
                                    Text(movie.genres.isNotEmpty
                                        ?movie.genres[0].name
                                        :"Unknown!", style: const TextStyle(color: Color(0xFF92929D), fontSize: 15)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                movie.overview,
                                maxLines: _isExpanded ? null : 3,
                                overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: Text(
                                  _isExpanded ? "Read Less" : "Read More",
                                  style: const TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ),

                              const SizedBox(height: 20),
                              const Text("Cast", style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 10),
                              FutureBuilder(
                                  future: movieCast,
                                  builder: (context, snapshot) {
                                    return CastCard(future: movieCast);
                                  })
                            ],
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (!_isInWishlist(movie.id)) {
                              _wishlistBox.put(movie.id, WishMovies(
                                backdropPath: movie.backdropPath,
                                genreIds: movie.genres.map((genre) => genre.id).toList(),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isInWishlist(movie.id, _wishlistBox)
                              ? Colors.red
                              : Colors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          isInWishlist(movie.id, _wishlistBox) ? 'Remove from Wishlist' : 'Add to Wishlist',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            log("no data");
            return const Center(child: RefreshProgressIndicator());
          }),
    );
  }
}
