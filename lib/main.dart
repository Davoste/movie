import 'package:flutter/material.dart';
import 'package:goojara/movie.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            const Text(
              "GOOJARA.to",
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(), // Add some space between text and search bar
            SizedBox(
              height: 35,
              width: 150, // Reduce height of the TextField
              child: const TextField(
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
      body: Column(
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

          Row(
            //other movies
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(500)),
                      child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXWhR_s9i_DWP8y0Xnyef4iO8aEjmf4dicxw&s',
                          fit: BoxFit.fill,
                          height: 150),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MoviePage()));
                    }),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(500)),
                  child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEFovDMtyL48glDa4b4JoIEW137rOrE18EYQ&s',
                      fit: BoxFit.fill,
                      height: 150),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQA00WlnIbOk-nye1j87skCGOodsuXLcs3pw&s',
                      fit: BoxFit.fill,
                      height: 150),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),

          //second row
          Row(
            //other movies
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXWhR_s9i_DWP8y0Xnyef4iO8aEjmf4dicxw&s',
                    fit: BoxFit.fill,
                    height: 150),
              ),
              Expanded(
                flex: 1,
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEFovDMtyL48glDa4b4JoIEW137rOrE18EYQ&s',
                    fit: BoxFit.fill,
                    height: 150),
              ),
              Expanded(
                flex: 1,
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQA00WlnIbOk-nye1j87skCGOodsuXLcs3pw&s',
                    fit: BoxFit.fill,
                    height: 150),
              ),
            ],
          ),
          const Divider(color: Colors.grey),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                onPressed: () {},
                child: const Text(
                  'Recent',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Text("Popular"),
              const Text("Genre"),
              const Text("Year"),
              const Text("A-Z"),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Icon(
                Icons.local_movies,
                color: Colors.amber.shade800,
              ),
              const Text("You Gotta Believe"),
              const Icon(
                Icons.fiber_dvr_rounded,
                color: Colors.blue,
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Icon(
                Icons.local_movies,
                color: Colors.amber.shade800,
              ),
              const Text("Hounds of War"),
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.fiber_dvr_rounded,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  const TextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: const TextField(
        decoration:
            InputDecoration(border: InputBorder.none, hintText: 'Search'),
      ),
    );
  }
}
