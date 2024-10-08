
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../models/hive/wishlist_model.dart';

const Map<int, String> genreMap = {
  28: 'Action',
  12: 'Adventure',
  16: 'Animation',
  35: 'Comedy',
  80: 'Crime',
  99: 'Documentary',
  18: 'Drama',
  10751: 'Family',
  14: 'Fantasy',
  36: 'History',
  27: 'Horror',
  10402: 'Music',
  9648: 'Mystery',
  10749: 'Romance',
  878: 'Science Fiction',
  10770: 'TV Movie',
  53: 'Thriller',
  10752: 'War',
  37: 'Western',
  // Add more genres as needed
};

List<String> getGenreNames(List<int> genreIds) {
  return genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
}

bool isInWishlist(int id, Box<WishMovies> box) {
  return box.containsKey(id);
}
String getTime(int time) {
  int hr = time ~/ 60;
  int min = time % 60;
  return"${hr}hr ${min}min";
}