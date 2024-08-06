import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../apis/api_related.dart';
import '../models/hive/wishlist_model.dart';
import '../utils/common_utils.dart';

class InfoPage extends StatefulWidget {
  final WishMovies movie;

  const InfoPage({super.key, required this.movie});

  @override
  _InfoPage createState() => _InfoPage();
}

class _InfoPage extends State<InfoPage> {
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
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Stack(
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
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "$imageUrl${widget.movie.backdropPath}"),
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
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.originalTitle,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.releaseDate.year.toString(),
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Text(
                              getGenreNames(widget.movie.genreIds).join(', '),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 17,
                              ),
                              overflow: TextOverflow.visible,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        widget.movie.overview,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 16),
                      ),
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
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top:5),
              color: Colors.black.withOpacity(0.5),
              // Optional: Add a semi-transparent background
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    /*watchList.isEmpty || !(DataUtills.containId(watchList, movie.id))*/
                    if (!_isInWishlist(widget.movie.id)) {
                      // Add movie to wishlist box
                      _wishlistBox.put(widget.movie.id, WishMovies(
                        backdropPath: widget.movie.backdropPath,
                        genreIds: widget.movie.genreIds,
                        id: widget.movie.id,
                        originalLanguage: widget.movie.originalLanguage,
                        originalTitle: widget.movie.originalTitle,
                        overview: widget.movie.overview,
                        posterPath: widget.movie.posterPath,
                        releaseDate: widget.movie.releaseDate,
                        title: widget.movie.title,
                      ));
                    } else if (_isInWishlist(widget.movie.id)) {
                      _wishlistBox.delete(widget.movie.id);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  //foregroundColor: Colors.white,
                  backgroundColor: _isInWishlist(widget.movie.id)
                      ?Colors.red
                      :Colors.yellow, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  minimumSize: const Size(
                      double.infinity, 50), // Full width button
                ),
                child: Text(
                  _isInWishlist(widget.movie.id) ?
                  'Remove from Wishlist' : 'Add to Wishlist',
                  style: const TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
