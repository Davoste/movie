import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goojara/Play.dart';
import 'package:goojara/firebase_options.dart';
import 'package:goojara/movie.dart';
import 'package:goojara/services/services.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List> nowShowing;
  late Future<List> upComing;
  late Future<List> popularMovies;
  late Future<List> searchMovies;

  @override
  void initState() {
    nowShowing = APIservices().getNowShowing();
    upComing = APIservices().getUpComing();
    popularMovies = APIservices().getPopular();
    searchMovies = APIservices().getPopular();

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
            Spacer(), // Add some space between text and search bar
            SizedBox(
              height: 35,
              width: 150, // Reduce height of the TextField
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true, // To enable background color
                  fillColor: Colors.white, // Background color of the text field
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Browse",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Movies",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Series",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            FutureBuilder(
              future: nowShowing,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final movies = snapshot.data!;

                  return GridView.builder(
                    shrinkWrap: true, // Prevent overflow
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable GridView scroll
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2.0, // Reduce vertical spacing
                      crossAxisSpacing: 2.0, // Reduce horizontal spacing
                      childAspectRatio: 0.7, // Control height/width ratio
                    ),
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoviePage(
                                      movieID: movie.movieID,
                                    )),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit
                                      .cover, // Ensures image fits correctly
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/original/${movie.posterPath}"),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.blue[100],
                                child: Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.grey),
            const SizedBox(height: 5),
            const Divider(color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () {},
                  child: const Text('Recent',
                      style: TextStyle(color: Colors.white)),
                ),
                const Text("Popular"),
                const Text("Genre"),
                const Text("Year"),
                const Text("A-Z"),
              ],
            ),
            const Divider(color: Colors.grey),
            FutureBuilder(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final movies = snapshot.data!;
                  return ListView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scrolling
                    shrinkWrap: true, // Prevent overflow
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Row(
                        children: [
                          Icon(Icons.local_movies,
                              color: Colors.amber.shade800),
                          Text(movie.title),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.fiber_dvr_rounded, color: Colors.blue),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            const Divider(color: Colors.grey),
            Container(
              color: Colors.blue,
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      "BASK Group",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.fiber_dvr_rounded, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
