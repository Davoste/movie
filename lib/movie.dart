import 'package:flutter/material.dart';
import 'package:goojara/Play.dart';
import 'package:goojara/model.dart';
import 'package:goojara/services/services.dart';

class MoviePage extends StatefulWidget {
  final int movieID; // Use 'final' for immutability
  const MoviePage({super.key, required this.movieID});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late Future<Map<String, dynamic>>
      movieDetails; // Expecting a single movie details map

  @override
  void initState() {
    movieDetails =
        APIservices().details(widget.movieID) as Future<Map<String, dynamic>>;
    // Pass movieID to details method
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Row(
          children: [
            Text(
              "GOOJARA.to",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(), // Add space between the title and search field
            SizedBox(
              height: 35,
              width: 150, // Reduce the width of the search bar
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true, // Enable background color for search bar
                  fillColor: Colors.white,
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Perform search action
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: movieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Movie:",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_forward, color: Colors.blue),
                      const SizedBox(width: 5),
                      Text(
                        movie['title'] ?? 'N/A',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Stack(children: [
                    Container(
                      child: movie['poster_path'] != null
                          ? Image.network(
                              "https://image.tmdb.org/t/p/w500/${movie['poster_path']}",
                              fit: BoxFit.cover,
                              height: 300,
                            )
                          : const SizedBox(
                              height: 300,
                              child: Center(child: Text('No image available')),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Player()),
                        );
                      },
                      child: const Positioned(
                          child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.play_circle_fill_sharp,
                          color: Colors.blue,
                          size: 100,
                        ),
                      )),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Text(
                    movie['overview'] ?? 'No overview available',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
