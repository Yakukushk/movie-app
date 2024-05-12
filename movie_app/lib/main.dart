import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movie_search.dart';
import 'package:movie_app/widgets/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/provider/wishlist_provider.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/toprated.dart';
import 'package:movie_app/widgets/tv.dart';
import 'package:movie_app/widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app/widgets/widget_tree.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => WishListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        theme: ThemeData(
            brightness: Brightness.dark, primaryColor: Colors.green),
      ),


    );

  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List movies = [];
  List topRatedMovie = [];
  List tvMovie = [];
  final String apiKey = 'a079795b4b362d40868ae4bc28e68659';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMDc5Nzk1YjRiMzYyZDQwODY4YWU0YmMyOGU2ODY1OSIsInN1YiI6IjY1YTZiOTlhYWQ1MGYwMDEyNWFkMWQ4NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6P_3mLfok1RQX3aAImgeIfmQs27Q-44HAemvCitg4Hk';

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    Map tredingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      movies = tredingResult['results'];
      topRatedMovie = topRatedResult['results'];
      tvMovie = tvResult['results'];
    });
    print(movies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_box, size: 30,),
            tooltip: 'Open shopping cart',
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (context) => const WidgetTree(),
              );
              Navigator.push(context, route);
            },
          ),
          IconButton(onPressed: () {
            final route = MaterialPageRoute(builder: (context) => MovieSearchScreen(),
            );
            Navigator.push(context, route);
          }, icon: const Icon(Icons.search, size: 30,))
        ],
        title: modifieldText(
          text: 'Flutter MovieApp',
          color: Colors.white,
          size: 20.00,
        ),
      ),
      body: Stack( // Wrap the content in a Stack
        children: [

          ListView(
            children: [
              // Your existing list items go here
              TopTVShow(tvShow: tvMovie),
              TrendingMovies(trending: movies),
              TopRateMovies(topRate: topRatedMovie),
            ],
          ),
          Positioned(
            bottom: 50,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      final route = MaterialPageRoute(
                        builder: (context) => const FavoritePage(),
                      );
                      Navigator.push(context, route);
                    },
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
