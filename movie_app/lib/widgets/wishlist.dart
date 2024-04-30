import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/wishlist_provider.dart';
import '../utils/text.dart';
import 'description.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: Provider.of<WishListProvider>(context).getWishlist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Movie> movies = snapshot.data!;
          final provider = Provider.of<WishListProvider>(context, listen: false); // Define provider here
          return Scaffold(
            appBar: AppBar(
              title: Text("My favorite"),
            ),
            body: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(movie.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          name: movie.name,
                          bannerUrl: movie.bannerUrl,
                          posterUrl: movie.posterUrl,
                          description: movie.description,
                          vote: movie.vote,
                          launchOn: movie.launchOn,
                        ),
                      ),
                    );
                  },
                  trailing: IconButton(
                    onPressed: () {
                      provider.removeMovieFromWishlist(movie.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Your Item was removed"),
                        ),
                      );
                    },
                    icon: provider.isExist(movie.name)
                        ? const Icon(Icons.delete)
                        : const Icon(Icons.delete),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
