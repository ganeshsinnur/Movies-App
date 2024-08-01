import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mov_model.dart';

class WatchlistStorage {
  static const String _keyWatchlist = 'watchlist';

  Future<void> saveWatchlist(List<WishlistMovies> watchList) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      watchList.map((movie) => movie.toJson()).toList(),
    );
    await prefs.setString(_keyWatchlist, encodedData);
  }

  Future<List<WishlistMovies>> loadWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_keyWatchlist);
    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      return decodedData.map((json) => WishlistMovies.fromJson(json)).toList();
    }
    return [];
  }
}
