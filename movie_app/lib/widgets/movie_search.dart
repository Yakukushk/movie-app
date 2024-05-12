import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'description.dart';

class MovieSearchScreen extends StatefulWidget {
  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}
class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResult = [];
  final String apiKey = 'a079795b4b362d40868ae4bc28e68659';
  void _searchMovies(String query) async{
     final response = await http.get(Uri.parse(
    'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query'));
     if(response.statusCode == 200) {
       final decodedResponse = json.decode(response.body);
       setState(() {
         _searchResult = decodedResponse['results'];
       });
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchMovies(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                final movie = _searchResult[index];
                return ListTile(
                  title: Text(movie['title']),
                  subtitle: Text(movie['overview']),
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                    width: 50,
                  ),
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => Description(
                         name: movie['title'],
                         description: movie['overview'],
                         bannerUrl: 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
                         posterUrl: 'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                         vote: movie['vote_average'].toString(),
                         launchOn: movie['release_date'],
                       ),
                     ),
                   );
                 },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}