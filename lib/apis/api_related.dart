import 'dart:convert';
import 'dart:developer';

import 'package:alibaba/models/top_rated.dart';

import '../models/now_playing.dart';
import '../models/popular_movies.dart';
import 'package:http/http.dart' as http;

import '../models/search_model.dart';

const apiKey="bbd76d51ca2aee4bbf34e48c99bad86b";
const imageUrl="https://image.tmdb.org/t/p/original";
const baseUrl="https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

class ApiService{
  Future<Popular> getPopularMovie() async{
    endPoint="movie/popular";
    final url="$baseUrl$endPoint$key";

    final response=await http.get(Uri.parse(url));

    if(response.statusCode==200){
      log("Popular api fetched");
      return Popular.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load the content");
}

  Future<NowPlaying> getNowPlaying() async{
    endPoint="movie/now_playing";
    final url="$baseUrl$endPoint$key";

    final response=await http.get(Uri.parse(url));

    if(response.statusCode==200){
      log("Now Playing api fetched");
      return NowPlaying.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load the content");
  }

  Future<TopRated> getTopRated() async{
    endPoint="movie/top_rated";
    final url="$baseUrl$endPoint$key";
    // log("$url");

    final response=await http.get(Uri.parse(url));

    if(response.statusCode==200){
      log("Top Rated api fetched");
      return TopRated.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load the content");
  }

  Future<Search> getSearch(String searchText) async{
    endPoint="search/movie?query=${searchText.replaceAll(' ', '+')}";
    final url="$baseUrl$endPoint";
     log("search url is $url");

    final response=await http.get(Uri.parse(url),headers: {'Authorization':"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYmQ3NmQ1MWNhMmFlZTRiYmYzNGU0OGM5OWJhZDg2YiIsIm5iZiI6MTcyMjE2Nzg1OS4yOTA1MjUsInN1YiI6IjY2YTUwODRhYTgwMjNhNjUyMTllYzU3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.65zvD6XGblbWVqukkzjNu2viV5vRK60tKy26Rxybmus"});

    if(response.statusCode==200){
      log("Search success");
      log((response.body));
      return Search.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load the content");
  }


}
