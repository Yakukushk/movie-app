import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Movie {
  final String name;
  final String description;
  final String bannerUrl;
  final String posterUrl;
  final String vote;
  final String launchOn;

  const Movie({
    Key? key,
    required this.name,
    required this.description,
    required this.bannerUrl,
    required this.posterUrl,
    required this.vote,
    required this.launchOn,
  });
}

class WishListProvider extends ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  void toggleFavorite(Movie movie) {
    final isExist = _movies.indexWhere((m) => m.name == movie.name);

    if (isExist != -1) {
      _movies.removeAt(isExist);
    } else {
      _movies.add(movie);
    }
    notifyListeners();
  }

  bool isExist(String name) {
    final isExist = _movies.any((movie) => movie.name == name);
    return isExist;
  }


  void clearValues() {
    _movies = [];
    notifyListeners();
  }

  static WishListProvider of(
      BuildContext context, {
        bool listen = true,
      }) {
    return Provider.of<WishListProvider>(
      context,
      listen: listen,
    );
  }
}

