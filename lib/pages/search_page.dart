/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../apis/api_related.dart';
import '../models/search_model.dart';
import 'info_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiService apiServices = ApiService();
  Search? searchMovieModel;

  void search(String query) {
    apiServices.getSearch(query.replaceAll(' ', '+')).then((results) {
      setState(() {
        searchMovieModel = results;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CupertinoSearchTextField(
                controller: searchController,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    search(searchController.text);
                  } else {
                    setState(() {
                      searchMovieModel = null;
                    });
                  }
                },
              ),

            ),
            if (searchMovieModel != null)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: searchMovieModel?.results.length ?? 0,
                  itemBuilder: (context, index) {
                    var movie = searchMovieModel!.results[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: "$imageUrl${movie.backdropPath}",
                            height: 170,
                            width: 120,  // Adjust width as needed
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
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

                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.originalTitle,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  '${movie.releaseDate.substring(0,4)}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../apis/api_related.dart';
import '../data/datafunc.dart';
import '../data/datas.dart';
import '../models/mov_model.dart';
import '../models/search_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiService apiServices = ApiService();
  Search? searchMovieModel;

  void search(String query) {
    apiServices.getSearch(query.replaceAll(' ', '+')).then((results) {
      setState(() {
        searchMovieModel = results;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _addToWatchlist(WishlistMovies movie) {
    setState(() {
      if (!DataUtills.containId(watchList, movie.id)) {
        DataUtills.addMovieToWatchList(movie);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CupertinoSearchTextField(
                controller: searchController,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    search(searchController.text);
                  } else {
                    setState(() {
                      searchMovieModel = null;
                    });
                  }
                },
              ),
            ),
            if (searchMovieModel != null)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: searchMovieModel?.results.length ?? 0,
                  itemBuilder: (context, index) {
                    var movie = searchMovieModel!.results[index];
                    return Card(
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
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                    movie.originalTitle,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Release Year: ${movie.releaseDate.substring(0, 4)}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                       /* _addToWatchlist(
                                          WishlistMovies(
                                            backdropPath: movie.backdropPath ?? "",
                                            id: movie.id,
                                            originalTitle: movie.originalTitle,
                                            posterPath: movie.posterPath ?? "",
                                            releaseDate: DateTime.parse(movie.releaseDate),
                                            title: movie.title,
                                          ),
                                        );*/
                                        setState(() {
                                          if (watchList.isEmpty || !(DataUtills.containId(watchList, movie.id))) {
                                            //add movie to wishlist
                                            DataUtills.addMovieToWatchList(WishlistMovies(backdropPath: movie.backdropPath??"", id: movie.id, originalTitle: movie.originalTitle, posterPath: movie.posterPath??"", releaseDate:DateTime.parse(movie.releaseDate) , title: movie.title));

                                          }
                                          else if ((DataUtills.containId(watchList, movie.id))) {
                                            //remove movie from wishlist
                                            DataUtills.removeMovieFromWatchList(movie.id);

                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child:  Icon(
                                          watchList.isNotEmpty
                                              ? DataUtills.containId(watchList, movie.id)
                                              ? Icons.cancel : Icons.add_circle
                                              : Icons.add_circle,

                                          color:  watchList.isNotEmpty
                                              ? DataUtills.containId(watchList, movie.id)
                                              ? Colors.red : Colors.blue
                                              : Colors.blue,
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
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
