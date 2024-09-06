import 'dart:developer';

import 'package:alibaba/apis/api_related.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/cast_model.dart';
import '../pages/cast_person_page.dart';

class CastCard extends StatefulWidget {
  final Future<Cast> future;

  const CastCard({super.key, required this.future});

  @override
  State<CastCard> createState() => _CastCardState();
}

class _CastCardState extends State<CastCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          log("Error: ${snapshot.error}");
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData || snapshot.data!.cast.isEmpty) {
          log("No data available");

          return const Center(child: SizedBox());
        } else {
          var data = snapshot.data!.cast;
         // log("Cast data: ${data.map((e) => e.toJson()).toList()}");
          return SizedBox(
            height: 185, // Set the height you want for the list
            child: ListView.builder(
              itemCount: data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final castMember = data[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>PersonPage(personId: castMember.id,),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 93.22, // Set the width you want for each item
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            child: CachedNetworkImage(
                              imageUrl: castMember.profilePath != null
                                  ? "$imageUrl${castMember.profilePath}"
                                  : "https://via.placeholder.com/100", // Placeholder image
                              fit: BoxFit.cover,
                              height: 140,
                              width: 93.22,
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            castMember.name,
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
