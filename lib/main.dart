import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goojara/Play.dart';
import 'package:goojara/ads.dart';
import 'package:goojara/firebase_options.dart';
import 'package:goojara/movie.dart';
import 'package:goojara/services/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'dart:html' as html;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
  late BannerAd _bannerAd;
  bool isBannerAdReady = false;
  late InterstitialAd _interstitialAd;
  bool isInterstitialAdReady = false;

  @override
  void initState() {
    nowShowing = APIservices().getNowShowing();
    upComing = APIservices().getUpComing();
    popularMovies = APIservices().getPopular();
    searchMovies = APIservices().getPopular();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-6014490259749638/6339796268',
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(
            () {
              isBannerAdReady = true;
            },
          );
        },
        onAdFailedToLoad: (ad, error) {
          isBannerAdReady = false;
        },
      ),
      request: AdRequest(),
    );
    _bannerAd.load();
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-6014490259749638/4643571214',
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(
            () {
              _interstitialAd = ad;
              isInterstitialAdReady = true;
            },
          );
        },
        onAdFailedToLoad: (error) {
          isInterstitialAdReady = false;
        },
      ),
      request: AdRequest(),
    );

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    if (isBannerAdReady) {
      _interstitialAd.dispose();
    }
  }

  void _showInterstialAd() {
    if (isInterstitialAdReady) {
      _interstitialAd.show();
      _interstitialAd.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        setState(() {
          isInterstitialAdReady = false;
        });
        //load new ad
        InterstitialAd.load(
          adUnitId: 'ca-app-pub-6014490259749638/4643571214',
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              setState(
                () {
                  _interstitialAd = ad;
                  isInterstitialAdReady = true;
                },
              );
            },
            onAdFailedToLoad: (error) {
              isInterstitialAdReady = false;
            },
          ),
          request: AdRequest(),
        );
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        setState(() {
          isInterstitialAdReady = false;
        });
      });
    }
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
      bottomNavigationBar: isBannerAdReady
          ? SizedBox(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : SizedBox.shrink(),
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
                GestureDetector(
                    onTap: () {
                      _showInterstialAd();
                      _webBannerAd();
                    },
                    child: const Text("Popular")),
                GestureDetector(
                    onTap: () {
                      _showInterstialAd();
                      BannerAdUnit();
                    },
                    child: const Text("Genre")),
                GestureDetector(
                    onTap: () {
                      _showInterstialAd();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BannerAdUnit()),
                      );
                    },
                    child: const Text("Year")),
                GestureDetector(
                    onTap: () {
                      _showInterstialAd();
                    },
                    child: const Text("A-Z")),
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

Widget _webBannerAd() {
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
      'adViewType',
      (int viewID) => html.IFrameElement()
        ..width = '320'
        ..height = '100'
        ..src = 'index.html'
        ..style.border = 'none');

  return SizedBox(
    height: 100.0,
    width: 320.0,
    child: HtmlElementView(
      viewType: 'adViewType',
    ),
  );
}
