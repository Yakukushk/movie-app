
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String id;
  final String name;
  final String description;
  final String bannerUrl;
  final String posterUrl;
  final String vote;
  final String launchOn;

  const Movie({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.bannerUrl,
    required this.posterUrl,
    required this.vote,
    required this.launchOn,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'bannerUrl': bannerUrl,
      'posterUrl': posterUrl,
      'vote': vote,
      'launchOn': launchOn,
    };
  }
}

class WishListProvider extends ChangeNotifier {
  List<Movie> _movies = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _userId;
  WishListProvider() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _userId = user?.uid;
      notifyListeners();
    });
  }
  List<Movie> get movies => _movies;
  String? errorMessage = '';



  // void toggleFavorite(Movie movie) {
  //   final isExist = _movies.indexWhere((m) => m.name == movie.name);
  //
  //   if (isExist != -1) {
  //     _movies.removeAt(isExist);
  //   } else {
  //     _movies.add(movie);
  //   }
  //   notifyListeners();
  // }
  Future<List<Movie>> getWishlist() async {
    try {
      final querySnapshot = await _firestore
          .collection('wishlist')
          .where('userId', isEqualTo: _userId)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Movie(
          id: doc.id,
          name: data['name'],
          description: data['description'],
          bannerUrl: data['bannerUrl'],
          posterUrl: data['posterUrl'],
          vote: data['vote'],
          launchOn: data['launchOn'],
        );
      }).toList();
    } catch (error) {
      print("Error getting wishlist: $error");
      return [];
    }
  }


  Future<void> addMovieToWishlist(Movie movie) async {
    try {
      await _firestore.collection('wishlist').add({
        ...movie.toJson(),
        'userId': _userId,
      });
      // Remaining code...
    } catch (error) {
      print("Error adding movie to wishlist: $error");
    }
  }

  Future<void> removeMovieFromWishlist(String movieID) async {
    try {
      await _firestore.collection('wishlist').doc(movieID).delete();
      notifyListeners();
    } on FirebaseException catch (e) {
      errorMessage = e.message;
      print(errorMessage);
    }
  }

  bool isExist(String name) {
    final isExist = _movies.any((movie) => movie.name == name);
    return isExist;
  }

  void clearValues() {
    _movies = [];
    notifyListeners();
  }

  static WishListProvider of(BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<WishListProvider>(
      context,
      listen: listen,
    );
  }
}
