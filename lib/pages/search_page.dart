import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../apis/api_related.dart';
import '../models/hive/wishlist_model.dart';
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
  late Box<WishMovies> _wishlistBox;

  @override
  void initState() {
    super.initState();
    _wishlistBox = Hive.box<WishMovies>('wishlistBox');
  }

  bool _isInWishlist(int id) {
    return _wishlistBox.containsKey(id);
  }

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
            if (searchMovieModel != null && searchMovieModel!.results.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: searchMovieModel?.results.length ?? 0,
                  itemBuilder: (context, index) {
                    var movie = searchMovieModel!.results[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoPage(
                              movie: WishMovies(
                                backdropPath: movie.backdropPath ?? "",
                                genreIds: movie.genreIds,
                                id: movie.id,
                                originalLanguage: movie.originalLanguage,
                                originalTitle: movie.originalTitle,
                                overview: movie.overview,
                                posterPath: movie.posterPath ?? "",
                                releaseDate: DateTime.parse(movie.releaseDate),
                                title: movie.title,
                              ),
                            ),
                          ),
                        );
                      },
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
                                placeholder: (context, url) => const CircularProgressIndicator(
                                  color: Colors.transparent,
                                ),
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
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Release Year: ${movie.releaseDate.substring(0, 4)}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (!_isInWishlist(movie.id)) {
                                              _wishlistBox.put(
                                                movie.id,
                                                WishMovies(
                                                  backdropPath: movie.backdropPath ?? "",
                                                  genreIds: movie.genreIds,
                                                  id: movie.id,
                                                  originalLanguage: movie.originalLanguage,
                                                  originalTitle: movie.originalTitle,
                                                  overview: movie.overview,
                                                  posterPath: movie.posterPath ?? "",
                                                  releaseDate: DateTime.parse(movie.releaseDate),
                                                  title: movie.title,
                                                ),
                                              );
                                            } else if (_isInWishlist(movie.id)) {
                                              _wishlistBox.delete(movie.id);
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Icon(
                                            _isInWishlist(movie.id)
                                                ? Icons.cancel
                                                : Icons.add_circle,
                                            color: _isInWishlist(movie.id)
                                                ? Colors.red
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
                      ),
                    );
                  },
                ),
              ),
            if (searchMovieModel == null || searchMovieModel!.results.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
