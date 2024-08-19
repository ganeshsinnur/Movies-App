import 'dart:developer';

import 'package:alibaba/apis/api_related.dart';
import 'package:alibaba/models/top_rated.dart';
import 'package:alibaba/widgets/popular_movies_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/now_playing.dart';
import '../models/popular_movies.dart';
import '../widgets/now_playing_card.dart';
import '../widgets/top_rated.dart';
import 'info_final_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Box? movieBox;

  late Future<NowPlaying> nowPlaying;
  late Future<Popular> popularMovies;
  late Future<TopRated> topRated;

  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    Hive.openBox('movieList').then((_box){setState(() {
      movieBox=_box;
    });});
    nowPlaying = apiService.getNowPlaying();
    popularMovies = apiService.getPopularMovie();
    topRated = apiService.getTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/images/logo.png",
          height: 120,
        ),
        actions: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              height: 27,
              width: 27,
              color: Colors.blueAccent,
              child: const Icon(Icons.person,color: Colors.black,size: 20,),
            ),
          ),
          const SizedBox(
            width: 25,
          )
        ],
      ),
      body: movieBox==null?const CircularProgressIndicator():SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: topRated,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    /*Top Movies*/
                    SizedBox(
                      height: 400,
                      child: TopMoviesCard(
                        future: topRated,
                        headline: "Top Rated",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /*Popular Movies*/
                    SizedBox(
                      height: 400,
                      child: PopMoviesCard(
                        future: popularMovies,
                        headline: "Popular",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /*NowPlaying*/
                    SizedBox(
                      height: 400,
                      child: NowPlayingCard(
                        future: nowPlaying,
                        headline: "Now Playing",
                      ),
                    ),

                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
