import 'dart:developer';

import 'package:flutter/material.dart';

import '../apis/api_related.dart';
import '../models/info_model.dart';

class InfoPage extends StatefulWidget {
  final int movieId;
  const InfoPage({super.key, required this.movieId});

  @override
  _InfoPage createState() => _InfoPage();
}

class _InfoPage extends State<InfoPage> {
  ApiService apiServices = ApiService();

  late Future<Info> movieDetail;
  // late Future<MovieRecommendationsModel> movieRecommendationModel;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    movieDetail = apiServices.getInfo(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(widget.movieId);
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Info"),
      )*/
      body: SingleChildScrollView(
        child: FutureBuilder<Info>(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final movie = snapshot.data;
              log("movie has data");
              String genresText =
              movie!.genres.map((genre) => genre.name).join(', ');

              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "$imageUrl${movie.posterPath}"),
                                fit: BoxFit.cover)),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: Text(
                                genresText,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                                overflow: TextOverflow.visible, // Allows text to wrap
                                softWrap: true, // Allows the text to break into multiple lines
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          movie.overview,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              );
            } else if (snapshot.hasError) {
              log("Error: ${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              log("No data");
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
