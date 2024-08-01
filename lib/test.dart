/*

import 'package:alibaba/data/datas.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../apis/api_related.dart';

class wishlistPage extends StatefulWidget {
  const wishlistPage({super.key});

  @override
  State<wishlistPage> createState() => _WishlistPage();
}

class _WishlistPage extends State<wishlistPage> {
  //TextEditingController searchController = TextEditingController();
  ApiService apiServices = ApiService();
  //Search? searchMovieModel;

  */
/* void search(String query) {
    apiServices.getSearch(query.replaceAll(' ', '+')).then((results) {
      setState(() {
        searchMovieModel = results;
      });
    });
  }*/
/*


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: watchList.length,
                itemBuilder: (context, index) {
                  var movie = watchList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: "$imageUrl${movie.backdropPath}",
                          height: 170,
                          width: 120,  // Adjust width as needed
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.originalTitle,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                '${movie.releaseDate.year}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
