import 'dart:developer';

import 'package:alibaba/apis/api_related.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/cast_member.dart';
import '../models/cast_member_movies.dart';
import 'info_final_page.dart';

class PersonPage extends StatefulWidget {
  final int personId;
  const PersonPage({super.key, required this.personId});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late Future<Person> personInfo;
  late Future<PersonMovie> personMovies;
  bool isExpanded = false;

  @override
  void initState() {
    personInfo = ApiService().getPersonInfo(widget.personId);
    personMovies = ApiService().getPersonMovie(widget.personId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        elevation: 1,
        backgroundColor: Colors.black,
        title: const Text(
          "Casting Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: personInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final person = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: mq.height * 0.4,
                    width: mq.width,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            child: CachedNetworkImage(
                              imageUrl: person!.profilePath != "null"
                                  ? "$imageUrl${person.profilePath}"
                                  : "https://via.placeholder.com/100",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            height: mq.height * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, // Centers the content vertically
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.cake, size: 25, color: Colors.grey),
                                const SizedBox(height: 2),
                                Text(
                                  person.deathday==null
                                      ? "Age: ${DateTime.now().year - person.birthday.year}yrs"
                                      :"Aged ${DateTime.now().year - person.deathday!.year}yrs",
                                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                                const Divider(color: Colors.grey, thickness: 2),
                                const Icon(Icons.person, size: 25, color: Colors.grey),
                                const SizedBox(height: 2),
                                Text(
                                  "Role: ${person.knownForDepartment}",
                                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                                const Divider(color: Colors.grey, thickness: 2),
                                Icon(
                                  person.gender == 2 ? Icons.male : Icons.female,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  person.gender == 2 ? 'Male' : 'Female',
                                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person.name,
                          style: const TextStyle(fontSize: 32, color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Biography",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final maxLines = isExpanded ? null : 3;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  person.biography,
                                  style: const TextStyle(fontSize: 15, color: Colors.white),
                                  maxLines: maxLines,
                                  overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Text(
                                    isExpanded ? "Read Less" : "Read More",
                                    style: const TextStyle(color: Colors.blue,fontSize: 15),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Movies",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        FutureBuilder(
                          future: personMovies,
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
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final castMovie = data[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailedInfoPage(movieId: castMovie.id,),
                                        ),
                                      );
                                    },
                                    child: Card(
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
                                              imageUrl: "$imageUrl${castMovie.posterPath}",
                                              height: 150,
                                              width: 100,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => const CircularProgressIndicator(
                                                color: Colors.transparent,
                                              ),
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
                                                    castMovie.title,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  if (castMovie.releaseDate.length >= 4)
                                                    Text(
                                                      'Release Year: ${castMovie.releaseDate.substring(0, 4)}',
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  const SizedBox(height: 8),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: RefreshProgressIndicator());
        },
      ),
    );
  }
}
