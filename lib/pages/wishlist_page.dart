import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../apis/api_related.dart';
import '../data/datafunc.dart';
import '../data/datas.dart';

class wishlistPage extends StatefulWidget {


  const wishlistPage({super.key});

  @override
  State<wishlistPage> createState() => _wishlistPageState();
}

class _wishlistPageState extends State<wishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: watchList.length,
        itemBuilder: (context, index) {
          var movie = watchList[index];
          return Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: "$imageUrl${movie.backdropPath}",
                    height: 150,
                    width: 100,
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
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.originalTitle,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Release Year: ${movie.releaseDate.year}',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: (){
                                setState(() {
                                  DataUtills.removeMovieFromWatchList(movie.id);
                                });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                              child: const Icon(Icons.cancel,color: Colors.red,) ,/*Text(
                                'Remove',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                              )*/
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


