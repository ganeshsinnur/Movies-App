import 'package:alibaba/apis/api_related.dart';
import 'package:alibaba/models/top_rated.dart';
import 'package:alibaba/widgets/popular_movies_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/now_playing.dart';
import '../models/popular_movies.dart';
import '../widgets/now_playing_card.dart';
import '../widgets/top_rated.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<NowPlaying> nowPlaying;
  late Future<Popular> popularMovies;
  late Future<TopRated> topRated;

  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
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
          /*Padding(
            padding: const EdgeInsets.only(left: 25, right: 20),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),*/
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              height: 27,
              width: 27,
              color: Colors.blueAccent,
              child: Icon(Icons.person,color: Colors.black,size: 20,),
            ),
          ),
          const SizedBox(
            width: 25,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: topRated,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    /*Top Movies*/SizedBox(
                      height: 400,
                      child: TopMoviesCard(
                        future: topRated,
                        headline: "Top Rated",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*Popular Movies*/SizedBox(
                      height: 400,
                      child: PopMoviesCard(
                        future: popularMovies,
                        headline: "Popular",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*NowPlaying*/ SizedBox(
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

/*
class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Future<Popular> nowPlaying;
  late Future<Popular> popularMovies;
  late Future<Popular> topRated;

  ApiService apiService = ApiService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowPlaying = apiService.getNowPlaying();
    popularMovies = apiService.getPopularMovie();
    topRated =apiService.getTopRated();

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
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 20),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              height: 27,
              width: 27,
              color: Colors.blue,
            ),
          ),
          const SizedBox(
            width: 25,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: topRated ,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      // SizedBox(
                      //     height:400,child: PopMoviesCard(future: popularMovies, headline: "Popular")),
                      SizedBox(
                          height:400,child: PopMoviesCard(future: popularMovies, headline: "Top Rated")),
                      SizedBox(
                          height:400,child: PopMoviesCard(future: nowPlaying, headline: "Now Playing")),
                    ],
                  ) ;
        
                }),
          ],
        ),
      ),
    );
  }
}*/
