/*
import 'dart:developer';
import '../models/mov_model.dart';
import '../models/result_class.dart';
import 'datas.dart';

class DataUtills{
  static add_movie_to_wishlist(Result movie){
    myWatchlist.add(movie);
    log("added");
    log("${myWatchlist.length}");
  }
  static remove_movie_from_wishlist(Result movie){
    myWatchlist.removeWhere((item) => item.id == movie.id);
    log("removed");
    log("${myWatchlist.length}");
  }


  static containsId(List<Result> items, int id) {
    return items.any((item) => item.id == id);
  }

  static addMovieToWatchList(WishlistMovies movie) {
    watchList.add(movie);
    log("Added movie: ${movie.title}");
    log("Current watchlist: ${watchList[0].title}");
  }

  static removeMovieFromWatchList(int id){
    watchList.removeWhere((item) => item.id == id);
    log("removed");
    //log("$watchList");
  }


  static containId(List<WishlistMovies> items, int id) {
    log("${items.any((item) => item.id == id)}");
    return items.any((item) => item.id == id);
  }
}*/

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../data/datas.dart';
import '../models/mov_model.dart';

class DataUtills {
  static const String _keyWatchlist = 'watchlist';

  static bool containId(List<WishlistMovies> watchList, int id) {
    return watchList.any((movie) => movie.id == id);
  }

  static void addMovieToWatchList(WishlistMovies movie) async {
    watchList.add(movie);
    await _saveWatchlist();
  }

  static void removeMovieFromWatchList(int id) async {
    watchList.removeWhere((movie) => movie.id == id);
    await _saveWatchlist();
  }

  static Future<void> _saveWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      watchList.map((movie) => movie.toJson()).toList(),
    );
    await prefs.setString(_keyWatchlist, encodedData);
  }
}

