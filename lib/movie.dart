import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

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
          const Row(
            children: [
              Text("Movies", style: TextStyle(color: Colors.blue)),
              Icon(
                Icons.arrow_forward,
                color: Colors.blue,
              ),
              Text(
                "Name of movie",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          const Divider(color: Colors.grey),
          Row(
            children: [
              Expanded(
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXWhR_s9i_DWP8y0Xnyef4iO8aEjmf4dicxw&s',
                    fit: BoxFit.fill,
                    height: 300),
              ),
            ],
          )
        ],
      ),
    );
  }
}
