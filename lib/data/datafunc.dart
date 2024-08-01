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
}