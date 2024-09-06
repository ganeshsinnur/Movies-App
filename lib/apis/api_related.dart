import 'dart:convert';
import 'dart:developer';

import 'package:alibaba/models/cast_member_movies.dart';
import 'package:alibaba/models/top_rated.dart';

import '../models/cast_member.dart';
import '../models/cast_model.dart' as movieCast;
import '../models/info_model.dart';
import '../models/now_playing.dart';
import '../models/popular_movies.dart';
import 'package:http/http.dart' as http;

import '../models/search_model.dart';

const apiKey = "add your api key";
const imageUrl = "https://image.tmdb.org/t/p/original";
const baseUrl = "https://api.themoviedb.org/3/";
//var key = "?api_key=$apiKey";
const header = {
  'Authorization': "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYmQ3NmQ1MWNhMmFlZTRiYmYzNGU0OGM5OWJhZDg2YiIsIm5iZiI6MTcyMjE2Nzg1OS4yOTA1MjUsInN1YiI6IjY2YTUwODRhYTgwMjNhNjUyMTllYzU3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.65zvD6XGblbWVqukkzjNu2viV5vRK60tKy26Rxybmus"
};
late String endPoint;

class ApiService {


  //for getting popular movies
  Future<Popular> getPopularMovie() async {
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint";
    log(url);
    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      log("Popular api fetched");
      return Popular.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load the content");
  }


  //for getting Now Playing movies
  Future<NowPlaying> getNowPlaying() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint";
    final response = await http.get(Uri.parse(url), headers: header);


    if (response.statusCode == 200) {
      log("Now Playing api fetched");
      return NowPlaying.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load the content");
  }

  //for getting Top Rated movies
  Future<TopRated> getTopRated() async {
    endPoint = "movie/top_rated";
    final url = "$baseUrl$endPoint";
    final response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      log("Top Rated api fetched");
      return TopRated.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load the content");
  }

  //for Searching movies
  Future<Search> getSearch(String searchText) async {
    endPoint = "search/movie?query=${searchText.replaceAll(' ', '+')}";
    final url = "$baseUrl$endPoint";
    log("search url is $url");

    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      log("Search success");
     // log((response.body));
      return Search.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load the content");
  }

  //for detailed info
  Future<Info> getInfo(int movieId) async {
    endPoint = "movie/$movieId";
    final url = "$baseUrl$endPoint";
    //log("url=>$url");
    final response = await http.get(Uri.parse(url), headers: header);
    //log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("info fetched");
      return Info.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load the content");
  }

  //for cast members
  Future<movieCast.Cast> getCastdetails(int movieId) async {
    endPoint = "movie/$movieId/credits";
    final url = "$baseUrl$endPoint";
    log(url);
    final response = await http.get(Uri.parse(url), headers: header);
    //log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("cast fetched");
      return movieCast.Cast.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load content");
  }

  //for cast member info
  Future<Person> getPersonInfo(int movieId) async{
    endPoint="person/$movieId";
    final url ="$baseUrl$endPoint";
    final response= await http.get(Uri.parse(url),headers: header);
    if(response.statusCode==200){
      log("person info fetched");
      return Person.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Content");
  }

  //for cast member movies
  Future<PersonMovie> getPersonMovie(int movieId) async{
    endPoint="person/$movieId/movie_credits";
    final url ="$baseUrl$endPoint";
    log(url);
    final response= await http.get(Uri.parse(url),headers: header);
    if(response.statusCode==200){
      log("person info fetched");
      return PersonMovie.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Content");
  }

}
